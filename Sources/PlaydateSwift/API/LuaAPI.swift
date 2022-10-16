import CPlaydate

public class LuaAPI {
    public let api: playdate_lua
    
    init(api: playdate_lua) {
        self.api = api
    }
    
    public func addFunction(
        name: String,
        function: (@convention(c) (UnsafeMutablePointer<lua_State?>?) -> CInt)?
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
    
    public func callFunction(name: String) throws -> CInt {
        var outerr: UnsafePointer<CChar>? = nil
        // TODO: set args
        let nargs: CInt = 0
        let result = api.callFunction(name, nargs, &outerr)
        if let outerr {
            let err = String(cString: outerr)
            throw CError(err: err)
        }
        return result
    }
    
    public func pushFunction(_ function: (@convention(c) (UnsafeMutablePointer<lua_State?>?) -> CInt)?) {
        api.pushFunction(function)
    }
    
    public func indexMetatable() -> CInt {
        api.indexMetatable()
    }
    
    public func stop() {
        api.stop()
    }
    
    public func start() {
        api.start()
    }
    
    public func getArgCount() -> CInt {
        api.getArgCount()
    }
    
    public func getArgType(pos: CInt) -> LuaType {
        var outClass: UnsafePointer<CChar>? = nil
        return api.getArgType(pos, &outClass)
    }
    
    public func argIsNil(pos: CInt) -> Bool {
        api.argIsNil(pos).toBool()
    }
    
    public func getArgBool(pos: CInt) -> Bool {
        api.getArgBool(pos).toBool()
    }
    
    public func getArgInt(pos: CInt) -> CInt {
        api.getArgInt(pos)
    }
    
    public func getArgFloat(pos: CInt) -> Float {
        api.getArgFloat(pos)
    }
    
    public func getArgString(pos: CInt) -> String {
        String(cString: api.getArgString(pos)!)
    }
    
    public func getArgBytes(pos: CInt) -> (ptr: UnsafePointer<CChar>?, len: size_t) {
        var outLength: size_t = 0
        let ptr = api.getArgBytes(pos, &outLength)
        return (ptr, outLength)
    }
    
    public func getArgObject(pos: CInt, type: String) {
//        var type = type
//        var outud: UnsafePointer<LuaUDObject>? = nil
//        lua.getArgObject(pos, &type, &outud)
    }
    
    public func getBitmap(pos: CInt) -> Image {
        let ptr = api.getBitmap(pos)
        return Image(ptr)
    }
    
    public func getSprite(pos: CInt) -> Sprite {
        let ptr = api.getSprite(pos)
        return Sprite(ptr)
    }
    
    
    public func pushNil() {
        api.pushNil()
    }
    
    public func pushBool(_ value: Bool) {
        api.pushBool(value.toCInt())
    }
    
    public func pushInt(_ value: CInt) {
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
    
    public func pushSprite(_ sprite: Sprite) {
        fatalError()
        //lua.pushSprite(LCDSprite(sprite.ptr))
    }
    
    
    
    
    
    
}
