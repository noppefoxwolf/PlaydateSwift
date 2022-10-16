import CPlaydate

public struct Lua {
    public let lua: playdate_lua
    
    public func addFunction(
        name: String,
        function: (@convention(c) (UnsafeMutablePointer<lua_State?>?) -> Int32)?
    ) throws {
        var outerr: UnsafePointer<CChar>? = nil
        let _ = lua.addFunction(function, name, &outerr)
        // 0 = failure
        // 1 = success
        if let outerr {
            let err = String(cString: outerr)
            throw CError(err: err)
        }
    }
    
    public func callFunction(name: String) throws {
        var outerr: UnsafePointer<CChar>? = nil
        // TODO: set args
        let nargs: Int32 = 0
        let _ = lua.callFunction(name, nargs, &outerr)
        if let outerr {
            let err = String(cString: outerr)
            throw CError(err: err)
        }
    }
    
    public func pushFunction(_ function: (@convention(c) (UnsafeMutablePointer<lua_State?>?) -> Int32)?) {
        lua.pushFunction(function)
    }
    
    public func indexMetatable() -> Int32 {
        lua.indexMetatable()
    }
    
    public func stop() {
        lua.stop()
    }
    
    public func start() {
        lua.start()
    }
    
    public func getArgCount() -> Int32 {
        lua.getArgCount()
    }
    
    public func getArgType(pos: Int32) -> LuaType {
        var outClass: UnsafePointer<CChar>? = nil
        return lua.getArgType(pos, &outClass)
    }
    
    public func argIsNil(pos: Int32) -> Bool {
        lua.argIsNil(pos) == 1
    }
    
    public func getArgBool(pos: Int32) -> Bool {
        lua.getArgBool(pos) == 1
    }
    
    public func getArgInt(pos: Int32) -> Int32 {
        lua.getArgInt(pos)
    }
    
    public func getArgFloat(pos: Int32) -> Float {
        lua.getArgFloat(pos)
    }
    
    public func getArgString(pos: Int32) -> String {
        String(cString: lua.getArgString(pos)!)
    }
    
    public func getArgBytes(pos: Int32) -> (ptr: UnsafePointer<CChar>?, len: size_t) {
        var outLength: size_t = 0
        let ptr = lua.getArgBytes(pos, &outLength)
        return (ptr, outLength)
    }
    
    public func getArgObject(pos: Int32, type: String) {
//        var type = type
//        var outud: UnsafePointer<LuaUDObject>? = nil
//        lua.getArgObject(pos, &type, &outud)
    }
    
    public func getBitmap(pos: Int32) -> Image {
        let ptr = lua.getBitmap(pos)
        return Image(ptr)
    }
    
    public func getSprite(pos: Int32) -> Sprite {
        let ptr = lua.getSprite(pos)
        return Sprite(ptr)
    }
    
    
    public func pushNil() {
        lua.pushNil()
    }
    
    public func pushBool(_ value: Bool) {
        lua.pushBool(value ? 1 : 0)
    }
    
    public func pushInt(_ value: Int32) {
        lua.pushInt(value)
    }
    
    public func pushFloat(_ value: Float) {
        lua.pushFloat(value)
    }
    
    public func pushString(_ value: String) {
        lua.pushString(value)
    }
    
    public func pushBytes(_ byte: UnsafePointer<CChar>, len: Int) {
        lua.pushBytes(byte, len)
    }
    
    public func pushBitmap(_ image: Image) {
        fatalError()
        //lua.pushBitmap(LCDBitmap(image.ptr))
    }
    
    public func pushSprite(_ sprite: Sprite) {
        fatalError()
        //lua.pushSprite(LCDSprite(sprite.ptr))
    }
    
    
    
    
    
    
}
