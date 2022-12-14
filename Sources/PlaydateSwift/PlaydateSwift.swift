import CPlaydate

dynamic public func EventCallback(playdate: PlaydateAPI, event: SystemEvent) {}

@_cdecl("eventHandler")
public func eventHandler(_ playdate: UnsafePointer<PlaydateAPI>, _ event: PDSystemEvent, _ arg: UInt32) -> CInt {
    EventCallback(playdate: playdate.pointee, event: SystemEvent(event))
    return 0
}
