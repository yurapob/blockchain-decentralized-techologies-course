import UIKit

var keys: [Int] = [8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096]
var convector = Convector()

func bruteForce(_ v: BigInt) -> BigInt {
    var res = BigInt("0")
    
    let timer = MTimer()
    while res.value != v.value {
        res = res + BigInt("1")
    }
    print("The task took \(timer.stop() * 1000) milliseconds.\n")
    
    return res
}

bruteForce(BigInt("123456"))

for key in keys {
    let max = BigInt("2") ^ key
    print()
    print("  lenght: \(key)")
    print(" max key: \(max.value)")
    print("rand key: \(convector.bigHex(max.rand()))")
    print(String(repeating: "_", count: 150))
}

