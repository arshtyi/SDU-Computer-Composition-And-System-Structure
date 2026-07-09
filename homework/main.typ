#import "@preview/ezexam:0.3.1": *
#import "@preview/zero:0.6.1": num, set-num, set-unit, zi

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
#show raw: set text(font: ("JetBrains Mono", "Noto Serif CJK SC", "Noto Sans CJK SC"))
#show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: .3em, y: 0em),
    outset: (x: 0em, y: .3em),
    radius: .2em,
)
#show raw.where(block: true): block.with(
    fill: luma(248),
    stroke: .5pt + rgb("bfbfbf"),
    inset: .7em,
    radius: 4pt,
)
#set-unit(fraction: "power")

#let Title = "山东大学计算机科学与技术学院计算机组成与系统结构课后作业"
#let author = "arshtyi"
#let date = datetime.today()
#set document(title: Title, author: author, date: date)
#title(Title)
#exam-info(info: (
    班级: "24数据·24智能",
    教师: "马博洋",
    源码: link("https://github.com/Arshtyi/SDU-Computer-Composition-And-System-Structure", "link"),
    课本: [#link("https://www.cmpedu.com/books/book/5603415.htm", "link1"), #link("https://www.hep.com.cn/book/show/ae8b4f15-c953-4445-a56d-ed96390fe0ae", "link2")],
))
#let question = question.with(supplement: "Q", ref-on: true, show-ref-prefix: false)
#let (K, KB, MB, GB, bit, byte, mus, ms, ns, s, min, mm, cm, word, block, track) = (
    zi.declare("K"),
    zi.declare("KB"),
    zi.declare("MB"),
    zi.declare("GB"),
    zi.declare("bit"),
    zi.declare("byte"),
    zi.declare("mus"),
    zi.declare("ms"),
    zi.declare("ns"),
    zi.declare("s"),
    zi.declare("min"),
    zi.declare("mm"),
    zi.declare("cm"),
    zi.declare("word"),
    zi.declare("block"),
    zi.declare("track"),
)
#let (Kword, track-mm, track-cm, bit-cm, r-min) = (
    zi.declare("Kword"),
    zi.declare("track/mm"),
    zi.declare("track/cm"),
    zi.declare("bit/cm"),
    zi.declare("r/min"),
)

= No.1
#question[
    写出下面函数的反函数和对偶函数（不化简）：
    $ F(A B C)= overline(A overline(B)+C)+0+overline(B C) $
]

#question[
    写出下面函数的最小项标准式和最大项标准式：
    #align(
        center,
        table(
            columns: 8,
            align: center + horizon,
            inset: (x: 10pt, y: 8pt),
            $A$, $B$, $C$, $Y$, $A$, $B$, $C$, $Y$,
            $0$, $0$, $0$, $0$, $1$, $0$, $0$, $0$,
            $0$, $0$, $1$, $1$, $1$, $0$, $1$, $1$,
            $0$, $1$, $0$, $0$, $1$, $1$, $0$, $0$,
            $0$, $1$, $1$, $1$, $1$, $1$, $1$, $1$,
        ),
    )
]

#question[
    利用`74161`实现模$7$加法计数器。
]
= No.2
#question[
    （_2-4.6_） 某机字长#bit[32]，其存储容量为#KB[64]，则：
    + 按字编址其寻址范围是多少？
    + 若主存以字节编址，试画出主存字地址和字节地址的分配情况。
]

#question[
    （_2-4.7_） 一个容量$#KB[16]times#bit[32]$的存储器，则：
    + 其地址线和数据线的总和是多少？
    + 当选用下列不同规格的存储芯片时，需要的芯片数量分别是多少？
    #align(
        center,
        table(
            columns: 6,
            $#K[1]times#bit[4]$,
            $#K[2]times#bit[8]$,
            $#K[4]times#bit[4]$,
            $#K[16]times#bit[1]$,
            $#K[4]times#bit[8]$,
            $#K[8]times#bit[8]$,
        ),
    )
]

#question[
    （_2-4.11_） 一个$#K[8] times #bit[8]$的动态RAM芯片，其内部结构排列成$256 times 256$形式，读#sym.slash 写周期为#mus[100]。问采用集中刷新、分散刷新和异步刷新三种方式的刷新间隔分别是多少？
]

