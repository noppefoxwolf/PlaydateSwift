import CPlaydate

public class SystemAPI {
    public let api: playdate_sys
    
    init(api: playdate_sys) {
        self.api = api
    }
    
    public var currentButtonState: Button {
        var buttons = PDButtons(rawValue: .max)
        api.getButtonState(&buttons, nil, nil)
        return .init(buttons)
    }
    
    public var pushedButtonState: Button {
        var buttons = PDButtons(rawValue: .max)
        api.getButtonState(nil, &buttons, nil)
        return .init(buttons)
    }
    
    public var releasedButtonState: Button {
        var buttons = PDButtons(rawValue: .max)
        api.getButtonState(nil, nil, &buttons)
        return .init(buttons)
    }
    
    public var batteryVoltage: Float {
        api.getBatteryVoltage()
    }
    
    public var batteryPercentage: Float {
        api.getBatteryPercentage()
    }
    
    public var elapsedTime: Float {
        api.getElapsedTime()
    }
    
    public func resetElapsedTime() {
        api.resetElapsedTime()
    }
    
    // https://sdk.play.date/1.12.3/Inside%20Playdate.html#f-playdate.getReduceFlashing
    public var reduceFlashing: Bool {
        api.getReduceFlashing().toBool()
    }
    
    public func setMenuImage(_ image: Image, xOffset: CInt) {
        api.setMenuImage(image.ptr, xOffset)
    }

    /// Example
    /**
    let ref = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
    system.addMenuItem(title: "hello", withTarget: ref, callback: { ref in
     let `self` = unsafeBitCast(ref!, to: App.self)
     `self`.graphics.drawRect(Rect<CInt>(x: 10, y: 10, width: 100, height: 100), color: .black)
    })
    */
    @discardableResult
    public func addMenuItem(
        title: String,
        withTarget target: UnsafeMutableRawPointer,
        callback: @convention(c) (UnsafeMutableRawPointer?) -> Void
    ) -> MenuItem {
        let ptr = api.addMenuItem(title, callback, target)
        return MenuItem(ptr)
    }
    
    @discardableResult
    public func addCheckmarkMenuItem(
        title: String,
        value: Bool,
        withTarget target: UnsafeMutableRawPointer,
        callback: @convention(c) (UnsafeMutableRawPointer?) -> Void
    ) -> MenuItem {
        let ptr = api.addCheckmarkMenuItem(title, value.toCInt(), callback, target)
        return MenuItem(ptr)
    }
    
    @discardableResult
    public func addOptionsMenuItem(
        title: String,
        optionTitles: [String],
        withTarget target: UnsafeMutableRawPointer,
        callback: @convention(c) (UnsafeMutableRawPointer?) -> Void
    ) -> MenuItem {
        withArrayOfCStrings(optionTitles) { titles in
            var titles = titles
            let ptr = api.addOptionsMenuItem(title, &titles, CInt(optionTitles.count), callback, target)
            return MenuItem(ptr)
        }
    }
    
    public func removeAllMenuItems() {
        api.removeAllMenuItems()
    }
    
    public func removeMenuItem(_ item: MenuItem) {
        api.removeMenuItem(item.ptr)
    }

    public func getMenuItemValue(_ item: MenuItem) -> CInt {
        api.getMenuItemValue(item.ptr)
    }
    
    public func setMenuItemValue(_ item: MenuItem, value: CInt) {
        api.setMenuItemValue(item.ptr, value)
    }
    
    public func getMenuItemTitle(_ item: MenuItem) -> String {
        String(cString: api.getMenuItemTitle(item.ptr)!)
    }
    
    public func setMenuItemTitle(_ item: MenuItem, title: String) {
        api.setMenuItemTitle(item.ptr, title)
    }
    
    // TODO: userdata structure
    public func getMenuItemUserdata(_ item: MenuItem) -> UnsafeMutableRawPointer? {
        api.getMenuItemUserdata(item.ptr)
    }
    
    public func setMenuItemUserdata(_ item: MenuItem, userdata: UnsafeMutableRawPointer?) {
        api.setMenuItemUserdata(item.ptr, userdata)
    }
    
    public func drawFPS(point: Point<CInt>) {
        api.drawFPS(point.x, point.y)
    }
    
    public func setUpdateCallback(
        _ handler: (@convention(c) (UnsafeMutableRawPointer?) -> Int32)?,
        withTarget target: UnsafeMutableRawPointer? = nil
    ) {
        api.setUpdateCallback(handler, target)
    }
}


