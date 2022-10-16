import PlaydateSwift
import CPlaydate

@_dynamicReplacement(for: EventCallback(playdate:event:))
func eventCallback(playdate: PlaydateAPI, event: PDSystemEvent) {
    let event = SystemEvent(event)
    switch event {
    case .initialize:
        app = App(playdate: playdate)
        app.api.logToConsole(message: "initialize")
    default:
        break
    }
}
