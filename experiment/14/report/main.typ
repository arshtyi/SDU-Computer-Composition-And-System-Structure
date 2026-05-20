#import "@preview/numbly:0.1.0": numbly
#import "@preview/pointless-size:0.1.2": zh, zihao

#let fonts = (main: "Source Han Serif SC", mono: "IBM Plex Mono", cjk: "Noto Serif CJK SC")
#let institute = "计算机科学与技术"
#let course = "计算机组成与设计"
#let author = "彭靖轩"
#let id = "202400130242"
#let class = "24智能"
#let date = datetime.today()
#let title = "实验14-微程序控制的加减法器设计"
#let time = "2"

#set document(title: title, author: author, date: date)
#set text(font: (fonts.main, fonts.cjk), size: zh(5), lang: "zh", region: "cn")
#set par(justify: true, first-line-indent: (amount: 2em, all: true))
#set page(
    paper: "a4",
    margin: (x: 35pt, y: 35pt),
    footer: align(center, context counter(page).display("- 1 -")),
)
#set heading(numbering: numbly("", "{2:1}.", "({3:1})"))
#show heading: set text(size: zh(-4))
#{
    set underline(offset: 2.5pt, extent: 2.5pt)
    show heading: it => align(center, text(tracking: .1em, size: zh(-2), it))
    heading(numbering: none, level: 1)[山东大学 #underline[#institute] 学院\ #underline[#course] 课程实验报告]
    set text(size: zh(-4))
    set table.cell(inset: .5em, align: left + horizon, stroke: 1pt)
    table(
        columns: (3fr, 2.5fr, 3fr),
        [学号：#id], [姓名：#author], [班级：#class],
    )
    v(0em, weak: true)
    table(
        columns: 1fr,
        [实验题目：#title],
    )
    v(0em, weak: true)
    table(
        columns: (1fr,) * 2,
        [实验学时：#time], [实验日期：#date.display("[year].[month].[day]")],
    )
}
#show raw: set text(font: (fonts.mono, fonts.cjk))
#set enum(numbering: numbly("{1:1})", "{2:a}."))
#set list(indent: 6pt, marker: sym.bullet.tri)

#let in-block(body) = {
    let is-level-1-heading(it) = (
        it.func() == heading
            and (
                it.at("level", default: none) == 1
                    or (it.at("offset", default: none) + it.at("depth", default: none) == 1)
            )
    )

    let text-block(it) = {
        v(0em, weak: true)
        block(
            width: 100%,
            inset: (x: 4pt, y: 1em),
            stroke: 1pt,
            breakable: true,
            it,
        )
    }

    let children = body.at("children", default: (body,))
    let content = ()
    let buf = ()

    for child in children {
        if is-level-1-heading(child) {
            if buf.len() > 0 {
                content.push(text-block(buf.join()))
                buf = ()
            }
            buf.push(child)
        } else if buf.len() > 0 {
            buf.push(child)
        } else {
            content.push(child)
        }
    }
    if buf.len() > 0 {
        content.push(text-block(buf.join()))
    }
    content.join()
}
#show: in-block

= 实验目的
- 掌握微程序控制器的基本组成和微指令控制字段的设计方法.
- 理解用ROM存放微程序、用微指令寄存器分离控制信号的工作过程.
- 掌握4位加减法器、通用寄存器和移位输出部件在微程序控制下协同工作的设计方法.
- 通过PYNQ-Z2开发板观察微程序逐拍执行结果，验证控制字编码和数据通路连接的正确性.

= 实验软件和硬件环境
- 软件环境
    - Vivado 2024.2
- 硬件环境
    - PYNQ-Z2

= 实验原理和方法
== 实验原理
本实验设计一个4位微程序控制的加减法器。微程序存放在`rom1_256x24`中，`m74LS161`作为微地址计数器，计数输出经`addr_adpt`形成ROM地址。ROM输出的24位微指令在`UIR`中锁存，再拆分为立即数、寄存器写控制、移位控制和加减法控制信号，控制数据通路逐拍完成装数、加法、移位和减法.

微指令格式如下表所示.

#set table.cell(inset: .45em, align: center + horizon, stroke: 0.6pt)
#table(
    columns: (1fr, 1fr, auto),
    table.header([位段], [符号], [作用]),
    [`[15:8]`], [`a7..a0`], [立即数字段。本实验为4位运算，工程中通过`xlslice`取低4位作为寄存器输入.],
    [`[7]`], [`C0`], [加法器最低位进位输入.],
    [`[6]`], [`CPR0`], [寄存器`R0`写入控制.],
    [`[5]`], [`CPR1`], [寄存器`R1`写入控制.],
    [`[4]`], [`CPR2`], [结果寄存器`R2`写入控制.],
    [`[3]`], [`LM`], [对加法器输出左移一位后写入.],
    [`[2]`], [`DM`], [加法器输出直通写入.],
    [`[1]`], [`RM`], [对加法器输出右移一位后写入.],
    [`[0]`], [`K`], [减法控制信号.],
)
#set table.cell(inset: .5em, align: left + horizon, stroke: 1pt)

`adder4`根据`K`选择运算方式：当`K=0`时输出`A+B`；当`K=1`时输出`A+~B+C0`。因此执行`R0-R1`时应同时置位`K`和`C0`，利用补码形式得到`A+~B+1`. `shifter`根据`LM`、`DM`、`RM`选择左移、直通或右移结果，其中未被选择的通路输出为0，三路结果按位或后送入`R2`.

时序上，按键时钟经`adpt_in`转换后驱动微地址计数器和ROM，反相时钟驱动`UIR`锁存微指令，并与`CPR0`、`CPR1`、`CPR2`相与后分别作为三个4位寄存器的写入时钟。这样每条微指令在一个按键周期内稳定地产生控制信号，并只写入被当前控制字选中的寄存器.

== 实验方法
在Vivado中使用给定Verilog模块和ROM初始化文件搭建Block Design。用`m74LS161`顺序产生微地址，用`rom1_256x24`输出控制字，用`UIR`锁存并分配控制信号；将`R0`和`R1`作为加法器输入，将加法器输出经`shifter`送入`R2`，最后由`adpt_out`把`R2`的4位结果连接到LED4-LED1。生成比特流并上传至PYNQ-Z2后，通过复位键和时钟键逐拍观察LED显示值.

= 实验步骤
+ 编写并加入`adpt_in`、`adpt_out`、`addr_adpt`、`UIR`、`m74LS161`、`rom1_256x24`、`adder4`、`dff4`和`shifter`等模块.
+ 根据微程序要求建立24位宽ROM，并将`data.coe`写入ROM初始化内容:

    #set table.cell(inset: .45em, align: center + horizon, stroke: 0.6pt)
    #table(
        columns: (1fr, 1.8fr, 4fr),
        table.header([地址], [控制字], [功能]),
        [`0`], [`00AA40`], [`R0 <- A`，置`CPR0`，把立即数字段低4位`A`写入`R0`.],
        [`1`], [`005520`], [`R1 <- 5`，置`CPR1`，把立即数字段低4位`5`写入`R1`.],
        [`2`], [`000014`], [`R2 <- R0 + R1`，置`CPR2`和`DM`.],
        [`3`], [`000018`], [`R2 <- (R0 + R1) << 1`，置`CPR2`和`LM`.],
        [`4`], [`000012`], [`R2 <- (R0 + R1) >> 1`，置`CPR2`和`RM`.],
        [`5`], [`000095`], [`R2 <- R0 - R1`，置`C0`、`CPR2`、`DM`和`K`.],
    )
    #set table.cell(inset: .5em, align: left + horizon, stroke: 1pt)

