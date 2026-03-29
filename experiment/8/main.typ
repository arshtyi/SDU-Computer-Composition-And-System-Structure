#import "@preview/circuiteria:0.2.0"
// #set page("a3")
$a_i b_i$ means $a_i and b_i$.
#circuiteria.circuit({
    import circuiteria: *

    let nums = 4

    element.block(
        x: 3 * nums + 9,
        y: 3 * nums - 3,
        w: 2,
        h: 2,
        id: "AND",
        name: "AND",
        ports: (
            "north": ((id: "in0"), (id: "in1")),
            "south": ((id: "sum"),),
            "west": ((id: "cout"),),
        ),
    )

    wire.stub("AND-port-in0", "north", name: "A0")
    wire.stub("AND-port-in1", "north", name: "B0")
    wire.stub("AND-port-sum", "south", name: "S0")

    for i in range(nums) {
        for j in range(1, nums) {
            element.block(
                x: 3 * i + 3 * j,
                y: 3 * j,
                w: 2,
                h: 2,
                id: "A" + str(i) + "_" + str(j),
                name: if (i == nums - 1) or (j == nums - 1 and i == 0) {
                    "HA"
                } else {
                    "FA"
                },
                ports: (
                    "north": ((id: "in0"), (id: "in1")),
                    "east": ((id: "cin"),),
                    "south": ((id: "sum"),),
                    "west": ((id: "cout"),),
                ),
            )
        }
    }

    for i in range(nums) {
        for j in range(1, nums) {
            if j == nums - 1 and j > 0 {
                if i != 0 {
                    wire.stub(
                        "A" + str(i) + "_" + str(j) + "-port-in1",
                        "north",
                        name: "A" + str(nums - i) + "B" + str(nums - j - 1),
                    )
                }
                wire.stub(
                    "A" + str(i) + "_" + str(j) + "-port-in0",
                    "north",
                    name: "A" + str(nums - i - 1) + "B" + str(nums - j),
                    length: 1.2, /* 避免重叠 */
                )
                if i != nums - 1 {
                    wire.wire(
                        "A" + str(i) + "_" + str(j) + "2A" + str(i + 1) + "_" + str(j),
                        (
                            "A" + str(i) + "_" + str(j) + "-port-sum",
                            "A" + str(i + 1) + "_" + str(j - 1) + "-port-in0",
                        ),
                        directed: true,
                        style: "zigzag",
                        zigzag-ratio: 100%,
                    )
                }
                if i != 0 {
                    wire.wire(
                        "carry" + str(i) + "_" + str(j),
                        (
                            "A" + str(i) + "_" + str(j) + "-port-cout",
                            "A" + str(i - 1) + "_" + str(j) + "-port-cin",
                        ),
                        dashed: true,
                        directed: true,
                    )
                } else {
                    wire.wire(
                        "carry" + str(i) + "_" + str(j),
                        (
                            "A" + str(i) + "_" + str(j) + "-port-cout",
                            "A" + str(i) + "_" + str(j - 1) + "-port-in0",
                        ),
                        dashed: true,
                        style: "zigzag",
                        // zigzag-dir: "horizontal",
                        zigzag-ratio: 100%,
                        directed: true,
                    )
                }
                if i == nums - 1 {
                    wire.stub(
                        "A" + str(i) + "_" + str(j) + "-port-sum",
                        "south",
                        name: "S1",
                    )
                }
            }
            if j == nums - 2 and j > 0 {
                wire.stub(
                    "A" + str(i) + "_" + str(j) + "-port-in1",
                    "north",
                    name: "A" + str(nums - i - 1) + "B" + str(nums - j),
                )
                if i != nums - 1 {
                    wire.wire(
                        "A" + str(i) + "_" + str(j) + "2A" + str(i + 1) + "_" + str(j),
                        (
                            "A" + str(i) + "_" + str(j) + "-port-sum",
                            "A" + str(i + 1) + "_" + str(j - 1) + "-port-in0",
                        ),
                        directed: true,
                        style: "zigzag",
                        zigzag-ratio: 100%,
                    )
                }
                if i != 0 {
                    wire.wire(
                        "carry" + str(i) + "_" + str(j),
                        (
                            "A" + str(i) + "_" + str(j) + "-port-cout",
                            "A" + str(i - 1) + "_" + str(j) + "-port-cin",
                        ),
                        dashed: true,
                        directed: true,
                    )
                } else {
                    wire.wire(
                        "carry" + str(i) + "_" + str(j),
                        (
                            "A" + str(i) + "_" + str(j) + "-port-cout",
                            "A" + str(i) + "_" + str(j - 1) + "-port-in0",
                        ),
                        dashed: true,
                        style: "zigzag",
                        // zigzag-dir: "horizontal",
                        zigzag-ratio: 100%,
                        directed: true,
                    )
                }
                if i == nums - 1 {
                    wire.stub(
                        "A" + str(i) + "_" + str(j) + "-port-sum",
                        "south",
                        name: "S2",
                    )
                }
            }
            if j == nums - 3 and j > 0 {
                wire.stub(
                    "A" + str(i) + "_" + str(j) + "-port-in1",
                    "north",
                    name: "A" + str(nums - i - 1) + "B" + str(nums - j),
                )
                if i != 0 {
                    wire.wire(
                        "carry" + str(i) + "_" + str(j),
                        (
                            "A" + str(i) + "_" + str(j) + "-port-cout",
                            "A" + str(i - 1) + "_" + str(j) + "-port-cin",
                        ),
                        dashed: true,
                        directed: true,
                    )
                }
                wire.stub(
                    "A" + str(i) + "_" + str(j) + "-port-sum",
                    "south",
                    name: "S" + str(nums - i + 2),
                )
                if i == 0 {
                    wire.stub(
                        "A" + str(i) + "_" + str(j) + "-port-cout",
                        "west",
                        name: "S7",
                    )
                }
            }
        }
    }
})
