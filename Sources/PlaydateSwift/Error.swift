public struct CError: Error, CustomStringConvertible {
    let err: String
    
    public var description: String { err }
}
