import CPlaydate

public struct Graphics {
    public let graphics: playdate_graphics
    
    public func drawLine(
        from: Point<Int32>,
        to: Point<Int32>,
        lineWidth: Int32 = 1,
        color: Color
    ) {
        graphics.drawLine(
            from.x,
            to.x,
            from.y,
            to.y,
            lineWidth,
            LCDColor(color.cValue)
        )
    }
    
    public func setLiveCapStyle(_ style: LineCapStyle) {
        graphics.setLineCapStyle(style.cStyle)
    }
    
    public func setDrawPixel() {
        fatalError()
    }
}
 
extension Graphics {
    public func drawRect(_ rect: Rect<Int32>, color: Color) {
        graphics.drawRect(
            rect.point.x,
            rect.point.y,
            rect.size.width,
            rect.size.height,
            .init(color.cValue)
        )
    }
    
    public func fillRect(_ rect: Rect<Int32>, color: Color) {
        graphics.fillRect(
            rect.point.x,
            rect.point.y,
            rect.size.width,
            rect.size.height,
            .init(color.cValue)
        )
    }
}

extension Graphics {
    public func drawRoundRect(_ rect: Rect<Int32>, color: Color) {
        fatalError()
    }
    
    public func fillRoundRect(_ rect: Rect<Int32>, color: Color) {
        fatalError()
    }
}

extension Graphics {
    public func drawArc(_ rect: Rect<Int32>, color: Color) {
        fatalError()
    }
}
 
extension Graphics {
    public func drawCircle(at point: Point<Int32>, radius: Int, color: Color) {
        fatalError()
    }
    
    public func drawCircle(in rect: Rect<Int32>, color: Color) {
        fatalError()
    }
    
    public func fillCircle(at point: Point<Int32>, radius: Int, color: Color) {
        fatalError()
    }
    
    public func fillCircle(in rect: Rect<Int32>, color: Color) {
        fatalError()
    }
}

extension Graphics {
    public func newImage(width: Int32, height: Int32, color: Color) -> Image {
        let ptr = graphics.newBitmap(width, height, .init(color.cValue))
        return Image(ptr)
    }
    
    public func loadImage(path: String) throws -> Image {
        // TODO: Handle Error
        let ptr = graphics.loadBitmap(path, nil)
        return Image(ptr)
    }
    
    public func drawImage(_ image: Image, point: Point<Int32> = .zero, flip: BitmapFlip = .unflipped) {
        graphics.drawBitmap(image.ptr, point.x, point.y, LCDBitmapFlip(flip.cValue))
    }
    
    public func clear(_ image: Image, color: Color) {
        graphics.clearBitmap(image.ptr, .init(color.cValue))
    }
    
    public func drawScaledImage(_ image: Image, point: Point<Int32>, scaleX: Float, scaleY: Float) {
        graphics.drawScaledBitmap(image.ptr, point.x, point.y, scaleX, scaleY)
    }
    
    public func drawRotatedImage(_ image: Image, point: Point<Int32>, rotation: Float, centerX: Float, centery: Float, xScale: Float, yScale: Float) {
        graphics.drawRotatedBitmap(image.ptr, point.x, point.y, rotation, centery, centery, xScale, yScale)
    }
}

