import CPlaydate

open class App {
    public let playdate: PlaydateAPI
    public let system: System
    public let display: Display
    public let graphics: Graphics
    
    public init(playdate: PlaydateAPI) {
        self.playdate = playdate
        self.system = System(system: playdate.system.pointee)
        self.display = Display(display: playdate.display.pointee)
        self.graphics = Graphics(graphics: playdate.graphics.pointee)
        playdate.system.pointee.setUpdateCallback(_update, nil)
    }
    
    @discardableResult
    open func update() -> Bool {
        onPushedButton(system.pushedButtonState)
        return true
    }
    
    open func onPushedButton(_ buttons: Button) {
        if buttons.contains(.a) {
            onPushedAButton()
        }
        if buttons.contains(.b) {
            onPushedBButton()
        }
        if buttons.contains(.left) {
            onPushedLeftButton()
        }
        if buttons.contains(.right) {
            onPushedRightButton()
        }
        if buttons.contains(.up) {
            onPushedUpButton()
        }
        if buttons.contains(.down) {
            onPushedDownButton()
        }
    }
    
    open func onPushedLeftButton() {}
    open func onPushedRightButton() {}
    open func onPushedUpButton() {}
    open func onPushedDownButton() {}
    open func onPushedBButton() {}
    open func onPushedAButton() {}
}

public var app: App!

func _update(_ : UnsafeMutableRawPointer?) -> CInt {
    app.update() ? 1 : 0
}
