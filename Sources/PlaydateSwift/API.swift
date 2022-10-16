import CPlaydate

public class API {
    public var playdate: PlaydateAPI
    public let system: SystemAPI
    public let display: DisplayAPI
    public let graphics: GraphicsAPI
    public let lua: LuaAPI
    public let sprite: SpriteAPI
    
    public init(playdate: PlaydateAPI) {
        self.playdate = playdate
        self.system = SystemAPI(api: playdate.system.pointee)
        self.display = DisplayAPI(api: playdate.display.pointee)
        self.graphics = GraphicsAPI(api: playdate.graphics.pointee)
        self.lua = LuaAPI(api: playdate.lua.pointee)
        self.sprite = SpriteAPI(api: playdate.sprite.pointee)
    }
    
    public func logToConsole(message: String) {
        CPlaydate.logToConsole(&playdate, message)
    }
    
    public func error(message: String) {
        CPlaydate.errorToConsole(&playdate, message)
    }
}
