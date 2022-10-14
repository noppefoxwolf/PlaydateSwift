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
    
//    void (*setMenuImage)(LCDBitmap* bitmap, int xOffset);
//    PDMenuItem* (*addMenuItem)(const char *title, PDMenuItemCallbackFunction* callback, void* userdata);
//    PDMenuItem* (*addCheckmarkMenuItem)(const char *title, int value, PDMenuItemCallbackFunction* callback, void* userdata);
//    PDMenuItem* (*addOptionsMenuItem)(const char *title, const char** optionTitles, int optionsCount, PDMenuItemCallbackFunction* f, void* userdata);
//    void (*removeAllMenuItems)(void);
//    void (*removeMenuItem)(PDMenuItem *menuItem);
//    int (*getMenuItemValue)(PDMenuItem *menuItem);
//    void (*setMenuItemValue)(PDMenuItem *menuItem, int value);
//    const char* (*getMenuItemTitle)(PDMenuItem *menuItem);
//    void (*setMenuItemTitle)(PDMenuItem *menuItem, const char *title);
//    void* (*getMenuItemUserdata)(PDMenuItem *menuItem);
//    void (*setMenuItemUserdata)(PDMenuItem *menuItem, void *ud);
    
    public func drawFPS(point: Point<Int32>) {
        system.drawFPS(point.x, point.y)
    }
}
