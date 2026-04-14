#import "@preview/ezexam:0.3.1": *
#import "@preview/zebraw:0.6.1": *
#import "@preview/fancy-units:0.1.1": add-macros, fancy-units-configure, num, qty, unit

#show: zebraw
#show: setup.with(
    mode: EXAM,
    resume: false,
)
#show link: it => text(fill: blue.darken(20%))[#underline(it)]
#let question = question.with(supplement: "Q", ref-on: true)

#title[
    山东大学计算机科学与技术学院 \
    24 数据、智能计算机组成与系统结构课后作业
]
#notice(
    [出于方便使用#link("https://github.com/gbchu/ezexam", "gbchu/ezexam:0.3.1")作模板.],
    [源码:#link("https://github.com/Arshtyi/SDU-Computer-Composition-And-System-Structure").],
    [本课程的参考书:#link("https://www.cmpedu.com/books/book/5603415.htm", "Book1"),#link("https://www.hep.com.cn/book/show/ae8b4f15-c953-4445-a56d-ed96390fe0ae", "Book2"). 并且答案均容易找到,仅记录题目.],
)

#add-macros(
    mu: sym.mu,
)
#let (K, KB, MB, GB) = (
    unit[K],
    unit[KB],
    unit[MB],
    unit[GB],
)
#let (mus, ms, ns, s, min) = (
    unit[mu:s],
    unit[ms],
    unit[ns],
    unit[s],
    unit[min],
)
#let (cm, mm) = (
    unit[cm],
    unit[mm],
)

= No.1
#question()[
    写出下面函数的反函数和对偶函数(不化简):
    + $F(A B C)= overline(A overline(B)+C)+0+overline(B C)$
]

#question()[
    写出下面函数的最小项标准式和最大项标准式:
    #table(
        columns: 8,
        align: center,
        inset: (x: 10pt, y: 8pt),
        table.header([$A$], [$B$], [$C$], [$Y$], [$A$], [$B$], [$C$], [$Y$]),
        [0], [0], [0], [0], [1], [0], [0], [0],
        [0], [0], [1], [1], [1], [0], [1], [1],
        [0], [1], [0], [0], [1], [1], [0], [0],
        [0], [1], [1], [1], [1], [1], [1], [1],
    )
]

#question()[
    利用74161实现模7的加法计数器.
]
= No.2
#question()[
    (_2-4.6_) 某机字长$32$位,其存储容量为$64KB$,按字编址其寻址范围是多少?若主存以字节编址,试画出主存字地址和字节地址的分配情况.
]

#question()[
    (_2-4.7_) 一个容量$16KB times 32$位的存储器,其地址线和数据线的总和是多少?当选用下列不同规格的存储芯片时,需要的芯片数量分别是多少?
    #align(center)[
        #table(
            columns: 6,
            [ $1 #K times 4$位],
            [ $2 #K times 8$位],
            [ $4 #K times 4$位],
            [ $16 #K times 1$位],
            [ $4 #K times 8$位],
            [ $8 #K times 8$位],
        )
    ]
]

#question()[
    (_2-4.11_) 一个$8 #K times 8$位的动态RAM芯片,其内部结构排列成$256 times 256$形式,读#sym.slash 写周期为$100mus$.试问采用集中刷新、分散刷新和异步刷新三种方式的刷新间隔分别是多少?
]

#question()[
    (_2-4.15_) 设CPU共有$16$条地址线和$8$条数据线,并用#overline[MREQ] (低电平有效)作访存控制信号,R#sym.slash#overline[W]作读#sym.slash 写命令信号(高电平为读,低电平为写).现有这些存储芯片:ROM($2 #K times 8$位,$4 #K times 4$位,$8 #K times 8$位),RAM($16 #K times 4$位,$2 #K times 8$位,$4 #K times 8$位)及74138译码器和其他自定门电路.

    试从上述选用合适的芯片,画出CPU和存储芯片的连接图.要求:
    - 最小$4 #K$地址为系统程序区,$4096 tilde.op 16383$地址范围为用户程序区.
    - 指出选用的芯片型号和数量
    - 详细画出片选逻辑
]

#question()[
    (_2-4.16_) CPU假设同@1-2-4 ,现有$8$片$8 #K times 8$位的RAM芯片与CPU连接.
    + 用74138译码器画出CPU和存储芯片的连接图.
    + 写出每片RAM芯片的地址范围.
    + 如果运行是发现不论往哪片RAM芯片写入数据,以A000H为起始地址的RAM芯片都有与其相同的数据,试分析原因.
    + 根据(1)的连接图,若出现地址线A#sub[13]与CPU断线,并搭接到高电平上,将出现什么后果?
]

