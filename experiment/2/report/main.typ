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
    设计一个能够实现$1$位逻辑乘、逻辑或、逻辑异或、逻辑非的逻辑运算电路.
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
    逻辑运算电路是数字电路中的基本组成部分,能够实现各种逻辑函数的计算.在本实验中,我们将设计一个能够实现$1$位逻辑乘、逻辑或、逻辑异或、逻辑非的逻辑运算电路.通过使用基本的逻辑门（如与门、或门、异或门和非门）,我们可以构建出所需的电路结构.设计完成后,我们将使用Vivado软件进行仿真和验证,确保电路的正确性和功能实现.
]
#exp-block()[
    = 实验步骤
    配置好依赖后连线如
    #figure(image("fig/image.png"), caption: [本实验所设计的电路图])
    烧录到PYNQ-Z2开发板上进行测试,验证电路的功能是否正确.

    一切功能正常即可.
]
