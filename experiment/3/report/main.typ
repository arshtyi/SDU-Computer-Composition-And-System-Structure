#import "dependency.typ": *
#import "template.typ": *

#show: report.with(
    institute: "计算机科学与技术",
    course: "计算机组成与设计",
    student-id: "2025130242",
    student-name: "彭靖轩",
    class: "24智能",
    date: datetime.today(),
    lab-title: "实验2-逻辑运算电路",
    exp-time: "2",
)

#show figure.where(kind: "image"): it => {
    set image(width: 67%)
    it
}

#exp-block([
    = 实验目的
    设计并实现一个4:1MUX电路
])
#exp-block([
    = 实验软件和硬件环境
    - 软件环境
        - Vivado 2024.2
    - 硬件环境
        - PYNQ-Z2
])
#exp-block()[
    = 实验原理和方法
    4:1MUX电路是一种多路选择器电路，它有4个输入信号和1个输出信号。根据选择信号的不同，输出信号会对应不同的输入信号。设计4:1MUX电路需要使用基本的逻辑门电路，如与门、或门和非门等。通过组合这些基本逻辑门，可以实现所需的功能。

    本实验通过利用AND3、OR4和NOT等基本逻辑门电路来设计4:1MUX电路。这种关系表达为
    $ Y = overline(B A) D_0 + overline(B)A D_1 + B overline(A) D_2 + B A D_3 $

    于是作出如下电路图：
    #figure(image("fig/image.png"))

]
#exp-block()[
    = 实验步骤
    1. 打开Vivado 2024.2，创建一个新的工程。
    2. 拖拽AND3、OR4和NOT等基本逻辑门电路到设计界面。
    3. 根据4:1MUX电路的逻辑关系连接这些基本逻辑门电路。
    4. 导出设计文件，并将其上传到PYNQ-Z2开发板上进行测试。
]
