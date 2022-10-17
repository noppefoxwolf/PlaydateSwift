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
        
//        if playdate.buttonJustPressed("B") or playdate.buttonJustPressed("A") then
//                playerFire()
//            end
//
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
            
            
            //
            //            local actualX, actualY, collisions, length = plane:moveWithCollisions(plane.x + dx, plane.y + dy)
            //            for i = 1, length do
            //                local collision = collisions[i]
            //                if collision.other.isEnemy == true then    -- crashed into enemy plane
            //                    destroyEnemyPlane(collision.other)
            //                    collision.other:remove()
            //                    score -= 1
            //                end
            //            end
            //
            //        end
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
        let rect = Rect<Int32>(x: 50, y: 50, width: 10, height: 10)
        api.graphics.drawRect(rect, color: .black)
    }
    
    override func onPushedBButton() {
        do {
            let image = try api.graphics.loadImage(path: "background")
            api.graphics.drawImage(image)
        } catch let error as CError {
            api.error(message: error.description)
        } catch {}
    }
}

extension SpriteAPI {
    func isEnemy(_ sprite: Sprite) -> Bool {
        api.getTag(sprite.ptr) == 1
    }
    
    func setIsEnemy(_ sprite: Sprite, flag: Bool) {
        api.setTag(sprite.ptr, flag ? 1 : 0)
    }
}
