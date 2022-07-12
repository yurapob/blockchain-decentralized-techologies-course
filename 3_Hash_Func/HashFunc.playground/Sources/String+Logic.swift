import Foundation

public extension String {
    
    static func ^ (left: String, right: String) -> String {
        var res = ""
        for i in 0..<left.count {
            if left.substring(with: i..<(i+1)) != right.substring(with: i..<(i+1)) {
                res += "1"
            } else {
                res += "0"
            }
        }
        return res
    }
    
    static func << (left: String, right: Int) -> String {
        var res = ""
        for i in right..<left.count {
            res += left.substring(with: i..<(i + 1))
        }
        res += left.substring(with: 0..<right)
        return res
    }
    
    static func && (left: String, right: String) -> String {
        var res = ""
        for i in 0..<left.count {
            let l = left.substring(with: i..<(i + 1))
            let r = right.substring(with: i..<(i + 1))
            res += (l == r && l != "0") ? "1" : "0"
        }
        return res
    }
    
    static func || (left: String, right: String) -> String {
        var res = ""
        for i in 0..<left.count {
            let l = left.substring(with: i..<(i + 1))
            let r = right.substring(with: i..<(i + 1))
            res += (l == r && l == "0") ? "0" : "1"
        }
        return res
    }
}

extension String {

    public func add (_ right: String) -> String {
        var res = ""
        var i = self.count - 1
        var step: Bool = false
        for _ in 0..<self.count {
            let l = self.substring(with: i..<(i + 1))
            let r = right.substring(with: i..<(i + 1))
            if l == r && l == "1" {
                res += step ? "1" : "0"
                step = true
            } else {
                if step && ((l == "1" && l == "0") || (l == "0" && l == "1")) {
                    res += "0"
                    step = true
                } else if step && (l == "0" && r == "0") {
                    res += "1"
                    step = false
                } else {
                    res += ((l == "1" && r == "0") || (l == "0" && r == "1")) ? "1" : "0"
                    step = false
                }

            }
            i -= 1
        }
        return String(res.reversed())
    }

    public func not () -> String {
        var res = ""
        for i in self {
            if i == "0" { res += "1"}
            else        { res += "0"}
        }
        return res
    }
}
