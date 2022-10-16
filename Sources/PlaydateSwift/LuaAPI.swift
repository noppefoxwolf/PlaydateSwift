import CPlaydate

public struct LuaAPI {
    public let api: playdate_lua
    
    public func addFunction(
        name: String,
        function: (@convention(c) (UnsafeMutablePointer<lua_State?>?) -> Int32)?
    ) throws {
        var outerr: UnsafePointer<CChar>? = nil
        let _ = api.addFunction(function, name, &outerr)
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
        let _ = api.callFunction(name, nargs, &outerr)
        if let outerr {
            let err = String(cString: outerr)
            throw CError(err: err)
        }
    }
    
    public func pushFunction(_ function: (@convention(c) (UnsafeMutablePointer<lua_State?>?) -> Int32)?) {
        api.pushFunction(function)
    }
    
    public func indexMetatable() -> Int32 {
        api.indexMetatable()
    }
    
    public func stop() {
        api.stop()
    }
    
    public func start() {
        api.start()
    }
    
    public func getArgCount() -> Int32 {
        api.getArgCount()
    }
    
    public func getArgType(pos: Int32) -> LuaType {
        var outClass: UnsafePointer<CChar>? = nil
        return api.getArgType(pos, &outClass)
    }
    
    public func argIsNil(pos: Int32) -> Bool {
        api.argIsNil(pos) == 1
    }
    
    public func getArgBool(pos: Int32) -> Bool {
        api.getArgBool(pos) == 1
    }
    
    public func getArgInt(pos: Int32) -> Int32 {
        api.getArgInt(pos)
    }
    
    public func getArgFloat(pos: Int32) -> Float {
        api.getArgFloat(pos)
    }
    
    public func getArgString(pos: Int32) -> String {
        String(cString: api.getArgString(pos)!)
    }
    
    public func getArgBytes(pos: Int32) -> (ptr: UnsafePointer<CChar>?, len: size_t) {
        var outLength: size_t = 0
        let ptr = api.getArgBytes(pos, &outLength)
        return (ptr, outLength)
    }
    
    public func getArgObject(pos: Int32, type: String) {
//        var type = type
//        var outud: UnsafePointer<LuaUDObject>? = nil
//        lua.getArgObject(pos, &type, &outud)
    }
    
    public func getBitmap(pos: Int32) -> Image {
        let ptr = api.getBitmap(pos)
        return Image(ptr)
    }
    
    public func getSprite(pos: Int32) -> LCDSprite {
        let ptr = api.getSprite(pos)
        return LCDSprite(ptr)
    }
    
    
    public func pushNil() {
        api.pushNil()
    }
    
    public func pushBool(_ value: Bool) {
        api.pushBool(value ? 1 : 0)
    }
    
    public func pushInt(_ value: Int32) {
        api.pushInt(value)
    }
    
    public func pushFloat(_ value: Float) {
        api.pushFloat(value)
    }
    
    public func pushString(_ value: String) {
        api.pushString(value)
    }
    
    public func pushBytes(_ byte: UnsafePointer<CChar>, len: Int) {
        api.pushBytes(byte, len)
    }
    
    public func pushBitmap(_ image: Image) {
        fatalError()
        //lua.pushBitmap(LCDBitmap(image.ptr))
    }
    
    public func pushSprite(_ sprite: LCDSprite) {
        fatalError()
        //lua.pushSprite(LCDSprite(sprite.ptr))
    }
    
    
    
    
    
    
}
