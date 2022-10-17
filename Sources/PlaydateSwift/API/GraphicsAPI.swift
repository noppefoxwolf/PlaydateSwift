import CPlaydate

// https://sdk.play.date/1.12.3/#M-graphics
public class GraphicsAPI {
    public let api: playdate_graphics
    public let video: VideoAPI
    
    init(api: playdate_graphics) {
        self.api = api
        self.video = VideoAPI(api: api.video.pointee)
    }

    public func drawLine(
        from: Point<CInt>,
        to: Point<CInt>,
        lineWidth: CInt = 1,
        color: Color
    ) {
        api.drawLine(
            from.x,
            to.x,
            from.y,
            to.y,
            lineWidth,
            LCDColor(color.cValue)
        )
    }
    
    public func setLiveCapStyle(_ style: LineCapStyle) {
        api.setLineCapStyle(style.cStyle)
    }
    
    public func setDrawPixel() {
        fatalError()
    }
    
    public func setFont(_ font: Font) {
        api.setFont(font.ptr)
    }
}
 
extension GraphicsAPI {
    public func drawRect(_ rect: Rect<CInt>, color: Color) {
        api.drawRect(
            rect.point.x,
            rect.point.y,
            rect.size.width,
            rect.size.height,
            .init(color.cValue)
        )
    }
    
    public func fillRect(_ rect: Rect<CInt>, color: Color) {
        api.fillRect(
            rect.point.x,
            rect.point.y,
            rect.size.width,
            rect.size.height,
            .init(color.cValue)
        )
    }
}

extension GraphicsAPI {
    public func drawRoundRect(_ rect: Rect<CInt>, color: Color) {
        fatalError()
    }
    
    public func fillRoundRect(_ rect: Rect<CInt>, color: Color) {
        fatalError()
    }
}

extension GraphicsAPI {
    public func drawArc(_ rect: Rect<CInt>, color: Color) {
        fatalError()
    }
}
 
extension GraphicsAPI {
    public func drawCircle(at point: Point<CInt>, radius: Int, color: Color) {
        fatalError()
    }
    
    public func drawCircle(in rect: Rect<CInt>, color: Color) {
        fatalError()
    }
    
    public func fillCircle(at point: Point<CInt>, radius: Int, color: Color) {
        fatalError()
    }
    
    public func fillCircle(in rect: Rect<CInt>, color: Color) {
        fatalError()
    }
}

extension GraphicsAPI {
    public func newImage(width: CInt, height: CInt, color: Color) -> Image {
        let ptr = api.newBitmap(width, height, .init(color.cValue))
        return Image(ptr)
    }
    
    public func loadImage(path: String) throws -> Image {
        var outerr: UnsafePointer<CChar>? = nil
        let ptr = api.loadBitmap(path, &outerr)
        if let outerr {
            let err = String(cString: outerr)
            throw CError(err: err)
        }
        return Image(ptr)
    }
    
    public func drawImage(_ image: Image, point: Point<CInt> = .zero, flip: BitmapFlip = .unflipped) {
        api.drawBitmap(image.ptr, point.x, point.y, LCDBitmapFlip(flip.cValue))
    }
    
    public func clear(_ image: Image, color: Color) {
        api.clearBitmap(image.ptr, .init(color.cValue))
    }
    
    public func drawScaledImage(_ image: Image, point: Point<CInt>, scaleX: Float, scaleY: Float) {
        api.drawScaledBitmap(image.ptr, point.x, point.y, scaleX, scaleY)
    }
    
    public func drawRotatedImage(_ image: Image, point: Point<CInt>, rotation: Float, centerX: Float, centery: Float, xScale: Float, yScale: Float) {
        api.drawRotatedBitmap(image.ptr, point.x, point.y, rotation, centery, centery, xScale, yScale)
    }
    
    public func getBitmapData(_ image: Image) -> (width: CInt, height: CInt) {
        //LCDBitmap* bitmap, int* width, int* height, int* rowbytes, uint8_t** mask, uint8_t** data
        var width: CInt = 0
        var height: CInt = 0
        // TODO: rowbytes, mask, data
        api.getBitmapData(image.ptr, &width, &height, nil, nil, nil)
        return (width, height)
    }
}

// Fonts & Text
extension GraphicsAPI {
    @discardableResult
    public func drawText(_ text: String, encoding: StringEncoding = .utf8, at point: Point<CInt>) -> CInt {
        api.drawText(
            text,
            text.count,
            PDStringEncoding(encoding.cValue),
            point.x,
            point.y
        )
    }
    
    public func getFontHeight(_ font: Font) -> UInt8 {
        api.getFontHeight(font.ptr)
    }
    
    public func getFontPage(_ font: Font, characterCode: UInt32) -> FontPage {
        FontPage(api.getFontPage(font.ptr, characterCode))
    }
    
    public func getPageGlyph(_ page: FontPage, characterCode: UInt32) -> Image {
        fatalError()
    }
    
    public func loadFont(path: String) throws -> Font {
        var outerr: UnsafePointer<CChar>? = nil
        let ptr = api.loadFont(path, &outerr)
        if let outerr {
            let err = String(cString: outerr)
            throw CError(err: err)
        }
        return Font(ptr)
    }
}

// Miscellaneous
extension GraphicsAPI {
    public func clear(_ color: Color) {
        api.clear(.init(color.cValue))
    }
}
