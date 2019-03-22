import UIKit
import SpriteKit
import PlaygroundSupport

struct Sprite {
    let node : SKSpriteNode
    let animations : [SKTexture]
}

struct PhysicsCategories{
    static let newton : UInt32 = 0x1 << 0
    static let apple : UInt32 = 0x1 << 1
    static let ground : UInt32 = 0x1 << 2
}

@objc(C1P2)
public class C1P2: UIViewController,PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    //view que armazena a cena do jogo
    var sceneView : SKView!
    //cena do jogo
    var scene : SKScene!
    //tamanho do device
    var windowSize : CGSize!
    
    public override func viewDidLoad() {
        
        self.windowSize = UIScreen.main.bounds.size
        //cria a scene view
        self.sceneView = SKView(frame: CGRect(x: 0, y: 0, width: windowSize.width, height: windowSize.height))
        
        self.sceneView.showsFPS = true
        self.sceneView.showsPhysics = true
        
        
        
        //cria a cena
        self.scene = createScene()
        self.scene.physicsWorld.contactDelegate = self
        //adiciona a cena na sceneview
        self.sceneView.presentScene(self.scene)
        self.view.addSubview(sceneView)
        

    }
    
    func createScene() -> SKScene {
        
        let scene = SKScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
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
        let newtonSprite = loadSprite(imageName: "newton", sizePercentage: 0.3, animated: true, frames: 1)
        
        let newtonNode = newtonSprite.node
        newtonNode.position = CGPoint(x: windowSize.width * 0.6, y:  newtonNode.size.height/2)
         newtonNode.physicsBody = SKPhysicsBody(texture: newtonSprite.animations[0], size:  newtonNode.size)
        newtonNode.physicsBody?.affectedByGravity = false
        //newtonNode.physicsBody?.pinned = true
        newtonNode.physicsBody?.isDynamic = false
        newtonNode.physicsBody?.categoryBitMask = PhysicsCategories.newton
        //adicinando o newton na cena
        scene.addChild(newtonNode)
        
        //carregando o sprite da maca
        let appleSprite = loadSprite(imageName: "apple", sizePercentage: 0.35)
        let appleNode = appleSprite.node
        appleNode.position = CGPoint(x: windowSize.width * 0.6, y: treeNode.position.y * 1.2)
        //adicionando a maca na cena
        scene.addChild(appleNode)
        //adicionando physics body a maca
        appleNode.physicsBody = SKPhysicsBody(circleOfRadius: appleNode.size.width/2)
        appleNode.physicsBody?.affectedByGravity = true
        appleNode.physicsBody?.categoryBitMask = PhysicsCategories.apple
        appleNode.physicsBody?.collisionBitMask = PhysicsCategories.newton | PhysicsCategories.ground

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
        
        return scene
        
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
    
    
}

extension C1P2 : SKPhysicsContactDelegate{
    public func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        
        if((firstBody.categoryBitMask & PhysicsCategories.newton != 0) && (secondBody.categoryBitMask & PhysicsCategories.apple != 0)){
            print("newton and apple Contact")
            
        }
        
    }

}
