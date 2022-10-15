import CPlaydate

public struct System {
    public let system: playdate_sys
    
    public var currentButtonState: Button {
        var buttons = PDButtons(rawValue: .max)
        system.getButtonState(&buttons, nil, nil)
        return .init(buttons)
    }
    
    public var pushedButtonState: Button {
        var buttons = PDButtons(rawValue: .max)
        system.getButtonState(nil, &buttons, nil)
        return .init(buttons)
    }
    
    public var releasedButtonState: Button {
        var buttons = PDButtons(rawValue: .max)
        system.getButtonState(nil, nil, &buttons)
        return .init(buttons)
    }
    
    public var batteryVoltage: Float {
        system.getBatteryVoltage()
    }
    
    public var batteryPercentage: Float {
        system.getBatteryPercentage()
    }
    
    public var elapsedTime: Float {
        system.getElapsedTime()
    }
    
    public func resetElapsedTime() {
        system.resetElapsedTime()
    }
    
    // https://sdk.play.date/1.12.3/Inside%20Playdate.html#f-playdate.getReduceFlashing
    public var reduceFlashing: Bool {
        system.getReduceFlashing() == 1
    }
    
    public func setMenuImage(_ image: Image, xOffset: Int32) {
        system.setMenuImage(image.ptr, xOffset)
    }

    /// Example
    /**
    let ref = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
    system.addMenuItem(title: "hello", withTarget: ref, callback: { ref in
     let `self` = unsafeBitCast(ref!, to: App.self)
     `self`.graphics.drawRect(Rect<Int32>(x: 10, y: 10, width: 100, height: 100), color: .black)
    })
    */
    @discardableResult
    public func addMenuItem(
        title: String,
        withTarget target: UnsafeMutableRawPointer,
        callback: @convention(c) (UnsafeMutableRawPointer?) -> Void
    ) -> MenuItem {
        let ptr = system.addMenuItem(title, callback, target)
        return MenuItem(ptr)
    }
    
    @discardableResult
    public func addCheckmarkMenuItem(
        title: String,
        value: Bool,
        withTarget target: UnsafeMutableRawPointer,
        callback: @convention(c) (UnsafeMutableRawPointer?) -> Void
    ) -> MenuItem {
        let ptr = system.addCheckmarkMenuItem(title, value ? 1 : 0, callback, target)
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
            let ptr = system.addOptionsMenuItem(title, &titles, Int32(optionTitles.count), callback, target)
            return MenuItem(ptr)
        }
    }
//    PDMenuItem* (*addOptionsMenuItem)(const char *title, const char** optionTitles, int optionsCount, PDMenuItemCallbackFunction* f, void* userdata);
    
    public func removeAllMenuItems() {
        system.removeAllMenuItems()
    }
    
    public func removeMenuItem(_ item: MenuItem) {
        system.removeMenuItem(item.ptr)
    }

    public func getMenuItemValue(_ item: MenuItem) -> Int32 {
        system.getMenuItemValue(item.ptr)
    }
    
    public func setMenuItemValue(_ item: MenuItem, value: Int32) {
        system.setMenuItemValue(item.ptr, value)
    }
    
    public func getMenuItemTitle(_ item: MenuItem) -> String {
        String(cString: system.getMenuItemTitle(item.ptr)!)
    }
    
    public func setMenuItemTitle(_ item: MenuItem, title: String) {
        system.setMenuItemTitle(item.ptr, title)
    }
    
    // TODO: userdata structure
    public func getMenuItemUserdata(_ item: MenuItem) -> UnsafeMutableRawPointer? {
        system.getMenuItemUserdata(item.ptr)
    }
    
    public func setMenuItemUserdata(_ item: MenuItem, userdata: UnsafeMutableRawPointer?) {
        system.setMenuItemUserdata(item.ptr, userdata)
    }
    
    public func drawFPS(point: Point<Int32>) {
        system.drawFPS(point.x, point.y)
    }
}


