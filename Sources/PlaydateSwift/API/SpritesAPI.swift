import CPlaydate

public class SpriteAPI {
    public let api: playdate_sprite
    
    init(api: playdate_sprite) {
        self.api = api
    }
    
    public func newSprite() -> Sprite {
        Sprite(api.newSprite())
    }
    
    public func copy(_ sprite: Sprite) -> Sprite {
        Sprite(api.copy(sprite.ptr))
    }
    
    public func free(_ sprite: Sprite) {
        api.freeSprite(sprite.ptr)
    }
    
    public func setBounds(_ sprite: Sprite, rect: Rect<Float>) {
        api.setBounds(sprite.ptr, rect.toPD())
    }
    
    public func getBounds(_ sprite: Sprite) -> Rect<Float> {
        let rect = api.getBounds(sprite.ptr)
        return Rect(rect)
    }
    
    public func move(_ sprite: Sprite, to point: Point<Float>) {
        api.moveTo(sprite.ptr, point.x, point.y)
    }
    
    public func move(_ sprite: Sprite, by point: Point<Float>) {
        api.moveBy(sprite.ptr, point.x, point.y)
    }
    
    public func getPosition(_ sprite: Sprite) -> Point<Float> {
        var x: Float = 0
        var y: Float = 0
        api.getPosition(sprite.ptr, &x, &y)
        return Point(x: x, y: y)
    }
    
    public func setImage(_ image: Image, to sprite: Sprite, flip: BitmapFlip = .unflipped) {
        api.setImage(sprite.ptr, image.ptr, .init(flip.cValue))
    }
    
    public func getImage(_ sprite: Sprite) -> Image {
        Image(api.getImage(sprite.ptr))
    }
    
    public func setSize(_ size: Size<Float>, to sprite: Sprite) {
        api.setSize(sprite.ptr, size.width, size.height)
    }
    
    public func setZIndex(_ zIndex: Int16, to sprite: Sprite) {
        api.setZIndex(sprite.ptr, zIndex)
    }
    
    public func getZIndex(_ sprite: Sprite) -> Int16 {
        api.getZIndex(sprite.ptr)
    }
    
    public func setTag(_ tag: UInt8, to sprite: Sprite) {
        api.setTag(sprite.ptr, tag)
    }
    
    public func getTag(_ sprite: Sprite) -> UInt8 {
        api.getTag(sprite.ptr)
    }
    
    public func setDrawMode(_ mode: BitmapDrawMode, to sprite: Sprite) {
        api.setDrawMode(sprite.ptr, .init(mode.cValue))
    }
    
    public func setImageFlip(_ flip: BitmapFlip, to sprite: Sprite) {
        api.setImageFlip(sprite.ptr, .init(flip.cValue))
    }
    
    public func getImageFlip(_ sprite: Sprite) -> BitmapFlip {
        .init(api.getImageFlip(sprite.ptr))
    }
    
    public func getSpriteCount() -> Int32 {
        api.getSpriteCount()
    }
    
    public func updateAndDrawSprites() {
        api.updateAndDrawSprites()
    }
    
    public func addSprite(_ sprite: Sprite) {
        api.addSprite(sprite.ptr)
    }
    
    public func removeSprite(_ sprite: Sprite) {
        api.removeSprite(sprite.ptr)
    }
    
    public func setCollideRect(_ rect: Rect<Float>, to sprite: Sprite) {
        api.setCollideRect(sprite.ptr, rect.toPD())
    }
    
    // handler: (sprite, other) -> Type
    public func setCollisionResponseFunction(
        _ sprite: Sprite,
        handler: (@convention(c) (OpaquePointer?, OpaquePointer?) -> SpriteCollisionResponseType)?
    ) {
        api.setCollisionResponseFunction(sprite.ptr, handler)
    }
    
    // handler: (Sprite pointer) -> Void
    public func setUpdateFunction(_ sprite: Sprite, handler: (@convention(c) (OpaquePointer?) -> Void)?) {
        api.setUpdateFunction(sprite.ptr, handler)
    }
    
    public func setDrawFunction(_ sprite: Sprite, handler: (@convention(c) (OpaquePointer?, PDRect, PDRect) -> Void)?) {
        api.setDrawFunction(sprite.ptr, handler)
    }
    
    public func markDirty(_ sprite: Sprite) {
        api.markDirty(sprite.ptr)
    }
}
