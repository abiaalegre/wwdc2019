import SpriteKit

struct Sprite {
    let node : SKSpriteNode
    let animations : [SKTexture]
}

struct PhysicsCategories{
    static let newton : UInt32 = 0x1 << 0
    static let apple : UInt32 = 0x1 << 1
    static let ground : UInt32 = 0x1 << 2
}

class GameScene : SKScene {
    
    var newtonSprite : Sprite!
    //tamanho do device
    var windowSize : CGSize!
    
    override init(size : CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        self.windowSize = UIScreen.main.bounds.size
        
        guard let scene = self.scene else { return }
        scene.backgroundColor = #colorLiteral(red: 0.368627451, green: 0.7333333333, blue: 0.7921568627, alpha: 1)
        print("gravidade: \(scene.physicsWorld.gravity)")
        //scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        //carregando a arvore
        let treeSprite = loadSprite(imageName: "tree", sizePercentage: 0.35)
        let treeNode = treeSprite.node
        treeNode.position = CGPoint(x: treeNode.size.width/2, y: treeNode.size.height/2)
        //adicionando a maca na cena
        scene.addChild(treeNode)
        
        //carregando sprite do newton
        newtonSprite = loadSprite(imageName: "newton", sizePercentage: 0.3, animated: true, frames: 2)
        
        let newtonNode = newtonSprite.node
        newtonNode.position = CGPoint(x: windowSize.width * 0.6, y:  newtonNode.size.height/2)
        newtonNode.physicsBody = SKPhysicsBody(texture: newtonSprite.animations[0], size:  newtonNode.size)
        newtonNode.physicsBody?.affectedByGravity = false
        //newtonNode.physicsBody?.pinned = true
        newtonNode.physicsBody?.isDynamic = false
        newtonNode.physicsBody?.categoryBitMask = PhysicsCategories.newton
        newtonNode.physicsBody?.contactTestBitMask = PhysicsCategories.apple
        newtonNode.physicsBody?.collisionBitMask = PhysicsCategories.apple

        //adicinando o newton na cena
        scene.addChild(newtonNode)
        
        //carregando o sprite da maca
        let appleSprite = loadSprite(imageName: "apple", sizePercentage: 0.35)
        let appleNode = appleSprite.node
        appleNode.position = CGPoint(x: windowSize.width * 0.6, y: treeNode.position.y * 1.2)
        //adicionando physics body a maca
        appleNode.physicsBody = SKPhysicsBody(circleOfRadius: appleNode.size.width/2)
        appleNode.physicsBody?.affectedByGravity = false
        appleNode.physicsBody?.categoryBitMask = PhysicsCategories.apple
        appleNode.physicsBody?.collisionBitMask = PhysicsCategories.newton | PhysicsCategories.ground
        //adicionando a maca na cena
        scene.addChild(appleNode)
        self.wiggleAnimation(apple: appleNode)
        
        //adicionando o chao
        let floor = SKShapeNode(rect: CGRect(x: 0, y: 0, width: windowSize.width, height: 1))
        floor.fillColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        floor.position = CGPoint(x: 0, y: 0)
        print("tamanho do chao: \(floor.frame.size)")
        print("posicao do chao: \(floor.position)")
        floor.physicsBody = SKPhysicsBody(rectangleOf: floor.frame.size, center: CGPoint(x: floor.frame.width/2, y: floor.frame.height/2))
        floor.physicsBody?.affectedByGravity = false
        floor.physicsBody?.isDynamic = false
        floor.physicsBody?.categoryBitMask = PhysicsCategories.ground
        floor.physicsBody?.collisionBitMask = PhysicsCategories.apple
        
        scene.addChild(floor)
       
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
    }
    
    func loadSprite(imageName : String, sizePercentage : CGFloat, animated: Bool = false, frames: Int = 1) -> Sprite{
        
        var textures = [SKTexture]()
        for i in 0..<frames{
            let textureName = imageName + String(i) + ".png"
            print(textureName)
            let texture = SKTexture(imageNamed: textureName)
            print(texture)
            textures.append(texture)
        }
        
        let spriteNode = SKSpriteNode(texture: textures[0])
        spriteNode.scale(to: CGSize(width: spriteNode.size.width * sizePercentage, height: spriteNode.size.height * sizePercentage))
        let sprite = Sprite(node: spriteNode, animations: textures)
        
        return sprite
    }
    
    
    func wiggleAnimation(apple : SKSpriteNode){
        //change anchor point
        // apple.anchorPoint = CGPoint(x: apple.size.width/2, y: 0)
        
        var angle = Float(-50).degreesToRadians
        let rotationRight = SKAction.rotate(toAngle: CGFloat(angle), duration: 0.3)
        angle = Float(50).degreesToRadians
        let rotationLeft = SKAction.rotate(toAngle: CGFloat(angle), duration: 0.35)
        
        let ativarGravidade = SKAction.run {
            apple.physicsBody?.affectedByGravity = true
        }
        
        let sequence = SKAction.sequence([rotationRight, rotationLeft])
        let rotation = SKAction.repeat(sequence, count: 2)
        let animation = SKAction.sequence([rotation, ativarGravidade])
        
        apple.run(animation)
        
    }
    
    func ouchAnimation(){
        let wait = SKAction.wait(forDuration: 0.5)
        let ouch = SKAction.setTexture(newtonSprite.animations[1])
        let idle = SKAction.setTexture(newtonSprite.animations[0])
        
        let animation = SKAction.sequence([ouch, wait, idle])
        newtonSprite.node.run(animation)
    }
    
}

extension GameScene : SKPhysicsContactDelegate{

    public func didBegin(_ contact: SKPhysicsContact) {

        let bodyA = contact.bodyA.categoryBitMask
        let bodyB = contact.bodyB.categoryBitMask

        if bodyA == PhysicsCategories.newton && bodyB == PhysicsCategories.apple{
            ouchAnimation()
        }

        if bodyA == PhysicsCategories.apple && bodyB == PhysicsCategories.newton{
            ouchAnimation()
        }

    }
}

extension BinaryInteger {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}


