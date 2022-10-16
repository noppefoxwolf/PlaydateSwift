import CPlaydate

public enum ValidMosaicValue: Int {
    case x0 = 0
    case x1 = 1
    case x2 = 2
    case x3 = 3
}

public enum ValidScale: Int {
    case x1 = 1
    case x2 = 2
    case x4 = 4
    case x8 = 8
}

public struct Rect<Value> {
    public init(point: Point<Value>, size: Size<Value>) {
        self.point = point
        self.size = size
    }
    
    public init(x: Value, y: Value, width: Value, height: Value) {
        self.init(point: Point<Value>(x: x, y: y), size: Size<Value>(width: width, height: height))
    }
    
    public let point: Point<Value>
    public let size: Size<Value>
}

extension Rect where Value == Float {
    init(_ rect: PDRect) {
        self.point = .init(x: rect.x, y: rect.y)
        self.size = .init(width: rect.width, height: rect.height)
    }
    
    func toPD() -> PDRect {
        PDRect(x: point.x, y: point.y, width: size.width, height: size.height)
    }
}

public struct Point<Value> {
    public init(x: Value, y: Value) {
        self.x = x
        self.y = y
    }
    
    public let x: Value
    public let y: Value
}

extension Point where Value == UInt32 {
    public static var zero: Point<Value> = Point(x: 0, y: 0)
}

extension Point where Value == Int32 {
    public static var zero: Point<Value> = Point(x: 0, y: 0)
}

extension Point where Value == ValidMosaicValue {
    public static var zero: Point<Value> = Point(x: .x0, y: .x0)
}


public struct Size<Value> {
    public init(width: Value, height: Value) {
        self.width = width
        self.height = height
    }
    
    public let width: Value
    public let height: Value
}

extension Size where Value == UInt32 {
    public static var zero: Size<UInt32> = Size(width: 0, height: 0)
}

public enum Color: Int {
  case black = 0
  case white
  case clear
  case xor // TODO: better name
  case pattern // TODO: should be take assc value

  init(_ lcdColor: LCDSolidColor) {
    self.init(rawValue: Int(lcdColor.rawValue))!
  }

  internal var cValue: UInt32 {
    UInt32(self.rawValue)
  }
}

public enum BitmapFlip: Int {
    case unflipped
    case flippedX
    case flippedY
    case flippedXY
    
    init(_ bitmapFlip: LCDBitmapFlip) {
        self.init(rawValue: Int(bitmapFlip.rawValue))!
    }

    internal var cValue: UInt32 {
      UInt32(self.rawValue)
    }
}

public enum LineCapStyle {
  case butt
  case square
  case round

  internal var cStyle: LCDLineCapStyle {
    switch self {
    case .butt:
      return kLineCapStyleButt
    case .square:
      return kLineCapStyleSquare
    case .round:
      return kLineCapStyleRound
    }
  }
}

public struct Button: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public init(_ buttons: PDButtons) {
        self.init(rawValue: Int(buttons.rawValue))
    }
    
    public static let left    = Button(rawValue: 1 << 0)
    public static let right   = Button(rawValue: 1 << 1)
    public static let up      = Button(rawValue: 1 << 2)
    public static let down    = Button(rawValue: 1 << 3)
    public static let b       = Button(rawValue: 1 << 4)
    public static let a       = Button(rawValue: 1 << 5)
}

open class Image {
    let ptr: OpaquePointer?
    
    init(_ ptr: OpaquePointer?) {
      self.ptr = ptr
    }
}

open class LCDSprite {
    let ptr: OpaquePointer?
    
    init(_ ptr: OpaquePointer?) {
      self.ptr = ptr
    }
}

open class MenuItem {
    let ptr: OpaquePointer?
    
    init(_ ptr: OpaquePointer?) {
      self.ptr = ptr
    }
}

public enum SystemEvent: Int {
  case initialize = 0
  case initializeLua
  case lock
  case unlock
  case pause
  case resume
  case terminate
  case keyPressed
  case keyReleased
  case lowPower

  public init(_ event: PDSystemEvent) {
    self.init(rawValue: Int(event.rawValue))!
  }
}
