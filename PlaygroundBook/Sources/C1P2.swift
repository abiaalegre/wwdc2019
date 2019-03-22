import UIKit
import SpriteKit
import PlaygroundSupport

//struct Sprite {
//    let node : SKSpriteNode
//    let animations : [SKTexture]
//}
//
//struct PhysicsCategories{
//    static let newton : UInt32 = 0x1 << 0
//    static let apple : UInt32 = 0x1 << 1
//    static let ground : UInt32 = 0x1 << 2
//}

@objc(C1P2)
public class C1P2: UIViewController,PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    //view que armazena a cena do jogo
    var sceneView : SKView!
    //cena do jogo
    var scene : SKScene!
    //tamanho do device
    var windowSize : CGSize!
    
    var newtonSprite : Sprite!
    public override func viewDidLoad() {
        
        self.windowSize = UIScreen.main.bounds.size
        //cria a scene view
        self.sceneView = SKView(frame: CGRect(x: 0, y: 0, width: windowSize.width, height: windowSize.height))
        
        self.sceneView.showsFPS = true
        self.sceneView.showsPhysics = true
        
        
        
        //cria a cena
        //self.scene = createScene()
        self.scene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.sceneView.presentScene(self.scene)
        //self.scene.physicsWorld.contactDelegate = self
        //adiciona a cena na sceneview
       self.view.addSubview(sceneView)
    }
    
}
