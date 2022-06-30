import UIKit

var keys: [Int] = [8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096]

for key in keys {
    let max = BigInt("2") ^ key
    print()
    print("  lenght: \(key)")
    print(" max key: \(max.value)")
    print("rand key: \(max.rand().value)")
    print(String(repeating: "_", count: 150))
}
