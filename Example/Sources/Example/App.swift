import PlaydateSwift
import CPlaydate

final class App: PlaydateSwift.App {
    override init(playdate: PlaydateAPI) {
        super.init(playdate: playdate)
        api.display.refreshRate = 1
        api.system.drawFPS(point: Point<Int32>(x: 0, y: 0))
        setupButtons()
    }
    
    func setupButtons() {
        let ref = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
        api.system.addMenuItem(title: "Simple", withTarget: ref, callback: { ref in
            let `self` = unsafeBitCast(ref!, to: App.self)
            `self`.api.graphics.drawRect(Rect<Int32>(x: 10, y: 10, width: 100, height: 100), color: .black)
        })
        api.system.addCheckmarkMenuItem(title: "Toggle", value: true, withTarget: ref, callback: { ref in
            let `self` = unsafeBitCast(ref!, to: App.self)
            `self`.api.graphics.drawRect(Rect<Int32>(x: 20, y: 20, width: 100, height: 100), color: .black)
        })
        api.system.addOptionsMenuItem(title: "Options", optionTitles: ["A","B","C"], withTarget: ref, callback: { ref in
            let `self` = unsafeBitCast(ref!, to: App.self)
            `self`.api.graphics.drawRect(Rect<Int32>(x: 30, y: 30, width: 100, height: 100), color: .black)
        })
    }
    
    override func update() -> Bool {
        super.update()
        api.graphics.clear(.white)
        api.graphics.drawText("Hello, World! \(api.system.elapsedTime)", at: .init(x: 64, y: 64))
        return true
    }
    
    override func onPushedAButton() {
        let rect = Rect<Int32>(x: 50, y: 50, width: 10, height: 10)
        api.graphics.drawRect(rect, color: .black)
    }
    
    override func onPushedBButton() {
        do {
            let image = try api.graphics.loadImage(path: "background")
            api.graphics.drawImage(image)
        } catch let error as CError {
            api.logToConsole(message: error.description)
        } catch {}
    }
}
