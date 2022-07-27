import Foundation

public class RSA {
    
    var n: BigInt
    var p: BigInt
    var q: BigInt
    var phi: BigInt
    lazy var e: BigInt = getE(phi)
    lazy var d: BigInt = getD(e, phi)
    
    public init(p: BigInt, q: BigInt) {
        self.n = p * q
        self.p = p
        self.q = q
        self.phi = (p - BigInt("1")) * (q - BigInt("1"))
    }
    
    public func  encrypt(m: BigInt) -> BigInt { (m ^ d) % n }
    public func dencrypt(s: BigInt) -> BigInt { (s ^ e) % n }
    
    func getE(_ phi: BigInt) -> BigInt {
        var e = BigInt("2")

        while e < phi {
            if gcd(e, phi) == BigInt("1") { return e }
            e = e + BigInt("1")
        }
        return BigInt("1")
    }
    
    func getD(_ e: BigInt, _ phi: BigInt) -> BigInt {
        var x = BigInt("1")

        while x < phi {
            if (e * x) % phi == BigInt("1") { return x }
            x = x + BigInt("1")
        }
        return BigInt("1")
    }
}
