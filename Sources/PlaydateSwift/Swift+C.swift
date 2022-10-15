// https://oleb.net/blog/2016/10/swift-array-of-c-strings/

public func withArrayOfCStrings<R>(
    _ args: [String],
    _ body: ([UnsafePointer<CChar>?]) -> R
) -> R {
    let argsCounts = Array(args.map { $0.utf8.count + 1 })
    let argsOffsets = [ 0 ] + scan(argsCounts, 0, +)
    let argsBufferSize = argsOffsets.last!
    
    var argsBuffer: [UInt8] = []
    argsBuffer.reserveCapacity(argsBufferSize)
    for arg in args {
        argsBuffer.append(contentsOf: arg.utf8)
        argsBuffer.append(0)
    }
    return argsBuffer.withUnsafeBufferPointer {
        (argsBuffer) in
        let ptr = UnsafeRawPointer(argsBuffer.baseAddress!).bindMemory(
            to: CChar.self, capacity: argsBuffer.count)
        var cStrings: [UnsafePointer<CChar>?] = argsOffsets.map { ptr + $0 }
        cStrings[cStrings.count - 1] = nil
        return body(cStrings)
    }
}

public func scan<S : Sequence, U>(_ seq: S, _ initial: U, _ combine: (U, S.Iterator.Element) -> U) -> [U] {
    var result: [U] = []
    result.reserveCapacity(seq.underestimatedCount)
    var runningResult = initial
    for element in seq {
        runningResult = combine(runningResult, element)
        result.append(runningResult)
    }
    return result
}
