import Foundation

public struct Convector {
    
    private var hexValues: [String : String] = ["a" : "10", "b" : "11", "c" : "12", "d" : "13", "e" : "14", "f" : "15"]
    private var hexReversedValues: [String : String] = ["10" : "a", "11" : "b", "12" : "c", "13" : "d", "14" : "e", "15" : "f"]
    
    public init() { }
    
    public func hexLit(_ v: String) -> BigInt {
        let hex = BigInt(String(v.reversed()))
        var res = BigInt("0")
        var i: Int = hex.value.count - 1
        for item in hex.value {
            if let n = Int(String(item)) {
                res = res + BigInt("\(n)") * (BigInt("16") ^ i)
            } else if let n = hexValues[String(item)] {
                res = res + BigInt(n) * (BigInt("16") ^ i)
            } else {
                return BigInt("ERROR")
            }
            i -=  1
        }
        return res
    }
    
    public func hexBig(_ v: String) -> BigInt {
        let hex = BigInt(v)
        var res = BigInt("0")
        var i: Int = hex.value.count - 1
        for item in hex.value {
            if let n = Int(String(item)) {
                res = res + BigInt("\(n)") * (BigInt("16") ^ i)
            } else if let n = hexValues[String(item)] {
                res = res + BigInt(n) * (BigInt("16") ^ i)
            } else {
                return BigInt("ERROR")
            }
            i -=  1
        }
        return res
    }
    
    public func litHex(_ v: BigInt) -> String {
        var temp = v
        let hex = BigInt("16")
        var resArray: [String] = []
        var res = ""
        while temp > hex {
            let element = temp % hex
            resArray.append(element.value)
            temp = temp / hex
        }
        resArray.append(temp.value)
        for item in resArray {
            if let n = hexReversedValues[item] {
                res += n
            } else {
                res += item
            }
        }
        return String(res.reversed())
    }
    
    public func bigHex(_ v: BigInt) -> String {
        var temp = BigInt(String(v.value.reversed()))
        let hex = BigInt("16")
        var resArray: [String] = []
        var res = ""
        while temp > hex {
            let element = temp % hex
            resArray.append(element.value)
            temp = temp / hex
        }
        resArray.append(temp.value)
        for item in resArray {
            if let n = hexReversedValues[item] {
                res += n
            } else {
                res += item
            }
        }
        return String(res.reversed())
    }
}
