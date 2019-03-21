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
        
        let lines = [Line(), Line(), Line(), Line()]

        let margemX = (UIScreen.main.bounds.width - sceneSize.width) * 0.5
        let margemY = (UIScreen.main.bounds.height - sceneSize.height) * 0.5
        
        //positions of horizontal lines
        var y1 = margemY + sceneSize.height * 0.33
        var x1 = margemX
        var y2 = margemY + sceneSize.height * 0.66
        var x2 = margemX + sceneSize.width
    
        //horizontal lines
        lines[0].createLine(posX: x1, posY: y1, finalX: x2, finalY: y1)
        lines[1].createLine(posX: x1, posY: y2, finalX: x2, finalY: y2)
        
        
        //positions of vertical lines
        y1 = margemY
        y2 = margemY + sceneSize.height
        x1 = margemX + sceneSize.width * 0.33
        x2 = margemX + sceneSize.width * 0.66
        //vertical lines
        lines[2].createLine(posX: x1, posY: margemY, finalX: x1, finalY: margemY + sceneSize.height)
        lines[3].createLine(posX: x2, posY: margemY, finalX: x2, finalY: margemY + sceneSize.height)
        
        //animate lines
        lines.forEach { (line) in
            line.animate()
        }
        
        return lines
        
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
