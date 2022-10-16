import CPlaydate

public class API {
    public var playdate: PlaydateAPI
    public var display: DisplayAPI
    public var file: FileAPI
    public var graphics: GraphicsAPI
    public var json: JSONAPI
    public var lua: LuaAPI
    public var scoreboards: ScoreboardsAPI
    public var sound: SoundAPI
    public var sprite: SpriteAPI
    public var system: SystemAPI
    
    public init(playdate: PlaydateAPI) {
        self.playdate = playdate
        self.display = DisplayAPI(api: playdate.display.pointee)
        self.file = FileAPI(api: playdate.file.pointee)
        self.graphics = GraphicsAPI(api: playdate.graphics.pointee)
        self.json = JSONAPI(api: playdate.json.pointee)
        self.lua = LuaAPI(api: playdate.lua.pointee)
        self.scoreboards = ScoreboardsAPI(api: playdate.scoreboards.pointee)
        self.sound = SoundAPI(api: playdate.sound.pointee)
        self.sprite = SpriteAPI(api: playdate.sprite.pointee)
        self.system = SystemAPI(api: playdate.system.pointee)
    }
    
    public func logToConsole(message: String) {
        CPlaydate.logToConsole(&playdate, message)
    }
    
    public func error(message: String) {
        CPlaydate.errorToConsole(&playdate, message)
    }
}
