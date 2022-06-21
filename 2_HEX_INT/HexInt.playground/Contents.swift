import UIKit

var convector = Convector()

let hex = "fffff"
let lit = convector.hexLit(hex)
let big = convector.hexBig(hex)
let hex1 = convector.litHex(lit)
let hex2 = convector.litHex(big)

print(hex)
print(lit.value)
print(big.value)
print(hex1)
print(hex2)
