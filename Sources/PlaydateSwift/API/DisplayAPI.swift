import CPlaydate

// https://sdk.play.date/1.12.3/#M-display
public class DisplayAPI {
    public let api: playdate_display
    
    init(api: playdate_display) {
        self.api = api
    }
    
    public var refreshRate: Int = 30 {
        didSet {
            api.setRefreshRate(Float(refreshRate))
        }
    }
    
    public func flush() {
        fatalError()
    }
    
    public var height: CInt {
        api.getHeight()
    }
    
    public var width: CInt {
        api.getWidth()
    }
    
    public var size: Size<CInt> {
        Size(width: width, height: height)
    }
    
    public var rect: Rect<CInt> {
        Rect(point: .zero, size: size)
    }
    
    public var scale: ValidScale = .x1 {
        didSet {
            api.setScale(UInt32(scale.rawValue))
        }
    }
    
    public var inverted: Bool = false {
        didSet {
            api.setInverted(inverted.toCInt())
        }
    }
    
    public var mosaic: Point<ValidMosaicValue> = .zero {
        didSet {
            api.setMosaic(
                mosaic.x.cValue,
                mosaic.y.cValue
            )
        }
    }
    
    public var offset: Point<CInt> = .zero {
        didSet {
            api.setOffset(offset.x, offset.y)
        }
    }
    
    public func setFlipped(_ point: Point<Bool>) {
        let CIntPoint = point.toCInt()
        api.setFlipped(CIntPoint.x, CIntPoint.y)
    }
    
    public func loadImage(path: String) {
        fatalError()
    }
}

