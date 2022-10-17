import PlaydateSwift
import CPlaydate

@_dynamicReplacement(for: EventCallback(playdate:event:))
func eventCallback(playdate: PlaydateAPI, event: SystemEvent) {
    switch event {
    case .initialize:
        app = App(playdate: playdate)
    case .initializeLua:
        app.setupLua()
    default:
        break
    }
}
