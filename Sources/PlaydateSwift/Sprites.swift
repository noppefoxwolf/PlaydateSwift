import CPlaydate

public struct SpriteAPI {
    public let api: playdate_sprite
    
    public func newSprite() -> LCDSprite {
        LCDSprite(api.newSprite())
    }
    
    public func copy(_ sprite: LCDSprite) -> LCDSprite {
        LCDSprite(api.copy(sprite.ptr))
    }
    
    public func free(_ sprite: LCDSprite) {
        api.freeSprite(sprite.ptr)
    }
    
    public func setBounds(_ sprite: LCDSprite, rect: Rect<Float>) {
        api.setBounds(sprite.ptr, rect.toPD())
    }
    
    public func getBounds(_ sprite: LCDSprite) -> Rect<Float> {
        let rect = api.getBounds(sprite.ptr)
        return Rect(rect)
    }
}
