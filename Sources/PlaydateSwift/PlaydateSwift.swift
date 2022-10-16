import CPlaydate

dynamic public func EventCallback(playdate: PlaydateAPI, event: SystemEvent) {}

@_cdecl("eventHandler")
public func eventHandler(_ playdate: PlaydateAPI, _ event: PDSystemEvent, _ arg: CInt) -> CInt {
    EventCallback(playdate: playdate, event: SystemEvent(event))
    return 0
}
