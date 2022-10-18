import PlaydateSwift
import CPlaydate

final class App: PlaydateSwift.App {
    lazy var font: Font = { try! api.graphics.loadFont(path: "font/whiteglove-stroked") }()
    
    var maxEnemies = 10
    var enemyCount = 0
    
    var maxBackgroundPlanes = 10
    var backgroundPlaneCount = 0
    
    var score: Int32 = 0
    
    var bgY: CInt = 0
    var bgH: CInt = 0
    
    lazy var player: Sprite = { createPlayer(at: Point(x: 200, y: 180)) }()
    
    override init(playdate: PlaydateAPI) {
        super.init(playdate: playdate)
    }
    
    override func setup() {
        super.setup()
        createBackgroundSprite()
        _ = player
    }
    
    override func update() -> Bool {
        super.update()
        
        spawnEnemyIfNeeded()
        spawnBackgroundPlaneIfNeeded()
        
        api.sprite.updateAndDrawSprites()
        
        api.graphics.setFont(font)
        api.graphics.drawText("sprite count: \(api.sprite.getSpriteCount())", at: Point(x: 2, y: 2))
        api.graphics.drawText("max enemies: \(maxEnemies)", at: Point(x: 2, y: 16))
        api.graphics.drawText("score: \(score)", at: Point(x: 2, y: 30))
        api.system.drawFPS(point: Point<Int32>(x: 2, y: 224))
        
        return true
    }
    
    func createPlayer(at point: Point<Float>) -> Sprite {
        let plane = api.sprite.newSprite()
        let planeImage = try! api.graphics.loadImage(path: "player")
        let size = app.api.graphics.getBitmapData(planeImage)
        
        api.sprite.setImage(planeImage, to: plane)
        api.sprite.setCollideRect(Rect<Float>(x: 5, y: 5, width: Float(size.width - 10), height: Float(size.height - 10)), to: plane)
        api.sprite.move(plane, to: point)
        api.sprite.addSprite(plane)
        
        api.sprite.setCollisionResponseFunction(plane) { _, _ in
            kCollisionTypeOverlap
        }
        
        api.sprite.setUpdateFunction(plane) { ptr in
            let this = (app as! App)
            let plane = Sprite(ptr)
            var dx: Float = 0
            var dy: Float = 0
            
            let currentButtonState = this.api.system.currentButtonState
            if currentButtonState.contains(.up) {
                dy = -4
            }
            if currentButtonState.contains(.down) {
                dy = 4
            }
            if currentButtonState.contains(.left) {
                dx -= 4
            }
            if currentButtonState.contains(.right) {
                dx = 4
            }
            this.api.sprite.move(plane, by: Point<Float>(x: dx, y: dy))
            
            let position = app.api.sprite.getPosition(plane)
            let goal = Point<Float>(x: position.x + dx, y: position.y + dy)
            let collisions = this.api.sprite.moveWithCollisions(plane, goal: goal)
            for collision in collisions {
                if this.api.sprite.isEnemy(collision.other) {
                    this.destroyEnemyPlane(collision.other)
                    this.api.sprite.removeSprite(collision.other)
                    this.score -= 1
                }
            }
        }
        
        api.sprite.setZIndex(1000, to: plane)
        return plane
    }
    
    func createBackgroundSprite() {
        let bg = api.sprite.newSprite()
        let bgImage = try! api.graphics.loadImage(path: "background")
        let size = app.api.graphics.getBitmapData(bgImage)
        bgH = size.height
        api.sprite.setBounds(bg, rect: Rect<Float>(x: 0, y: 0, width: 400, height: 240))
        api.sprite.setDrawFunction(bg) { ptr, _, _ in
            let this = (app as! App)
            let bgImage = try! this.api.graphics.loadImage(path: "background")
            this.api.graphics.drawImage(bgImage, point: Point<CInt>(x: 0, y: this.bgY))
            this.api.graphics.drawImage(bgImage, point: Point<CInt>(x: 0, y: this.bgY - this.bgH))
        }
        api.sprite.setUpdateFunction(bg) { ptr in
            let this = (app as! App)
            let bg = Sprite(ptr)
            this.bgY += 1
            if this.bgY > this.bgH {
                this.bgY = 0
            }
            this.api.sprite.markDirty(bg)
        }
        
        api.sprite.setZIndex(0, to: bg)
        api.sprite.addSprite(bg)
    }
    
    func spawnEnemyIfNeeded() {
        if enemyCount < maxEnemies {
            if Int(Float.random(in: 0..<ceil(120.0 / Float(maxEnemies)))) == 1 {
                createEnemyPlane()
            }
        }
    }
    
    @discardableResult
    func createEnemyPlane() -> Sprite {
        let plane = api.sprite.newSprite()
        let planeImage = try! api.graphics.loadImage(path: "plane1")
        let size = app.api.graphics.getBitmapData(planeImage)
        
        api.sprite.setImage(planeImage, to: plane)
        api.sprite.setCollideRect(Rect<Float>(x: 0, y: 0, width: Float(size.width), height: Float(size.height)), to: plane)
        api.sprite.move(
            plane,
            to: Point<Float>(
                x: Float.random(in: 0..<400),
                y: -Float.random(in: 0..<30) - Float(size.height)
            )
        )
        api.sprite.addSprite(plane)

        api.sprite.setIsEnemy(plane, flag: true)
        
        enemyCount += 1

        api.sprite.setCollisionResponseFunction(plane) { _, _ in
            kCollisionTypeOverlap
        }
        
        api.sprite.setUpdateFunction(plane) { ptr in
            let plane = Sprite(ptr)
            let planeImage = app.api.sprite.getImage(plane)
            
            let position = app.api.sprite.getPosition(plane)
            let size = app.api.graphics.getBitmapData(planeImage)
            
            let newY = position.y + 4
            
            if newY > 400 + Float(size.height) {
                app.api.sprite.removeSprite(plane)
                (app as! App).enemyCount -= 1
            } else {
                app.api.sprite.move(plane, to: Point<Float>(x: position.x, y: newY))
            }
        }
        api.sprite.setZIndex(500, to: plane)
        return plane
    }
    
