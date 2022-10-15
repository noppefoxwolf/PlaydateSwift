import CPlaydate

open class App {
    public let api: API
    
    public init(playdate: PlaydateAPI) {
        api = API(playdate: playdate)
        playdate.system.pointee.setUpdateCallback(_update, nil)
    }
    
    @discardableResult
    open func update() -> Bool {
        onPushedButton(api.system.pushedButtonState)
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
