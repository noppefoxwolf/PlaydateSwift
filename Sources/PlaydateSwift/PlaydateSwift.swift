import CPlaydate

dynamic public func EventCallback(playdate: PlaydateAPI, event: PDSystemEvent) {}

@_cdecl("eventHandler")
public func eventHandler(_ playdate: PlaydateAPI, _ event: PDSystemEvent, _ arg: CInt) -> CInt {
    EventCallback(playdate: playdate, event: event)
    return 0
}