#question()[
    (_2-4.17_) 写出1100、1101、1110、1111的汉明码.
]

#question()[
    (_2-4.19_) 已知接收到下列汉明码,写出对应欲传送代码:
    - 11000000(偶性)
    - 11000010(偶性)
    - 11010001(偶性)
    - 0011001(奇性)
    - 1000000(奇性)
    - 1110001(奇性)
]

#question()[
    (_2-4.20_) 欲传送的二进制代码是1001101,用奇校验来确定汉明码,如果在第$6$位出错,说明纠错过程.
]

#question()[
    (_2-4.24_) 一个$4$体低位交叉的存储器,假设存取周期为$T$,CPU每隔$1/4$存取周期启动一个存储体,依次访问$64$个字需要多少个存取周期?
]

#question()[
    (_2-4.28_) 设主存容量为$256#K$字,Cache容量为$2#K$字,块长为$4$.
    + 设计Cache地址格式,Cache可装入多少块数据?
    + 在直接映射方式下,设计主存地址格式.
    + 在四路组相联映射方式下,设计主存地址格式.#footnote(numbering: "1")[相联存储器既可按地址寻址,又可按内容(通常是某些字段)寻址,为与传统存储器区别,又称为内容寻址存储器.]
    + 在全相联映射方式下,设计主存地址格式.
    + 若存储字长为$32$位,存储器按字节寻址,写出(2) #sym.tilde.op (4)三种映射方式下主存的地址格式.
]

#question()[
    (_2-4.29_) 假设CPU执行某段程序时共访问Cache命中$4800$次,访问主存$200$次,已知Cache的存取周期是$30 ns$,主存的存取周期是$150 ns$,求Cache的命中率以及Cache-主存系统的平均访问时间和效率,试问该系统的性能提升如何?
]

#question()[
    (_2-4.30_) 一个组相联映射的Cache由$64$块组成,每组内包含$4$块.主存包含$4096$块,每块由$128$字组成,访存地址为字地址.试问主存和Cache的地址各为几位?画出主存的地址格式.
]

#question()[
    (_2-4.32_) 设某机主存容量为$4 MB$,Cache容量为$16 KB$,每字块有$8$字,每字$32$位,设计一个四路组相联映射(Cache每组内共有$4$个字块)的Cache组织.
    - 画出主存地址字段中各段的位数.
    - 设Cache的初态为空,CPU依次从主存第$0,1,2,dots.c,89$号单元读出$90$个字(主存依次读出一个字),并重复按此次序读$8$次,求命中率.
    - 若Cache的速度是主存的$6$倍,则有Cache与无Cache相比速度提升约多少倍?
]

#question()[
    (_2-4.38_) 磁盘组有$6$片磁盘,最外两侧盘面可以记录,存储区域内径$22 cm$,外径$33 cm$,道密度$40#unit[道/cm]$,内层密度$400#unit[位/cm]$,转速$3600#unit[r/min]$.
    - 共有多少存储面可用?
    - 共有多少柱面?
    - 盘组总存储容量是多少?
    - 数据传输率是多少?
]

#question()[
    (_2-4.39_) 某磁盘存储器转速$3000#unit[r/min]$,共$4$个记录盘面,每毫米$5$道,每道记录信息$12288$字节,最小磁道直径$230 mm$,共有$275$道.求:
    - 磁盘存储器的存储容量.
    - 最高位密度(最小磁道的位密度)和最低位密度.
    - 磁盘数据传输率.
    - 平均等待时间.
]
