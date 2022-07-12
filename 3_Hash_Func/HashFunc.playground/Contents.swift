import UIKit

func getHash(_ message: String) -> String {
    let binaryMessage = message.toBinary()

    var h0  = "67452301"
    var h1  = "EFCDAB89"
    var h2  = "98BADCFE"
    var h3  = "10325476"
    var h4  = "C3D2E1F0"

    let len = binaryMessage.count
    let q = len % 512
    let binaryLen = String(len, radix: 2)
    let bitsLen = binaryLen.count

    var m: String = binaryMessage + "1"
    for _ in 0..<(448 - q - 1)  { m += "1" }
    for _ in 0..<(64 - bitsLen) { m += "0" }
    m += binaryLen

    var w: [[String]] = []

    for _ in 0..<(m.count / 512) {
        var t: [String] = []
        for j in 0...15 {
            t.append(m.substring(with: (j * 32)..<((j + 1) * 32)))
        }
        for j in 16..<80 {
            t.append((t[j - 3] ^ t[j - 8] ^ t[j - 14] ^ t[j - 16]) << 1)
        }
        
        //Initialize the hash values
        var a = h0.hexToBinary()
        var b = h1.hexToBinary()
        var c = h2.hexToBinary()
        var d = h3.hexToBinary()
        var e = h4.hexToBinary()
        
        //MARK: Main cycle
        var f: String = ""
        for j in 0..<80 {
            var k: String = ""
            if j >= 0 && j <= 19 {
                f = (b && c) || (b.not() && d)
                k = "5A827999".hexToBinary()
            } else if j >= 20 && j <= 39 {
                f = (b ^ c) ^ d
                k = "6ED9EBA1".hexToBinary()
            } else if j >= 40 && j <= 59 {
                f = (b && c) || (b && d) || (c && d)
                k = "8F1BBCDC".hexToBinary()
            } else if j >= 60 && j <= 79 {
                f = (b ^ c) ^ d
                k = "CA62C1D6".hexToBinary()
            }

            let temp = t[j].add((a << 5).add(f).add(e).add(k))
            e = d
            d = c
            c = b << 30
            b = a
            a = temp
        }
        
        h0 = h0.hexToBinary().add(a)
        h1 = h1.hexToBinary().add(b)
        h2 = h2.hexToBinary().add(c)
        h3 = h3.hexToBinary().add(d)
        h4 = h4.hexToBinary().add(e)
        
        w.append(t)
    }
    
    return "\(h0.binToHex()) \(h1.binToHex()) \(h2.binToHex()) \(h3.binToHex()) \(h4.binToHex())"
}

let message = "sha"
print(getHash(message))
