import PlaydateSwift
import CPlaydate

final class App: PlaydateSwift.App {
    override init(playdate: PlaydateAPI) {
        super.init(playdate: playdate)
        system.drawFPS(point: Point<Int32>(x: 0, y: 0))
    }
    
    override func update() -> Bool {
        super.update()
        return true
    }
    
    override func onPushedAButton() {
        let rect = Rect<Int32>(point: Point<Int32>(x: 50, y: 50), size: Size<Int32>(width: 10, height: 10))
        graphics.drawRect(rect, color: .black)
    }
    
    override func onPushedBButton() {
        let image = try! graphics.loadImage(path: "background")
        graphics.drawImage(image, point: .zero)
    }
}
