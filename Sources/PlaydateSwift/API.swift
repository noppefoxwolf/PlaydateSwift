import CPlaydate

public class API {
    public var playdate: PlaydateAPI
    public let system: System
    public let display: Display
    public let graphics: Graphics
    public let lua: Lua
    
    public init(playdate: PlaydateAPI) {
        self.playdate = playdate
        self.system = System(system: playdate.system.pointee)
        self.display = Display(display: playdate.display.pointee)
        self.graphics = Graphics(graphics: playdate.graphics.pointee)
        self.lua = Lua(lua: playdate.lua.pointee)
    }
    
    public func logToConsole(message: String) {
        CPlaydate.logToConsole(&playdate, message)
    }
    
    public func error(message: String) {
        CPlaydate.errorToConsole(&playdate, message)
    }
}
