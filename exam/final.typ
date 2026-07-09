#import "@preview/ezexam:0.3.1": *
#import "@preview/zero:0.6.1": num, set-num, set-unit, zi
#import "@preview/cetz:0.5.2"
#import "@preview/zap:0.6.0"

#show: setup.with(
    mode: EXAM,
    resume: false,
    heading-top: 0em,
    heading-bottom: .4em,
    line-height: .65em,
    par-spacing: .65em,
    enum-spacing: .65em,
    list-spacing: .65em,
)
#set par(justify: true)
#show strong: set text(weight: "bold")
#let Title = "山东大学计算机科学与技术学院计算机组成与体系结构期末考试"
#let author = "arshtyi"
#let date = datetime.today()
#set document(title: Title, date: date, author: author)
#title(Title)
#exam-info(info: (
    班级: "24数据·24智能",
    教师: "马博洋",
    时间: datetime(year: 2026, month: 7, day: 9).display("[year].[month].[day]"),
    源码: link("https://github.com/arshtyi/SDU-Computer-Composition-And-System-Structure", "link"),
))
#set-unit(fraction: "power")
#let (K, MHz, bit, byte, ns, bit-s) = (
    zi.declare("K"),
    zi.declare("MHz"),
    zi.declare("bit"),
    zi.declare("byte"),
    zi.declare("ns"),
    zi.declare("bit/s"),
)
#let question = question.with(supplement: "Q", ref-on: true, show-ref-prefix: false)
#let paren = paren.with(placeholder: none)
#let fillin = fillin.with(placeholder: none)
#let choices = choices.with(r-gap: .5em)
#show raw: set text(font: "JetBrains Mono")
#show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: .3em, y: 0em),
    outset: (x: 0em, y: .3em),
    radius: .2em,
)

