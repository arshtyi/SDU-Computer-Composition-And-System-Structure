#import "@preview/codly:1.3.0": *
#import "@preview/cetz:0.4.2"
#import "@preview/numbly:0.1.0": numbly
#import "@preview/circuiteria:0.2.0"

#let font = (
    main: "Source Han Serif SC",
    mono: "IBM Plex Mono",
    cjk: "Noto Serif CJK SC",
)

#let cjk-markers = regex("[“”‘’．，。、？！：；（）｛｝［］〔〕〖〗《》〈〉「」【】『』─—＿·…\u{30FC}]+")

#let 字号 = (
    初号: 42pt,
    小初: 36pt,
    一号: 26pt,
    小一: 24pt,
    二号: 22pt,
    小二: 18pt,
    三号: 16pt,
    小三: 15pt,
    四号: 14pt,
    中四: 13pt,
    小四: 12pt,
    五号: 10.5pt,
    小五: 9pt,
    六号: 7.5pt,
    小六: 6.5pt,
    七号: 5.5pt,
    小七: 5pt,
)

#let report(
    institute: "计算机科学与技术",
    course: "计算机组成与设计",
    student-id: "202512111715",
    student-name: "Arshtyi",
    date: datetime.today(),
    lab-title: "实验题目",
    class: "你的班级",
    exp-time: "实验时间",
    body,
) = {
    set text(
        font: ("Source Han Serif SC", "Fira Sans"),
        size: 10.5pt,
        lang: "zh",
        region: "cn",
        // leading: 1.6
    )

    set page(
        paper: "a4",
        margin: (top: 2.6cm, bottom: 2.3cm, inside: 2cm, outside: 2cm),
        footer: [
            #set align(center)
            #set text(9pt)
            #context {
                counter(page).display("- 1 -")
            }
        ],
    )

    set document(title: lab-title, author: student-name)

    set heading(
        numbering: numbly(
            "",
            "{2:1}.",
            "({3:1})", // here, we only want the 3rd level
        ),
    )
    set par(justify: true)
    show math.equation.where(block: true): it => block(width: 100%, align(center, it))

    set raw(tab-size: 4)
    show raw: set text(font: (font.mono, font.cjk))
    // Display inline code in a small box
    // that retains the correct baseline.
    show raw.where(block: false): box.with(fill: luma(240), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 2pt)
    show raw: it => {
        show ".": "." + sym.zws
        show "=": "=" + sym.zws
        show ";": ";" + sym.zws
        it
    }
    let style-number(number) = text(gray)[#number]
    show raw.where(block: true): it => {
        align(center)[
            #block(
                fill: luma(240),
                inset: 10pt,
                radius: 4pt,
                width: 100%,
            )[
                #place(top + right, dy: -15pt)[
                    #set text(size: 9pt, fill: white, style: "italic")
                    #block(
                        fill: gray,
                        outset: 4pt,
                        radius: 4pt,
                        // width: 100%,
                        context {
                            it.lang
                        },
                    )
                ]
                #set par(justify: false, linebreaks: "simple")
                #grid(
                    columns: (1em, 1fr),
                    align: (right, left),
                    column-gutter: 0.7em,
                    row-gutter: 0.6em,
                    // stroke: 1pt,
                    ..it.lines.enumerate().map(((i, line)) => (style-number(i + 1), line)).flatten(),
                )

            ]]
    }

    show link: it => {
        set text(fill: blue)
        underline(it)
    }

    set list(indent: 6pt)
    set enum(indent: 6pt)
    set enum(
        numbering: numbly(
            "{1:1})",
            "{2:a}.",
        ),
        full: true,
    )

    counter(page).update(1)
    [
        #show heading: it => {
            set align(center)
            set text(size: 字号.小二, weight: "bold")
            it
        }
        #set text(tracking: 0.1em)
        #heading(numbering: none, depth: 1)[山东大学 #underline(extent: 2pt, [#institute]) 学院\ #underline(
                extent: 2pt,
                [#course],
            ) 课程实验报告]
    ]

    show heading: set block(spacing: 1.5em)
    // show heading: set block(above: 1.4em, below: 1em)

    show heading.where(depth: 1): it => {
        show h.where(amount: 0.3em): none
        set text(size: 字号.小四)
        it
    }

    show heading: it => {
        set text(size: 字号.小四)
        it
    }

    set text(size: 字号.小四)
    set par(first-line-indent: 2em)
    let fakepar = context {
        box()
        v(-measure(block() + block()).height)
    }
    show math.equation.where(block: true): it => it + fakepar // 公式后缩进
    show heading: it => it + fakepar // 标题后缩进
    show figure: it => it + fakepar // 图表后缩进
    show enum: it => {
        it
        fakepar
    }
    show list: it => {
        it
        fakepar
    }
    show grid: it => it + fakepar // 列表后缩进
    show table: it => it + fakepar // 表格后缩进
    show raw.where(block: true): it => it + fakepar

    [
        #set par(justify: true)
        #set text(size: 字号.小四)
        #table(
            align: left + horizon,
            inset: 0.5em,
            columns: (3.1fr, 2.7fr, 2.9fr),
            [学号： #student-id], [姓名： #student-name], [班级：#class],
        )
        #v(0em, weak: true)
        #table(
            inset: 0.5em,
            align: left + horizon,
            columns: 4fr,
            [实验题目：#lab-title],
        )
        #v(0em, weak: true)
        #table(
            inset: 0.5em,
            align: left + horizon,
            columns: (2fr, 2fr),
            [实验学时：#exp-time], [实验日期：#date.display("[year].[month].[day]")],
        )
    ]
    v(0em, weak: true)
    show heading.where(depth: 1): it => {
        show h.where(amount: 0.3em): none
        set text(size: 字号.小四)
        [
            #block(
                width: 100%,
                inset: 0em,
                stroke: none,
                breakable: true,
                it,
            )
        ]
    }
    body
}
#let exp-block(content) = {
    v(0em, weak: true)
    block(
        width: 100%,
        inset: 1em,
        stroke: 1pt,
        breakable: true,
        content + v(1em),
    )
}