#question[
    （_2-4.15_） 设CPU共有$16$条地址线和$8$条数据线，并用#overline[MREQ]（低电平有效）作访存控制信号，R#sym.slash#overline[W]作读#sym.slash 写命令信号（高电平为读，低电平为写）。现有这些存储芯片：ROM（$#K[2]times#bit[8]$，$#K[4]times#bit[4]$，$#K[8]times#bit[8]$），RAM（$#K[16]times#bit[4]$，$#K[2]times#bit[8]$，$#K[4]times#bit[8]$）及`74138`译码器和其他自定门电路。试从上述选用合适的芯片，画出CPU和存储芯片的连接图。要求：
    - 最小#K[4]地址为系统程序区，$4096 tilde.op 16383$地址范围为用户程序区。
    - 指出选用的芯片型号和数量。
    - 详细画出片选逻辑。
]

#question[
    （_2-4.16_） CPU假设同@1-2-4，现有$8$片$#K[8]times#bit[8]$的RAM芯片与CPU连接。
    + 用`74138`译码器画出CPU和存储芯片的连接图。
    + 写出每片RAM芯片的地址范围。
    + 如果运行是发现不论往哪片RAM芯片写入数据，以`A000H`为起始地址的RAM芯片都有与其相同的数据，试分析原因。
    + 根据（1）的连接图，若出现地址线A#sub[13]与CPU断线，并搭接到高电平上，将出现什么后果？
]

#question[
    （_2-4.17_） 写出$1100$、$1101$、$1110$、$1111$的汉明码。
]

#question[
    （_2-4.19_） 已知接收到下列汉明码，写出对应欲传送代码：
    - $11000000$（偶性）。
    - $11000010$（偶性）。
    - $11010001$（偶性）。
    - $0011001$（奇性）。
    - $1000000$（奇性）。
    - $1110001$（奇性）。
]

#question[
    （_2-4.20_） 欲传送的二进制代码是$1001101$，用奇校验来确定汉明码，如果在第$6$位出错，说明纠错过程。
]

#question[
    （_2-4.24_） 一个$4$体低位交叉的存储器，假设存取周期为$T$，CPU每隔$1/4T$启动一个存储体，依次访问#word[64]需要多少个存取周期？
]

#question[
    （_2-4.28_） 设主存容量为#Kword[256]，Cache容量为#Kword[2]，块长为$4$。
    + 设计Cache地址格式，Cache可装入多少块数据？
    + 在直接映射方式下，设计主存地址格式。
    + 在四路组相联映射方式下，设计主存地址格式。#footnote[相联存储器既可按地址寻址，又可按内容（通常是某些字段）寻址，为与传统存储器区别，又称为内容寻址存储器。]
    + 在全相联映射方式下，设计主存地址格式。
    + 若存储字长为#bit[32]，存储器按字节寻址，写出（2） #sym.tilde.op （4）各自主存的地址格式。
]

#question[
    （_2-4.29_） 假设CPU执行某段程序时共访问Cache命中$4800$次，访问主存$200$次，已知Cache的存取周期是#ns[30]，主存的存取周期是#ns[120]，求Cache的命中率以及Cache-主存系统的平均访问时间和效率，试问该系统的性能提升如何？
]

#question[
    （_2-4.30_） 一个组相联映射的Cache由#block[64]组成，每组内包含#block[4]，主存包含#block[4096]，每块由#word[128]组成，访存地址为字地址。试问主存和Cache的地址各为多少#bit()？画出主存的地址格式。
]

#question[
    （_2-4.32_） 设某机主存容量为#MB[4]，Cache容量为#KB[16]，每字块有#word[8]，每字#bit[32]，设计一个四路组相联映射（Cache每组内共有$4$个字块）的Cache组织。
    + 画出主存地址字段中各段的位数。
    + 设Cache的初态为空，CPU依次从主存第$0,1,2,dots.c,89$号单元读出$90$个字（主存依次读出一个字），并重复按此次序读$8$次，求命中率。
    + 若Cache的速度是主存的$6$倍，则有Cache与无Cache相比速度提升约多少倍？
]

