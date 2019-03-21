//
//  Line.swift
//  Book_Sources
//
//  Created by Stuginski Facchina on 20/03/19.
//

import UIKit

class Line : CAShapeLayer{
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createLine(posX: CGFloat, posY : CGFloat, finalX : CGFloat, finalY : CGFloat){
        self.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        self.lineWidth = 4
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: posX, y: posY))
        path.addLine(to: CGPoint(x: finalX, y: finalY))
        
        self.path = path.cgPath
        
    }
    
    func animate(){
        
        // animate it
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 1
        self.add(animation, forKey: "MyAnimation")
    }
    
}