= 单选
#question[
    设某机的CPU主频为#MHz[8]，每个机器周期平均含$2$个时钟周期，每条指令的指令周期平均含$2.5$个机器周期，则该机的平均指令执行速度为#paren[]MIPS。
    #choices[$0.25$][$0.2$][$1.6$][$0.625$]
]
#question[
    浮点运算结果规格化的主要作用是#paren[]。
    #choices[判断运算结果是否溢出][对齐两个操作数的小数点][减少运算步骤，提高运算速度][充分利用尾数的有效位，提高运算精度]
]
#question[
    采用不恢复余数法进行原码除法时，运算结束后在下列哪种情况下需要恢复余数#paren[]。
    #choices[最后一次所得余数为正][最后一次所得余数为负][最后一次所得余数为零][任何情况下均不需要]
]
#question[
    若I/O端口与主存单元统一编址，则CPU对I/O端口进行输入输出操作时使用的指令是#paren[]。
    #choices[控制指令][访存指令][专用I/O指令][算术逻辑指令]
]
#question[
    I/O接口中，临时存放CPU与外部设备之间交换的数据、实现二者速度匹配的部件是#paren[]。
    #choices[设备状态寄存器][数据缓冲寄存器DBR][命令寄存器和命令译码器][设备选择电路]
]
#question[
    DMA接口中的中断机构的作用是#paren[]。
    #choices[完成数据传送][向CPU申请总线使用权][一批数据传送结束时向CPU发出中断请求][处理硬件故障等异常情况]
]
#question[
    图示链式排队器中，中断源$1$至$4$的优先级依次降低，排队输出高电平有效。某时刻$"INTR"_2$和$"INTR"_3$同时提出中断请求，其余中断源无请求，则有效的排队输出信号为#paren[]。
    #figure(zap.circuit({
        import zap: *
        import cetz.draw: content, line

        let out-arrow(node, label) = {
            line(
                node,
                (to: node, rel: (0, .7)),
                mark: (end: ">", fill: black, stroke: (thickness: 0pt)),
            )
            content((to: node, rel: (0, .95)), label, anchor: "south")
        }

        lnot("not1", (0, 0), angle: 90deg, inputs: 1)
        lnot("not2", (2.4, 0), angle: 90deg, inputs: 1)
        lnot("not3", (4.8, 0), angle: 90deg, inputs: 1)
        lnot("not4", (7.2, 0), angle: 90deg, inputs: 1)

        lnot("not5", (0, -2), angle: 90deg, inputs: 1)
        lnand("and1", (2.4, -2), angle: 90deg, inputs: 2)
        lnand("and2", (4.8, -2), angle: 90deg, inputs: 3)
        lnand("and3", (7.2, -2), angle: 90deg, inputs: 4)

        out-arrow("not1.out", $"INTP"_1$)
        out-arrow("not2.out", $"INTP"_2$)
        out-arrow("not3.out", $"INTP"_3$)
        out-arrow("not4.out", $"INTP"_4$)

        sstub("not5.in1", label: $"INTR"_1$)
        sstub("and1.in2", label: $"INTR"_2$)
        sstub("and2.in3", label: $"INTR"_3$)
        sstub("and3.in4", label: $"INTR"_4$)

        zwire("not5.out", "not1.in1", name: "w_not5_not1")
        zwire("and1.out", "not2.in1", name: "w_and1_not2")
        zwire("and2.out", "not3.in1", name: "w_and2_not3")
        zwire("and3.out", "not4.in1", name: "w_and3_not4")

        node("j1", "w_not5_not1.line.50%")
        node("j2", "w_and1_not2.line.50%")
        node("j3", "w_and2_not3.line.50%")

        wire(
            "and3.in1",
            (rel: (0, -.6)),
            (rel: (-5.4, 0)),
            (horizontal: (), vertical: "j1"),
            "j1",
            name: "w_and3_j1",
        )
        node("j4", "w_and3_j1.line.30%")
        zwire("and2.in1", "j4")
        node("j5", "w_and3_j1.line.53.7%")
        zwire("and1.in1", "j5")
        wire(
            "and3.in2",
            (rel: (0, -.4)),
            (rel: (-3.4, 0)),
            (horizontal: (), vertical: "j2"),
            "j2",
            name: "w_and3_j2",
        )
        node("j6", (horizontal: "and2.in2", vertical: "w_and3_j2.p2"))
        zwire("and2.in2", "j6")
        wire(
            "and3.in3",
            (rel: (0, -.2)),
            (rel: (-1.4, 0)),
            (horizontal: (), vertical: "j3"),
            "j3",
        )
    }))
    #choices[$"INTP"_1$][$"INTP"_2$][$"INTP"_3$][$"INTP"_2$和$"INTP"_3$]
]
#question[
    主存按字节编址，Cache共有$64$块，采用$4$路组相联映射，块大小为#byte[32]，Cache各组从$0$开始编号。主存地址为$2000$（十进制）的字节单元所在主存块映射到的Cache组号为#paren[]。
    #choices[$15$][$1$][$14$][$62$]
]
#question[
    一条采用相对寻址的转移指令长#byte[3]，第一字节为操作码，第二、三字节组成用补码表示的$16$位相对位移量。CPU每取出一个字节后均自动执行`PC + 1 -> PC`。若取指前`PC = 3000H`，该地址处的指令JMP \* L（\*表示相对寻址）的目标地址为`2FF8H`，则该指令第二、三字节组成的相对位移量为#paren[]。
    #choices[`FFF5H`][`FFF6H`][`FFF7H`][`FFF8H`]
]
#question[
    某机指令字长为$8$位，指令格式#figure(cetz.canvas({
        import cetz.draw: *

        let h = 0.7
        let w1 = 1.4
        let w2 = 1.0
        let w3 = 1.4

        let x0 = 0
        let x1 = w1
        let x2 = w1 + w2
        let x3 = w1 + w2 + w3

        rect((x0, 0), (x3, h), stroke: 0.8pt)
        line((x1, 0), (x1, h), stroke: 0.8pt)
        line((x2, 0), (x2, h), stroke: 0.8pt)

        content((x0 + w1 / 2, h / 2), [OP])
        content((x1 + w2 / 2, h / 2), [I])
        content((x2 + w3 / 2, h / 2), [A])

        let y_label = h + 0.25
        let d = 0.3

        content((x0 + d, y_label), $0$)
        content((x1 - d, y_label), $3$)
        content((x1 + w2 / 2, y_label), $4$)
        content((x2 + d, y_label), $5$)
        content((x3 - d, y_label), $7$)
    }))其中I为间接寻址标志（$0$表示直接寻址，$1$表示一次间接寻址）。主存各单元的地址和内容如下（均为十六进制）：
    #figure(table(
        columns: 9,
        inset: 10pt,
        [地址], [`00`], [`01`], [`02`], [`03`], [`04`], [`05`], [`06`], [`07`],
        [内容], [`01`], [`5E`], [`9D`], [`74`], [`A4`], [`15`], [`04`], [`A0`],
    ))则编码为`DEH`的指令的有效地址为#paren[]。
    #choices[`07H`][`A0H`][`04H`][`02H`]
]
#question[
    某机有五级中断$L_4,L_3,L_2,L_1,L_0$，屏蔽字格式为$M_4M_3M_2M_1M_0$（$M_i=1$表示屏蔽）。响应优先级由高到低为$L_0->L_1->L_2->L_3->L_4$，处理优先级由高到低为$L_4->L_0->L_2->L_1->L_3$。则$L_2$中断服务程序应设置的屏蔽字为#paren[]。
    #choices[$11110$][$01110$][$00011$][$01010$]
]
#question[
    设数据位$D_4D_3D_2D_1=1110$，按偶校验原则配置$(7,4)$汉明码。校验位$P_1,P_2,P_4$依次置于码字的第$1,2,4$位，码字按$P_1P_2D_4P_4D_3D_2D_1$排列，则所得汉明码为#paren[]。
    #choices[$1010110$][$0110110$][$0010110$][$1111110$]
]
#question[
    假定CPU响应中断时已经自动关中断。从保护断点开始，实现多重中断的操作顺序为#paren[]。
    #set enum(numbering: "①")
    + 保护现场
    + 中断返回
    + 开中断
    + 处理中断
    + 关中断
    + 保护断点
    + 恢复现场
    #choices[⑥①③④⑤⑦③②][⑥①④③⑤⑦③②][⑥③①④⑤⑦③②][⑥①③④⑦⑤③②]
]
#question[
    一个存储体由$8$个存储模块组成，每个模块的字长为#bit[16]、存取周期为#ns[320]，数据总线宽度为#bit[16]、总线传输周期为#ns[40]。在顺序方式和低位交叉方式下分别连续读出$8$个字时，两者的平均带宽依次为#paren[]（单位：#bit-s()）。
    #choices[#num[5e8],#num[2.13e8]][#num[2.13e7],#num[5e7]][#num[5e7],#num[2.13e8]][#num[2.13e8],#num[5e7]]
]
#question[
    指令功能为`R2 <- R1 + M[R0]`，两个源操作数分别采用寄存器寻址和寄存器间接寻址。在取操作数及执行阶段（不计取指和译码阶段），必须使用的部件有#paren[]。
    #set enum(numbering: "①")
    + 通用寄存器组
    + 算术逻辑单元
    + 存储器
    + 指令译码器
    #choices[仅①②][仅①②③][仅②③④][仅①③④]
]
#question[
    下列关于中断隐指令的说法，错误的是#paren[]。
    #choices[用于关中断并保护断点（程序返回地址）][不是指令系统中的一条可执行指令][由硬件自动完成][用于恢复现场并完成中断返回]
]
#question[
    微程序控制器中的微指令存放在#paren[]。
    #choices[主存储器][高速缓冲存储器][外存储器][控制存储器（控存）]
]
#question[
    与微程序控制器相比，硬布线（组合逻辑）控制器的特点是#paren[]。
    #choices[执行速度慢，扩展和修改容易][执行速度慢，扩展和修改困难][执行速度快，扩展和修改容易][执行速度快，扩展和修改困难]
]
#question[
    在硬布线（组合逻辑）控制器中，微操作控制信号的产生与下列哪项无关#paren[]。
    #choices[指令操作码][时序信号][指令地址][状态条件]
]
= 简答
#question[
    设$x=19/32 times 2^5, quad y=-45/64 times 2^6$。字长自行确定，按浮点运算计算$[x+y]_"补"$并还原其真值。
]
#question[
    设某机的指令字长为#bit[16]，每个地址码字段长#bit[6]，操作码采用扩展编码。现已设计$12$条二地址指令和$96$条一地址指令。
    + 最多还有多少条零地址指令？
    + 若将其余可用编码全部用于零地址指令，并假定每条已定义指令的使用频率相同，则该指令系统的平均操作码长度是多少？
]
#question[
    设一台$8$位机按字节编址，CPU共有$16$根地址线和$8$根数据线，并用#overline[MREQ]（低电平有效）作访存控制信号，用R/#overline[W]作读#sym.slash 写控制信号（高电平为读，低电平为写）。现有如下存储芯片：RAM（$#K[2]times#bit[8]$、$#K[4]times#bit[4]$、$#K[8]times#bit[8]$），ROM（$#K[2]times#bit[8]$、$#K[8]times#bit[8]$），以及74138译码器和其他门电路。要求地址$0tilde.op 8191$为系统程序区（ROM），$8192 tilde.op 32767$为用户程序区（RAM），最高地址端的#K[4]地址空间为系统程序工作区（RAM）；以上均为十进制。
    + 指出所选存储芯片的类型和数量。
    + 画出CPU与各存储芯片的连接图，标明地址线、数据线、读#sym.slash 写控制线及片选逻辑。
    + 运行时发现，无论向哪一片RAM芯片写入数据，以地址$8192$为起始地址的RAM芯片中相应单元都会写入相同的数据。试分析可能的故障原因。
]
#question[
    下图为某机的单总线数据通路，其中M为主存，XR为变址寄存器，EAR为有效地址寄存器，X为运算器输入暂存器，LATCH为运算结果锁存器。指令记作`SUB X,D`，其中记号X表示采用XR变址寻址，D为形式地址；其功能为`EA <- (XR) + D, (ACC) - M[EA] -> (ACC)`。假定待执行指令的地址已存于PC中，一次主存读操作可在一个节拍内完成，且互不冲突的微操作允许在同一节拍并行。写出该指令从取指周期开始直至执行结束的微操作流程，并按最少节拍给出节拍安排（或相应的控制信号序列）。
    #figure(layout(size => {
        let bus-width = 12.5
        zap.circuit(length: size.width / bus-width, {
            import zap: *
            import cetz.draw: anchor, content, group, line, rect

            let port-count(ports, side) = ports.at(side, default: 0)
            let interpolate(start, end, factor) = start + (end - start) * factor
            let interpolate-point(start, end, factor) = (
                interpolate(start.at(0), end.at(0), factor),
                interpolate(start.at(1), end.at(1), factor),
            )
            let add-side-ports(side, count, start, end) = {
                assert(count >= 0, message: "port count must be non-negative")
                let midpoint = interpolate-point(start, end, .5)
                if count != 1 { anchor(side, midpoint) }

                for index in range(count) {
                    let factor = (index + 1) / (count + 1)
                    let position = interpolate-point(start, end, factor)
                    anchor(side + str(index + 1), position)
                    if count == 1 { anchor(side, position) }
                }
            }
            let datapath-block(
                name,
                position,
                label,
                width: .72,
                height: .42,
                ports: (:),
                font-size: 10pt,
                stroke: black + 1pt,
                fill: white,
                ..options,
            ) = {
                let draw-block(_context, _nodes, _style) = {
                    interface((-width / 2, -height / 2), (width / 2, height / 2))
                    rect((-width / 2, -height / 2), (width / 2, height / 2), stroke: stroke, fill: fill)

                    if label != none {
                        content((0, 0), text(size: font-size, label), anchor: "center")
                    }

                    add-side-ports("n", port-count(ports, "n"), (-width / 2, height / 2), (width / 2, height / 2))
                    add-side-ports("s", port-count(ports, "s"), (-width / 2, -height / 2), (width / 2, -height / 2))
                    add-side-ports("w", port-count(ports, "w"), (-width / 2, height / 2), (-width / 2, -height / 2))
                    add-side-ports("e", port-count(ports, "e"), (width / 2, height / 2), (width / 2, -height / 2))
                }

                symbol("datapath-block", name, position, draw: draw-block, stroke: stroke, fill: fill, ..options)
            }
            let alu-block(
                name,
                position,
                label,
                width: 1.9,
                height: .85,
                bottom-width: .9,
                notch-depth: .28,
                notch-width: .36,
                ports: (:),
                north-split: auto,
                font-size: 10pt,
                stroke: black + 1pt,
                fill: white,
                ..options,
            ) = {
                let draw-alu(_context, _nodes, _style) = {
                    let top-y = height / 2
                    let bottom-y = -height / 2
                    let half-notch-width = notch-width / 2
                    let north-port-count = port-count(ports, "n")
                    let split = if north-split == auto {
                        (calc.ceil(north-port-count / 2), calc.floor(north-port-count / 2))
                    } else {
                        north-split
                    }

                    assert(split.at(0) + split.at(1) == north-port-count, message: "north-split must add up to ports.n")
                    interface((-width / 2, bottom-y), (width / 2, top-y))

                    line(
                        (-width / 2, top-y),
                        (-half-notch-width, top-y),
                        (0, top-y - notch-depth),
                        (half-notch-width, top-y),
                        (width / 2, top-y),
                        (bottom-width / 2, bottom-y),
                        (-bottom-width / 2, bottom-y),
                        close: true,
                        stroke: stroke,
                        fill: fill,
                    )

                    if label != none {
                        content((0, -0.06), text(size: font-size, label), anchor: "center")
                    }

                    let north-left-count = split.at(0)
                    let north-right-count = split.at(1)
                    anchor("n", (0, top-y - notch-depth))

                    for index in range(north-left-count) {
                        let factor = (index + 1) / (north-left-count + 1)
                        anchor(
                            "n" + str(index + 1),
                            interpolate-point((-width / 2, top-y), (-half-notch-width, top-y), factor),
                        )
                    }
                    for index in range(north-right-count) {
                        let factor = (index + 1) / (north-right-count + 1)
                        anchor(
                            "n" + str(north-left-count + index + 1),
                            interpolate-point((half-notch-width, top-y), (width / 2, top-y), factor),
                        )
                    }

                    add-side-ports(
                        "s",
                        port-count(ports, "s"),
                        (-bottom-width / 2, bottom-y),
                        (bottom-width / 2, bottom-y),
                    )
                    add-side-ports("w", port-count(ports, "w"), (-width / 2, top-y), (-bottom-width / 2, bottom-y))
                    add-side-ports("e", port-count(ports, "e"), (width / 2, top-y), (bottom-width / 2, bottom-y))
                }

                symbol("datapath-alu", name, position, draw: draw-alu, stroke: stroke, fill: fill, ..options)
            }
            let arrow(
                ..path,
                name: none,
                stroke: black + 1pt,
                tip: ">",
                tip-scale: 1,
                arrowheads: "end",
            ) = {
                let points = path.pos()
                assert(points.len() >= 2, message: "arrow needs at least two points")
                assert(
                    arrowheads in ("none", "start", "end", "both"),
                    message: "arrowheads must be none, start, end, or both",
                )

                let mark-style = if arrowheads == "none" {
                    none
                } else {
                    (
                        start: if arrowheads == "start" or arrowheads == "both" { tip } else { none },
                        end: if arrowheads == "end" or arrowheads == "both" { tip } else { none },
                        fill: black,
                        stroke: stroke,
                        scale: tip-scale,
                    )
                }

                let draw-arrow() = {
                    anchor("start", points.first())
                    anchor("end", points.last())

                    for (index, point) in points.enumerate() {
                        anchor("point" + str(index), point)
                    }

                    line(
                        ..points,
                        name: "line",
                        stroke: stroke,
                        mark: mark-style,
                    )
                }

                if name == none { draw-arrow() } else { group(name: name, { draw-arrow() }) }
            }

            line((0, 0), (bus-width, 0), stroke: black + 2pt)
            line((0, -.12), (bus-width, -.12), stroke: black + 1pt)

            datapath-block("acc", (1, -1), "ACC", ports: (e: 2, s: 1, n: 1))
            datapath-block("mq", (2.5, -1), "MQ", ports: (w: 2, s: 1, n: 1))
            datapath-block("x-register", (4, -1), "X", ports: (s: 1, n: 1))
            datapath-block("ir", (5.5, -1), "IR", ports: (s: 1, n: 1))
            datapath-block("pc", (7, -1), "PC", ports: (s: 1, n: 1))
            datapath-block("xr", (8.5, -1), "XR", ports: (s: 1, n: 1))
            datapath-block("mar", (10, -1), "MAR", ports: (s: 1, n: 1))
            datapath-block("mdr", (11.5, -1), "MDR", ports: (s: 2, n: 1))
            alu-block(
                "alu",
                (2.5, -3.5),
                "ALU",
                width: 2,
                bottom-width: 1,
                ports: (n: 2, s: 2, e: 1),
                north-split: (1, 1),
            )
            alu-block(
                "address-adder",
                (7, -3.5),
                "地址加法器",
                width: 2.5,
                bottom-width: 1,
                height: 1,
                ports: (n: 3, e: 1, s: 1),
                north-split: (1, 2),
            )
            datapath-block("status", (1, -5), "状态", ports: (e: 1))
            datapath-block("latch", (2.5, -6), "LATCH", width: 1.2, ports: (n: 1, s: 1))
            datapath-block("k1-input", (horizontal: (4.5, 0), vertical: "alu.e"), $K_1$, stroke: none, ports: (w: 1))
            datapath-block("ear", (7, -6), "EAR", ports: (n: 1, s: 1))
            datapath-block(
                "adder-plus",
                (horizontal: (8.5, 0), vertical: "address-adder.e"),
                width: 0,
                "",
                stroke: none,
                ports: (w: 1),
            )
            datapath-block("memory", (10, -3), "M", ports: (n: 1, s: 1, w: 1))
            datapath-block("read-write", (9.2, -4.7), "", height: 0, stroke: none, ports: (n: 1))

            arrow((1, -.12), "acc.n")
            arrow((2.5, -.12), "mq.n")
            arrow((4, -.12), "x-register.n")
            arrow((5.5, -.12), "ir.n")
            arrow((7, -.12), "pc.n")
            arrow((8.5, -.12), "xr.n")
            arrow((10, -.12), "mar.n")
            arrow((11.5, -.12), "mdr.n")

            arrow("acc.e1", "mq.w1")
            arrow("mq.w2", "acc.e2")
            arrow(
                (.5, -.12),
                (rel: (0, -2)),
                (horizontal: "alu.n1", vertical: ()),
                "alu.n1",
                name: "w_line_alu-n1",
                arrowheads: "both",
            )
            arrow(
                "acc.s",
                (horizontal: "acc.s", vertical: "w_line_alu-n1.point1"),
            )
            arrow(
                "mq.s",
                (rel: (0, -.3)),
                (rel: (.7, 0)),
                (horizontal: (), vertical: (0, -.12)),
            )
            arrow(
                "alu.s1",
                (horizontal: (), vertical: "status.e"),
                "status.e",
            )
            arrow(
                "alu.s2",
                (horizontal: "latch.n", vertical: ()),
                "latch.n",
            )
            arrow(
                "latch.s",
                (rel: (0, -1)),
                (rel: (-2.4, 0)),
                (horizontal: (), vertical: (0, -.12)),
            )
            arrow(
                "alu.n2",
                (rel: (0, 1)),
                (rel: (.4, 0)),
                (horizontal: (), vertical: (0, -.12)),
                arrowheads: "both",
                name: "w_line_alu-n2",
            )
            arrow(
                "x-register.s",
                (horizontal: (), vertical: "w_line_alu-n2.line.55%"),
                "w_line_alu-n2.line.55%",
            )
            arrow("k1-input.w", "alu.e")
            arrow(
                (4.7, -.12),
                (rel: (0, -2)),
                (horizontal: "address-adder.n1", vertical: ()),
                "address-adder.n1",
                name: "w_line_aa-n1",
                arrowheads: "both",
            )
            arrow(
                "ir.s",
                (horizontal: "ir.s", vertical: "w_line_aa-n1.point1"),
            )
            arrow(
                (6.5, -.12),
                (rel: (0, -2)),
                (horizontal: "address-adder.n2", vertical: ()),
                "address-adder.n2",
                name: "w_line_aa-n2",
                arrowheads: "both",
            )
            arrow(
                "pc.s",
                (horizontal: "pc.s", vertical: "w_line_aa-n2.point1"),
                arrowheads: "none",
            )
            arrow(
                "xr.s",
                (horizontal: (), vertical: "w_line_aa-n2.point1"),
                (horizontal: "address-adder.n3", vertical: ()),
                "address-adder.n3",
            )
            arrow("address-adder.s", "ear.n")
            arrow(
                "ear.s",
                (rel: (0, -1)),
                (rel: (2, 0)),
                (horizontal: (), vertical: (0, -.12)),
            )
            arrow("adder-plus.w", "address-adder.e")
            content(
                (to: "adder-plus.w", rel: (-.1, 0)),
                $+$,
                anchor: "north",
            )
            arrow("mar.s", "memory.n")
            arrow(
                "memory.s",
                (rel: (0, -.4)),
                (horizontal: "mdr.s1", vertical: ()),
                "mdr.s1",
            )
            arrow(
                "mdr.s2",
                (rel: (0, -1.2)),
                (rel: (.7, 0)),
                (horizontal: (), vertical: (0, -.12)),
            )
            arrow(
                "read-write.n",
                (horizontal: (), vertical: "memory.w"),
                "memory.w",
            )
            content(
                (to: "read-write.n", rel: (.1, 0)),
                "R/W",
                anchor: "west",
            )
        })
    }))
]
