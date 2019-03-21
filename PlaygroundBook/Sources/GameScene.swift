import SpriteKit

class GameScene : SKScene {
    
    override func sceneDidLoad() {
        guard let scene = self.scene else { return }
        print("tamanho da cena: \(scene.size)")
        if let emoji = emoji(rows: 0, cols: 0){
            emoji.position = CGPoint(x: scene.frame.width/2, y: scene.frame.height/2)
            let emojiSize = emoji.size
            emoji.scale(to: CGSize(width: emojiSize.width * 4, height: emojiSize.height * 4))
            scene.addChild(emoji)
            scene.scaleMode = .aspectFit
            scene.backgroundColor = .blue
        }
    }
    
    func createGrid(sceneSize : CGSize) -> [CAShapeLayer]{
      
        
        let lineHorizontal1 = Line()
        let lineHorizontal2 = Line()
        let lineVertical1 = Line()
        let lineVertical2 = Line()
        
        print("AAAAA \(sceneSize)")
        
        let margemX = (UIScreen.main.bounds.width - sceneSize.width) * 0.5
        let margemY = (UIScreen.main.bounds.height - sceneSize.height) * 0.5
       
        let y1 = margemY + sceneSize.height * 0.33
        let y2 = margemY + sceneSize.height * 0.66
        let x1 = margemX
        let x2 = margemX + sceneSize.width
    
        lineHorizontal1.createLine(posX: x1, posY: y1, finalX: x2, finalY: y1)
        lineHorizontal2.createLine(posX: x1, posY: y2, finalX: x2, finalY: y2)
        
        
        lineVertical1.createLine(posX: margemX + sceneSize.width * 0.33, posY: margemY, finalX: margemX + sceneSize.width * 0.33, finalY: margemY + sceneSize.height)
        
        lineVertical2.createLine(posX: margemX + sceneSize.width * 0.66, posY: margemY, finalX: margemX + sceneSize.width * 0.66, finalY: margemY + sceneSize.height)
        
//
//        lineHorizontal1.createLine(posX: bounds.width * 0.1, posY: bounds.height * 0.4, newValue:  bounds.width * 0.9, direction: 1)
//        lineHorizontal2.createLine(posX: bounds.width * 0.1, posY: bounds.height * 0.6, newValue: bounds.width * 0.9, direction: 1)
        
        lineHorizontal1.animate()
        lineHorizontal2.animate()
        lineVertical1.animate()
        lineVertical2.animate()
        
        return [lineHorizontal1, lineHorizontal2, lineVertical1, lineVertical2]
        
    }
    
    func emoji(rows : Int, cols: Int) -> SKSpriteNode?{
        
        guard let emoji = "🧤".image() else {
            print("falha ao converter emoji para image")
            return nil
        }
        
        let texture = SKTexture(image: emoji)
        let sprite = SKSpriteNode(texture: texture)
        
        return sprite
    }
    
}
