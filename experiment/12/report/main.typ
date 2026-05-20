#import "@preview/numbly:0.1.0": numbly
#import "@preview/pointless-size:0.1.2": zh, zihao

#let fonts = (main: "Source Han Serif SC", mono: "IBM Plex Mono", cjk: "Noto Serif CJK SC")
#let institute = "计算机科学与技术"
#let course = "计算机组成与设计"
#let author = "彭靖轩"
#let id = "202400130242"
#let class = "24智能"
#let date = datetime.today()
#let title = "实验12-中断系统设计"
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
- 掌握中断系统的工作原理
- 掌握中断系统接口电路的组成和设计方法，进而理解中断系统的工作过程
= 实验软件和硬件环境

- 软件环境
    - Vivado 2024.2
- 硬件环境
    - PYNQ-Z2

= 实验原理和方法
== 实验方法
使用提供的模块在Vivado中搭建电路并上传至开发板进行测试验证.
#figure(image("fig/1.png"))
= 实验步骤
+ 按照实验手册指导设计电路
+ 拖动模块完成电路
+ 上传至开发板进行测试验证
