import Foundation

extension String {
    public func toBinary() -> String {
        let st = self
        var result = ""
        for char in st.utf8 {
            var tranformed = String(char, radix: 2)
            while tranformed.count < 8 {
                tranformed = "0" + tranformed
            }
            let binary = "\(tranformed)"
            result.append(binary)
        }
        return result
    }
    
    public func binToHex() -> String {
        let num = self.withCString { strtoul($0, nil, 2) }
        let hex = String(num, radix: 16, uppercase: true)
        return hex
    }
    
    
    public func hexToBinary() -> String {
        return self.hexaToBinary
    }
    
    
    var hexaToBytes: [UInt8] {
        var start = startIndex
        return stride(from: 0, to: count, by: 2).compactMap { _ in
            let end = index(after: start)
            defer { start = index(after: end) }
            return UInt8(self[start...end], radix: 16)
        }
    }
    var hexaToBinary: String {
        return hexaToBytes.map {
            let binary = String($0, radix: 2)
            return repeatElement("0", count: 8-binary.count) + binary
        }.joined()
    }
}
