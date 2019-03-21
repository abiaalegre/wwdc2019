import UIKit
import SpriteKit
import PlaygroundSupport


@objc(C1P1)
public class C1P1: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    var sceneView : SKView!
    var scene : GameScene?
    var linesPath = [CAShapeLayer]()
    var sceneSize : CGSize!
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let bounds = UIScreen.main.bounds
        let menorValor = bounds.width > bounds.height ? bounds.height : bounds.width
        
        self.sceneSize = CGSize(width: menorValor, height: menorValor)
        print("menor valor:", menorValor)
        print("altura: ", bounds.height)
        sceneView = SKView(frame: CGRect(x: 0, y: 0, width: sceneSize.width, height: sceneSize.height))
        
        scene = GameScene(size: sceneSize)
        sceneView.presentScene(scene)
        view.addSubview(sceneView)
        
        //pathView = UIView(frame: CGRect(x: 0, y: 0, width: sceneView.bounds.width, height: sceneView.bounds.height))

        self.drawGrid()
        
        //guard let pathView = pathView else { return }
//
//        let lines = scene.createGrid()
//        for line in lines{
//            pathView.layer.addSublayer(line)
//            line.frame = view.bounds
//        }
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        view.addSubview(sceneView)
//        self.view.insertSubview(pathView, aboveSubview: sceneView)
    }
    
    
    
    func drawGrid(){
        
        //let newPathView = SKView(frame: CGRect(x: 0, y: 0, width: sceneSize.width, height: sceneSize.height))

        //newPathView.backgroundColor = .purple
        
        guard let scene = self.scene, let sceneView = self.sceneView else { return }

        linesPath = scene.createGrid(sceneSize: self.sceneSize)
        for line in linesPath{
            sceneView.layer.addSublayer(line)
            line.frame = view.bounds
        }
        
       // newPathView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //self.pathView = newPathView
        
        //pathView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //self.view.insertSubview(pathView!, aboveSubview: sceneView)
        
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        //guard let pathView = pathView else { return }

//        let widht = sceneSize.width
//        sceneSize.width = sceneSize.height
//        sceneSize.height = widht
//
        print("alterar w \(sceneSize.width) y \(sceneSize.height)")
        linesPath.forEach { (layer) in
            layer.path = nil
        }
        
        self.drawGrid()
//        if UIDevice.current.orientation.isLandscape {
//            self.drawGrid()
//        } else {
//            self.drawGrid()
//        }
    }
}

