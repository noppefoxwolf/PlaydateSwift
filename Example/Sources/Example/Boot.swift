import PlaydateSwift
import CPlaydate

@_dynamicReplacement(for: EventCallback(playdate:event:))
func eventCallback(playdate: PlaydateAPI, event: PDSystemEvent) {
    if event == kEventInit {
        app = App(playdate: playdate)
    }
}
