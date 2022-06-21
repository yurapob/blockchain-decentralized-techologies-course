import Foundation

public struct BigInt {
    
    public var value: String
    
    public init(_ value: String) {
        self.value = value
    }
    
    public func add (_ v: BigInt) -> BigInt {
        let first = self.value.reversed().map { Int(String($0))! }
        let second = v.value.reversed().map { Int(String($0))! }
        var result = [Int](repeating: 0, count: first.count > second.count ? first.count + 1 : second.count + 1)

        for i in 0..<(result.count - 1) {
            if i < first.count && i < second.count {
                result[i+1] += (first[i] + second[i]) / 10
                result[i] += (first[i] + second[i]) % 10
            } else if i > first.count - 1 {
                result[i+1] += (result[i] + second[i]) / 10
                result[i] = (result[i] + second[i]) % 10
            } else if i > second.count - 1 {
                result[i+1] += (result[i] + first[i]) / 10
                result[i] = (result[i] + first[i]) % 10
            }
        }
        
        result = Array(result.reversed())
        if result[0] == 0 { result.removeFirst() }
        return BigInt(result.map { String($0) }.joined(separator: ""))
    }
    
    public func sub (_ v: BigInt) -> BigInt {
        var first = self.value.reversed().map { Int(String($0))! }
        var second = v.value.reversed().map { Int(String($0))! }
        var result = [Int](repeating: 0, count: first.count > second.count ? first.count : second.count)
        
        if self < v {
            let t = first
            first = second
            second = t
        }
        
        for i in 0..<(result.count) {
            if i < second.count {
                if result[i] + first[i] - second[i] >= 0 {
                    result[i] += first[i] - second[i]
                } else {
                    result[i] += 10 + first[i] - second[i]
                    result[i+1] -= 1
                }
            } else {
                if result[i] + first[i] < 0 {
                    result[i] += 10 + first[i]
                    result[i+1] -= 1
                } else {
                    result[i] += first[i]
                }
            }
        }
        
        result = Array(result.reversed())
        while result.count > 1 && result.first == 0 { result.removeFirst(1) }
        return BigInt(result.map { String($0) }.joined(separator: ""))
    }
    
    public func multiply(_ v: BigInt) -> BigInt {
        let first = value.reversed().map { Int(String($0))! }
        let second = v.value.reversed().map { Int(String($0))! }
        var result = [Int](repeating: 0, count: first.count + second.count)
        
        for f in 0..<first.count {
            for l in 0..<second.count {
                
                let i = f + l
                
                result[i] = first[f] * second[l] + (i >= result.count ? 0 : result[i])
                if result[i] > 9 {
                    result[i+1] = (result[i] / 10) + (i+1 >= result.count ? 0 : result[i+1])
                    result[i] -= (result[i] / 10) * 10
                }
            }
        }
        
        result = Array(result.reversed())
        while result.count > 0 && result.first == 0 { result.removeFirst(1) }
        return  BigInt(result.map { String($0) }.joined(separator: ""))
    }
    
    public func pow(_ n: Int) -> BigInt {
        var result = BigInt("1")
        for _ in 0..<n { result = result.multiply(self) }
        return result
    }
    
    public func compFirst (_ v: BigInt, _ equal: Bool) -> Bool {
        let first = self.value.map { Int(String($0))! }
        let second = v.value.map { Int(String($0))! }

        if first.count > second.count {
            return true
        } else if first.count < second.count {
            return false
        } else {
            for i in 0..<first.count {
                if first[i] > second[i] {
                    return true
                } else if first[i] < second[i] {
                    return false
                }
            }
        }
        return equal
    }
    
    public func compSecond (_ v: BigInt, _ equal: Bool) -> Bool {
        let first = self.value.map { Int(String($0))! }
        let second = v.value.map { Int(String($0))! }

        if second.count > first.count {
            return true
        } else if second.count < first.count {
            return false
        } else {
            for i in 0..<second.count {
                if second[i] > first[i] {
                    return true
                } else if second[i] < first[i] {
                    return false
                }
            }
        }
        return equal
    }
    
    public func equal (_ v: BigInt) -> Bool {
        let first = self.value.map { Int(String($0))! }
        let second = v.value.map { Int(String($0))! }

        if first.count != second.count {
            return false
        } else {
            for i in 0..<second.count {
                if first[i] != second[i] {
                    return false
                }
            }
        }
        return true
    }
    
    public func div(_ v: BigInt) -> (BigInt, BigInt) {
        var first = self
        let second = v
        var q = BigInt("0")
        
        while first >= second {
            first = first - second
            q = q + BigInt("1")
        }
        return (q, first)
    }
}

public func + (first: BigInt, second: BigInt) -> BigInt { return first.add(second) }
public func - (first: BigInt, second: BigInt) -> BigInt { return first.sub(second) }
public func * (first: BigInt, second: BigInt) -> BigInt { return first.multiply(second) }
public func ^ (first: BigInt, second: Int) -> BigInt { return first.pow(second) }
public func > (first: BigInt, second: BigInt) -> Bool { return first.compFirst(second, false) }
public func < (first: BigInt, second: BigInt) -> Bool { return first.compSecond(second, false) }
public func >= (first: BigInt, second: BigInt) -> Bool { return first.compFirst(second, true) }
public func <= (first: BigInt, second: BigInt) -> Bool { return first.compSecond(second, true) }
public func == (first: BigInt, second: BigInt) -> Bool { return first.equal(second) }
public func / (first: BigInt, second: BigInt) -> BigInt { return first.div(second).0 }
public func % (first: BigInt, second: BigInt) -> BigInt { return first.div(second).1 }