#show: report.with(
    institute: "计算机科学与技术",
    course: "计算机组成与设计",
    student-id: "2025130242",
    student-name: "彭靖轩",
    class: "24智能",
    date: datetime.today(),
    lab-title: "实验7-可控的补码加/减法器设计",
    exp-time: "2",
)

#show figure.where(kind: "image"): it => {
    set image(width: 67%)
    it
}

#exp-block[
    = 实验目的
    - 设计一个可控的补码加/减法器,实现加法和减法两种功能,并且能够正确处理溢出情况.
]
#exp-block[
    = 实验软件和硬件环境
    - 软件环境
        - Vivado 2024.2
    - 硬件环境
        - PYNQ-Z2
]
#exp-block[
    = 实验原理和方法
    == 实验原理
    通过简单的门电路就可以设计出一个加法器:
#circuiteria.circuit({
    import circuiteria: *

    let nums = 8

    for i in range(nums) {
        gates.gate-xor(
            x: 2,
            y: 3 * i + 4,
            w: 1,
            h: 1,
            id: "xor" + str(i),
            inputs: 2,
        )

        wire.stub("xor" + str(i) + "-port-in0", "west", name: "B" + str(i))
        wire.stub("xor" + str(i) + "-port-in1", "west", name: "K")

        element.block(
            x: 5,
            y: 3 * i + 3 + .83, /* 这样刚好让xor2fa对齐 */
            w: 1,
            h: 1,
            id: "FA" + str(i),
            name: "FA" + str(i),
            ports: (
                "west": ((id: "in0"), (id: "in1")),
                "east": ((id: "sum"),),
                "north": ((id: "cout"),),
                "south": ((id: "cin"),),
            ),
        )

        wire.stub("FA" + str(i) + "-port-in1", "west", name: "A" + str(i))
        wire.wire(
            "xor2fa" + str(i),
            ("xor" + str(i) + "-port-out", "FA" + str(i) + "-port-in0"),
            directed: true, /* style: "zigzag" */
        )
        wire.stub("FA" + str(i) + "-port-sum", "east", name: "S" + str(i))
    }

    gates.gate-xor(
        x: 9,
        y: 3 * nums + 1,
        w: 1,
        h: 1,
        id: "OF",
        inputs: 2,
    )
    wire.stub("OF-port-out", "east", name: "OF")

    for i in range(nums) {
        if (i == 0) {
            wire.stub("FA" + str(i) + "-port-cin", "south", name: "cin")
        }

        if i < nums - 1 {
            wire.wire(
                "carry" + str(i),
                ("FA" + str(i) + "-port-cout", "FA" + str(i + 1) + "-port-cin"),
                dashed: true,
                directed: true,
            )
        } else {
            wire.stub("FA" + str(i) + "-port-cout", "north", name: "cout")
        }

        if (i == nums - 2) {
            wire.wire(
                "of2",
                ("FA" + str(i) + "-port-cout", "OF-port-in1"),
                dashed: true,
                directed: true,
                style: "zigzag",
            )
        }

        if (i == nums - 1) {
            wire.wire(
                "of1",
                ("FA" + str(nums - 1) + "-port-cout", "OF-port-in0"),
                dashed: true,
                directed: true,
            )
        }
    }
})
    == 实验方法
    使用提供的模块在Vivado中搭建电路并上传至开发板进行测试验证.
]
#exp-block[
    = 实验步骤
    + 使用Vivado搭建电路,原理如上所示.
    + 上传至开发板进行测试验证
]
