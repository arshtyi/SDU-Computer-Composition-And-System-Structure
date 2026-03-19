#import "@preview/ezexam:0.2.9": *
#import "@preview/zebraw:0.6.1": *

#show: zebraw
#show: setup.with(
    mode: EXAM,
    resume: false,
)

#show link: it => {
    set text(fill: blue)
    underline(offset: 2.5pt, it)
}

#title[
    山东大学计算机科学与技术学院 \
    24 数据、智能计算机组成与系统结构课后作业
]

#notice(
    [出于方便使用#link("https://github.com/gbchu/ezexam", "gbchu/ezexam:0.2.9")作模板.],
    [源码:#link("https://github.com/Arshtyi/SDU-Computer-Composition-And-System-Structure").],
)
= No.1
#question()[
    写出下面函数的反函数和对偶函数(不化简):
    + $F(A B C)= overline(A overline(B)+C)+0+overline(B C)$
]

#question()[
    写出下面函数的最小项标准式和最大项标准式:
    + #table(
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
