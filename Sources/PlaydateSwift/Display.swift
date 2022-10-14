import CPlaydate

// https://sdk.play.date/1.12.3/#M-display
public struct Display {
    public let display: playdate_display
    
    public var refreshRate: Int = 30 {
        didSet {
            display.setRefreshRate(Float(refreshRate))
        }
    }
    
    public func flush() {
        fatalError()
    }
    
    public var height: Int32 {
        display.getHeight()
    }
    
    public var width: Int32 {
        display.getWidth()
    }
    
    public var size: Size<Int32> {
        Size(width: width, height: height)
    }
    
    public var rect: Rect<Int32> {
        Rect(point: .init(x: 0, y: 0), size: size)
    }
    
    public var scale: ValidScale = .x1 {
        didSet {
            display.setScale(UInt32(scale.rawValue))
        }
    }
    
    public var inverted: Bool = false {
        didSet {
            display.setInverted(inverted ? 1 : 0)
        }
    }
    
    public var mosaic: Point<ValidMosaicValue> = .zero {
        didSet {
            display.setMosaic(
                UInt32(mosaic.x.rawValue),
                UInt32(mosaic.y.rawValue)
            )
        }
    }
    
    public var offset: Point<Int32> = .zero {
        didSet {
            display.setOffset(offset.x, offset.y)
        }
    }
    
    public func setFlipped(_ point: Point<Bool>) {
        display.setFlipped(point.x ? 1 : 0, point.y ? 1: 0)
    }
    
    public func loadImage(path: String) {
        fatalError()
    }
}