    func spawnBackgroundPlaneIfNeeded() {
        if backgroundPlaneCount < maxBackgroundPlanes {
            if Int(Float.random(in: 0..<floor(120.0 / Float(maxBackgroundPlanes)))) == 1 {
                createBackgroundPlane()
            }
        }
    }
    
    @discardableResult
    func createBackgroundPlane() -> Sprite {
        let plane = api.sprite.newSprite()
        let planeImage = try! api.graphics.loadImage(path: "plane2")
        
        api.sprite.setImage(planeImage, to: plane)
        api.sprite.move(plane, to: Point<Float>(x: Float.random(in: 0..<400), y: -Float.random(in: 0..<30)))
        api.sprite.addSprite(plane)
        
        backgroundPlaneCount += 1
        
        api.sprite.setUpdateFunction(plane) { ptr in
            let plane = Sprite(ptr)
            let planeImage = app.api.sprite.getImage(plane)
            
            let position = app.api.sprite.getPosition(plane)
            let size = app.api.graphics.getBitmapData(planeImage)
            
            let newY = position.y + 2
            if newY > 400 + Float(size.height) {
                app.api.sprite.removeSprite(plane)
                (app as! App).backgroundPlaneCount -= 1
            } else {
                app.api.sprite.move(plane, to: .init(x: position.x, y: newY))
            }
        }
        
        api.sprite.setZIndex(100, to: plane)
        return plane
    }
    
    override func onPushedAButton() {
        playerFire()
    }
    
    override func onPushedBButton() {
        playerFire()
    }
    
    func playerFire() {
        let s = api.sprite.newSprite()
        let img = try! api.graphics.loadImage(path: "doubleBullet")
        let size = app.api.graphics.getBitmapData(img)
        api.sprite.setImage(img, to: s)
        let playerPosition = api.sprite.getPosition(player)
        api.sprite.move(s, to: playerPosition)
        api.sprite.setCollideRect(Rect<Float>(x: 0, y: 0, width: Float(size.width), height: Float(size.height)), to: s)
        api.sprite.setCollisionResponseFunction(s, handler: { _, _ in
            kCollisionTypeOverlap
        })
        api.sprite.setUpdateFunction(s) { ptr in
            let this = (app as! App)
            let s = Sprite(ptr)
            let sPosition = this.api.sprite.getPosition(s)
            let img = this.api.sprite.getImage(s)
            let imgSize = this.api.graphics.getBitmapData(img)
            let newY = sPosition.y - 20
            if newY < -Float(imgSize.height) {
                this.api.sprite.removeSprite(s)
            } else {
                let goal = Point<Float>(x: sPosition.x, y: newY)
                let collisions = this.api.sprite.moveWithCollisions(s, goal: goal)
                for collision in collisions {
                    if this.api.sprite.isEnemy(collision.other) {
                        this.destroyEnemyPlane(collision.other)
                        this.api.sprite.removeSprite(s)
                        this.score += 1
                    }
                }
            }

        }
        api.sprite.setZIndex(999, to: s)
        api.sprite.addSprite(s)
    }
    
    func destroyEnemyPlane(_ plane: Sprite) {
        let posision = api.sprite.getPosition(plane)
        createExplosion(at: posision)
        api.sprite.removeSprite(plane)
        enemyCount -= 1
    }
    
    func createExplosion(at point: Point<Float>) {
        let s = api.sprite.newSprite()
        api.sprite.setFrame(s, frame: 1)
        let frame = api.sprite.getFrame(s)
        let img = try! api.graphics.loadImage(path: "explosion/\(frame)")
        api.sprite.setImage(img, to: s)
        api.sprite.move(s, to: point)
            
        api.sprite.setUpdateFunction(s) { ptr in
            let this = (app as! App)
            let s = Sprite(ptr)
            let newFrame = this.api.sprite.getFrame(s) + 1
            this.api.sprite.setFrame(s, frame: newFrame)
            
            if newFrame > 11 {
                this.api.sprite.removeSprite(s)
            } else {
                if let img = try? this.api.graphics.loadImage(path: "explosion/\(newFrame)") {
                    this.api.sprite.setImage(img, to: s)
                }
            }
        }

        api.sprite.setZIndex(2000, to: s)
        api.sprite.addSprite(s)
    }
}

extension SpriteAPI {
    static var enemyFlags: [Sprite : Bool] = [:]
    
    func isEnemy(_ sprite: Sprite) -> Bool {
        Self.enemyFlags[sprite] ?? false
    }
    
    func setIsEnemy(_ sprite: Sprite, flag: Bool) {
        Self.enemyFlags[sprite] = flag
    }
}

extension SpriteAPI {
    static var frame: [Sprite : CInt] = [:]
    
    func getFrame(_ sprite: Sprite) -> CInt {
        Self.frame[sprite] ?? 0
    }
    
    func setFrame(_ sprite: Sprite, frame: CInt) {
        Self.frame[sprite] = frame
    }
}
