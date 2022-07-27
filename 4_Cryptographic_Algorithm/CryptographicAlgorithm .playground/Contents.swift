import UIKit

var vigenere = VigenereCipher()
print(vigenere.encrypt(message: "attackatdawn", key: "lemon"))


var rsa = RSA(p: BigInt("7"), q: BigInt("11"))
let s = rsa.encrypt(m: BigInt("121"))
let m = rsa.dencrypt(s: s)
print(s.value)
print(m.value)
