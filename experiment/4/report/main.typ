#import "dependency.typ": *
#import "template.typ": *

#show: report.with(
    institute: "计算机科学与技术",
    course: "计算机组成与设计",
    student-id: "2025130242",
    student-name: "彭靖轩",
    class: "24智能",
    date: datetime.today(),
    lab-title: "实验4-3-8译码器电路设计",
    exp-time: "2",
)

#show figure.where(kind: "image"): it => {
    set image(width: 67%)
    it
}

#exp-block([
    = 实验目的
    设计并实现一个3-8译码器
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
    3-8译码器是一种组合逻辑电路，它将3位二进制输入转换为8位输出，其中只有一个输出为高电平，其他输出为低电平。设计3-8译码器可以使用基本的逻辑门电路，如AND、OR和NOT等。通过连接这些基本逻辑门电路，可以实现所需的逻辑关系，从而完成3-8译码器的设计。

    本实验额外给出了一个使能端，当使能端为高电平时，译码器正常工作；当使能端为低电平时，所有输出都为低电平。

    电路设计如下图所示：
    #figure(image("fig/image.png"))

]
#exp-block()[
    = 实验步骤
    + 打开Vivado 2024.2，创建一个新的工程。
    + 拖拽AND4、NOT1等基本逻辑门电路到设计界面，并根据3-8译码器的逻辑关系进行连接。
    + 导出设计文件，并将其上传到PYNQ-Z2开发板上进行测试。
]