+ 在Block Design中连接数据通路：`R0`和`R1`输出连接至`adder4`的`A`、`B`输入，`adder4`输出连接至`shifter`输入，`shifter`输出连接至`R2`输入，`R2`输出连接至LED显示接口.
+ 连接控制通路：`m74LS161`的4位输出作为低4位微地址，高4位地址接0；ROM输出送入`UIR`；`UIR`输出的`C0`、`K`、`LM`、`DM`、`RM`和`CPR0..CPR2`分别连接对应模块控制端.
+ 生成综合、实现和比特流，将工程下载至PYNQ-Z2开发板. 复位后逐次按下时钟键，记录LED4-LED1显示结果.

= 实验结果与结论
实验中逐拍执行ROM内6条微指令，LED4-LED1显示`R2`的当前值。由于前两拍分别向`R0`和`R1`装入操作数，`R2`尚未被写入；从第三条有效运算微指令开始，结果如下.

#set table.cell(inset: .45em, align: center + horizon, stroke: 0.6pt)
#table(
    columns: (1fr, 1.8fr, 3.2fr, 1.2fr),
    table.header([CLK], [控制字], [运算], [LED结果]),
    [`2`], [`00AA40`], [`R0 <- A`], [`--`],
    [`3`], [`005520`], [`R1 <- 5`], [`--`],
    [`4`], [`000014`], [`R2 <- A + 5`], [`F`],
    [`5`], [`000018`], [`R2 <- (A + 5) << 1`], [`E`],
    [`6`], [`000012`], [`R2 <- (A + 5) >> 1`], [`7`],
    [`7`], [`000095`], [`R2 <- A - 5`], [`5`],
)
#set table.cell(inset: .5em, align: left + horizon, stroke: 1pt)

各项结果与4位补码运算预期一致：`A+5=F`；左移一位时只保留低4位，`F << 1 = E`；右移一位得到`7`；减法控制字置`K=C0=1`，因此`A-5`按`A+~5+1`计算得到`5`. 实验说明ROM控制字、微指令寄存器、寄存器写使能、加减法器和移位输出通路连接正确，实现了微程序控制下的4位加减和移位运算.
