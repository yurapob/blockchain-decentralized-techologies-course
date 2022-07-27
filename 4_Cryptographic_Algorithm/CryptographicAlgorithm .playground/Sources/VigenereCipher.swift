import Foundation

public class VigenereCipher {
    
    var alph1: [Int : String] = [:]
    var alph2: [String : Int] = [:]
    
    public init() {
        for i in 97...122 {
            if let item = UnicodeScalar(i)?.description {
                self.alph1[i - 97] = item
                self.alph2[item] = i-97
            }
        }
    }
    
    public func encrypt(message: String, key: String) -> String {
        
        var res: String = ""
        var k = key
        while k.count < message.count { k += key }
        
        var j = 0
        for i in message {
            res += alph1[(alph2[String(i)]! + alph2[String(k.substring(with: j..<j+1))]!) % 26]!
            j += 1
        }
        
        return res
    }
}
