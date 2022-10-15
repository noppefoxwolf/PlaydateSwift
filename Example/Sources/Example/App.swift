import PlaydateSwift
import CPlaydate

final class App: PlaydateSwift.App {
    override init(playdate: PlaydateAPI) {
        super.init(playdate: playdate)
        system.drawFPS(point: Point<Int32>(x: 0, y: 0))
        
        let ref = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
        system.addMenuItem(title: "Simple", withTarget: ref, callback: { ref in
            let `self` = unsafeBitCast(ref!, to: App.self)
            `self`.graphics.drawRect(Rect<Int32>(x: 10, y: 10, width: 100, height: 100), color: .black)
        })
        system.addCheckmarkMenuItem(title: "Toggle", value: true, withTarget: ref, callback: { ref in
            let `self` = unsafeBitCast(ref!, to: App.self)
            `self`.graphics.drawRect(Rect<Int32>(x: 20, y: 20, width: 100, height: 100), color: .black)
        })
        system.addOptionsMenuItem(title: "Options", optionTitles: ["A","B","C"], withTarget: ref, callback: { ref in
            let `self` = unsafeBitCast(ref!, to: App.self)
            `self`.graphics.drawRect(Rect<Int32>(x: 30, y: 30, width: 100, height: 100), color: .black)
        })
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
        graphics.drawImage(image)
    }
}