#question[
    （_2-4.38_） 磁盘组有$6$片磁盘，最外两侧盘面可以记录，存储区域内径#cm[22]，外径#cm[33]，#track-cm[40]，内层密度#bit-cm[400]，转速#r-min[3600]。
    + 共有多少存储面可用？
    + 共有多少柱面？
    + 盘组总存储容量是多少？
    + 数据传输率是多少？
]

#question[
    （_2-4.39_） 某磁盘存储器转速#r-min[3000]，共$4$个记录盘面，#track-mm[5]，每道记录信息#byte[12288]，最小磁道直径#mm[230]，共有#track[275]。求：
    + 磁盘存储器的存储容量。
    + 最高位密度（最小磁道的位密度）和最低位密度。
    + 磁盘数据传输率。
    + 平均等待时间。
]

= No.3
#question[
    #set enum(spacing: 1em)
    （_2-6.4_） 设机器数字长#bit[8]（含#bit[1]符号位），写出下列各真值的原码、补码、反码：
    + $-13/64$。
    + $29/128$。
    + $100$。
    + $-87$。
]

#question[
    （_2-6.5_） 已知$[x]_"补"$，求$[x]_"原"$和$x$：
    + $[x]_"补"= 1.1100$。
    + $[x]_"补"= 1.1001$。
    + $[x]_"补"= 0.1110$。
    + $[x]_"补"= 1.0000$。
    + $[x]_"补"= 1,0101$。
    + $[x]_"补"= 1,1100$。
    + $[x]_"补"= 0,0111$。
    + $[x]_"补"= 1,0000$。
]

#question[
    （_2-6.9_） 当`9BH`和`FFH`分别表示为原码、补码、反码、移码、无符号数时，所对应的十进制数分别是多少（假设符号位仅#bit[1]）？
]

#question[
    #set enum(spacing: 1em)
    （_2-6.12_） 设浮点数格式：阶码#bit[5]（阶符#bit[1]），尾数#bit[11]（数符#bit[1]），写出下列数的机器数：
    + $51/128$。
    + $-27/1024$。
    + $7.375$。
    + $-86.5$。
    要求：
    + 阶码和尾数均为原码。
    + 阶码和尾数均为补码。
    + 阶码为移码，尾数为补码。
]

#question[
    （_2-6.16_） 设机器数字长#bit[16]（含#bit[1]符号位），写出下列其能表示的范围（十进制）：
    + 无符号数。
    + 原码定点小数。
    + 补码定点小数。
    + 补码定点整数。
    + 原码定点整数。
    + 浮点数格式：阶码#bit[6]（阶符#bit[1]），尾数#bit[10]（数符#bit[1]）。分别给出正数和负数的范围。
    + 浮点数格式同（6），机器数采用补码规格化形式，分别写出其对应的正数和负数的真值范围。
]

#question[
    #set enum(spacing: 1em)
    （_2-6.19_） 设机器数字长#bit[8]（含#bit[1]符号位），用补码计算下列：
    + $9/64+-13/32$。
    + $19/32--17/128$。
    + $-3/16+9/32$。
    + $-87-53$。
    + $115+-24$。
]

#question[
    （_2-6.20_） 用原码一位乘、两位乘和补码一位乘（Booth）、两位乘计算下列：
    + $0.110111 dot -0.101110$。
    + $-0.010111 dot -0.010101$。
    + $19 dot 35$。
    + $0.11011 dot -0.11101$。
]

#question[
    （_2-6.21_） 用原码加减交替法和补码加减交替法计算下列：
    + $0.100111 div 0.101011$。
    + $-0.10101 div 0.11011$。
    + $0.10100 div -0.10001$。
    + $13/32 div -27/32$。
]

#question[
    （_2-6.22_） 设机器数字长#bit[16]（含#bit[1]符号位），若一次移位需#mus[1]，一次加法需#mus[1]。给出下列时间：
    + 原码一位乘。
    + 补码一位乘。
    + 原码加减交替除。
    + 补码加减交替法。
]

#question[
    #set enum(spacing: 1em)
    #let num = num.with(base: 2)
    （_2-6.26_） 按机器补码浮点运算计算下列：
    + $[#num[0.101100e-011]plus.minus#num[-0.011100e-010]]_"补"$
    + $[#num[-0.100010e-011]plus.minus#num[-0.011111e-010]]_"补"$
    + $[#num[-0.100101e-101]plus.minus#num[-0.001111e-100]]_"补"$
]
