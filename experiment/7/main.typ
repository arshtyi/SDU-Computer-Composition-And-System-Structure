#import "@preview/circuiteria:0.2.0"
// #set page("a3")
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
