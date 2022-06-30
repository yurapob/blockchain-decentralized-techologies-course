import CoreFoundation

public class MTimer {
    let startTime: CFAbsoluteTime
    var endTime: CFAbsoluteTime?

    public init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }

    public func stop() -> CFAbsoluteTime {
        endTime = CFAbsoluteTimeGetCurrent()

        return duration!
    }

    public var duration: CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
}
