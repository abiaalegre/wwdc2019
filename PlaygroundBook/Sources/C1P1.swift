import UIKit
import SpriteKit
import PlaygroundSupport


@objc(C1P1)
public class C1P1: UIViewController, UIGestureRecognizerDelegate,PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    var sceneView : SKView!
    var scene : GameScene?
    var linesPath = [CAShapeLayer]()
    var sceneSize : CGSize!
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
        tap.delegate = self // This is not required
        view.addGestureRecognizer(tap)
        
        let bounds = UIScreen.main.bounds
        
        let lowerValue = bounds.width > bounds.height ? bounds.height : bounds.width
        
        //Armazena o formato da uiView global, sendo ele quadrado e baseado no menor valor do aspect ratio do device
        self.sceneSize = CGSize(width: lowerValue, height: lowerValue)
        
        sceneView = SKView(frame: CGRect(x: 0, y: 0, width: sceneSize.width, height: sceneSize.height))
        scene = GameScene(size: sceneSize)
        sceneView.presentScene(scene)
        view.addSubview(sceneView)
        
        self.drawGrid()
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
    
    func drawGrid(){
       
        guard let scene = self.scene, let sceneView = self.sceneView else { return }

        linesPath = scene.createGrid(sceneSize: self.sceneSize)
        for line in linesPath{
            sceneView.layer.addSublayer(line)
            line.frame = view.bounds
        }
        
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        linesPath.forEach { (layer) in
            layer.path = nil
        }
        self.drawGrid()
    }
    
    @objc func didTap(_ sender: UITapGestureRecognizer) {
        
        print("tap location \(sender.location(in: self.view))")
        
    }}

