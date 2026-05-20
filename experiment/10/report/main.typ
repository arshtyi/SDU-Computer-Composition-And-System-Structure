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
        stroke: none,
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
    lab-title: "实验10-RAM位扩展",
    exp-time: "4",
)

#show figure.where(kind: "image"): it => {
    set image(width: 67%)
    it
}

#exp-block[
    = 实验目的
    - 熟练RAM的制作和使用.
    - 掌握半导体存储器的字、位扩展技术.
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
    使用`*.coe`初始化RAM的内容:
    ```coe
    memory_initialization_radix = 16;
    memory_initialization_vector =
    00, 01, 02, 03, 04, 05, 06, 07,
    08, 09, 0A, 0B, 0C, 0D, 0E, 0F,
    10, 11, 12, 13, 14, 15, 16, 17,
    18, 19, 1A, 1B, 1C, 1D, 1E, 1F,
    20, 21, 22, 23, 24, 25, 26, 27,
    28, 29, 2A, 2B, 2C, 2D, 2E, 2F,
    30, 31, 32, 33, 34, 35, 36, 37,
    38, 39, 3A, 3B, 3C, 3D, 3E, 3F,
    40, 41, 42, 43, 44, 45, 46, 47,
    48, 49, 4A, 4B, 4C, 4D, 4E, 4F,
    50, 51, 52, 53, 54, 55, 56, 57,
    58, 59, 5A, 5B, 5C, 5D, 5E, 5F,
    60, 61, 62, 63, 64, 65, 66, 67,
    68, 69, 6A, 6B, 6C, 6D, 6E, 6F,
    70, 71, 72, 73, 74, 75, 76, 77,
    78, 79, 7A, 7B, 7C, 7D, 7E, 7F,
    80, 81, 82, 83, 84, 85, 86, 87,
    88, 89, 8A, 8B, 8C, 8D, 8E, 8F,
    90, 91, 92, 93, 94, 95, 96, 97,
    98, 99, 9A, 9B, 9C, 9D, 9E, 9F,
    A0, A1, A2, A3, A4, A5, A6, A7,
    A8, A9, AA, AB, AC, AD, AE, AF,
    B0, B1, B2, B3, B4, B5, B6, B7,
    B8, B9, BA, BB, BC, BD, BE, BF,
    C0, C1, C2, C3, C4, C5, C6, C7,
    C8, C9, CA, CB, CC, CD, CE, CF,
    D0, D1, D2, D3, D4, D5, D6, D7,
    D8, D9, DA, DB, DC, DD, DE, DF,
    E0, E1, E2, E3, E4, E5, E6, E7,
    E8, E9, EA, EB, EC, ED, EE, EF,
    F0, F1, F2, F3, F4, F5, F6, F7,
    F8, F9, FA, FB, FC, FD, FE, FF;
    ```
    == 实验方法
    使用提供的模块在Vivado中搭建电路并上传至开发板进行测试验证.
    #figure(image("fig/1.png"))
]
#exp-block[
    = 实验步骤
    + 按照实验手册指导分别制作ROM和RAM
    + 拖动模块完成电路设计
    + 上传至开发板进行测试验证
]
