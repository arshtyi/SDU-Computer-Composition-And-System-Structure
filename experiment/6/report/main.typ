#import "dependency.typ": *
#import "template.typ": *

#show: report.with(
    institute: "计算机科学与技术",
    course: "计算机组成与设计",
    student-id: "2025130242",
    student-name: "彭靖轩",
    class: "24智能",
    date: datetime.today(),
    lab-title: "实验6-补码移位器设计",
    exp-time: "2",
)

#show figure.where(kind: "image"): it => {
    set image(width: 67%)
    it
}

#exp-block([
    = 实验目的
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
    == 实验原理
    补码移位器是一种数字电路，用于对二进制数进行移位操作。它可以实现逻辑左移、逻辑右移等功能。补码移位器的设计需要考虑输入数据的位宽、移位方向和移位位数等因素。
    == 实验方法
    使用门电路`and2`,`or3`设计一个4位的补码移位器，能够实现逻辑左移和逻辑右移两种功能。
]
#exp-block()[
    = 实验步骤
    + 根据实验要求，拖拽并连接相应模块如@F1 #figure(image("fig/1.png"))<F1>
    + 运行并生成比特流文件
    + 将比特流文件烧录到开发板上进行测试
        + 拨上排开关1-4选择输入数据
        + 拨上排开关6进行装载
        + 拨上排开关5进行右移
        + 拨上排开关7进行左移
]
