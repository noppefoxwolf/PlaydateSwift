import CPlaydate

// https://sdk.play.date/1.12.3/#M-display
public struct DisplayAPI {
    public let api: playdate_display
    
    public var refreshRate: Int = 30 {
        didSet {
            api.setRefreshRate(Float(refreshRate))
        }
    }
    
    public func flush() {
        fatalError()
    }
    
    public var height: Int32 {
        api.getHeight()
    }
    
    public var width: Int32 {
        api.getWidth()
    }
    
    public var size: Size<Int32> {
        Size(width: width, height: height)
    }
    
    public var rect: Rect<Int32> {
        Rect(point: .init(x: 0, y: 0), size: size)
    }
    
    public var scale: ValidScale = .x1 {
        didSet {
            api.setScale(UInt32(scale.rawValue))
        }
    }
    
    public var inverted: Bool = false {
        didSet {
            api.setInverted(inverted ? 1 : 0)
        }
    }
    
    public var mosaic: Point<ValidMosaicValue> = .zero {
        didSet {
            api.setMosaic(
                UInt32(mosaic.x.rawValue),
                UInt32(mosaic.y.rawValue)
            )
        }
    }
    
    public var offset: Point<Int32> = .zero {
        didSet {
            api.setOffset(offset.x, offset.y)
        }
    }
    
    public func setFlipped(_ point: Point<Bool>) {
        api.setFlipped(point.x ? 1 : 0, point.y ? 1: 0)
    }
    
    public func loadImage(path: String) {
        fatalError()
    }
}

