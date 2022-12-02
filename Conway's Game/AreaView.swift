//
//  AreaView.swift
//  Conway's Game
//
//  Created by Michael on 12/2/22.
//

import UIKit


final class AreaView: UIView {
    
    func makePictureOfSquares(withNumberOfSquares count: Int) {
        let w = bounds.width / CGFloat(count)
        for i in 0..<count {
            for j in 0..<count {
                createSquare(x: w*CGFloat(i), y: w*CGFloat(j), width: w, height: w)
            }
        }
    }
    
    func createSquare(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: CGRect(x: x, y: y, width: width, height: height)).cgPath
        
        let randomColor = UIColor(red: CGFloat.random(in: 0.1...1), green: CGFloat.random(in: 0.1...1), blue: CGFloat.random(in: 0.1...1), alpha: 1).cgColor
        rectangle.fillColor = randomColor
        
        let fillColorAnimation = CABasicAnimation(keyPath: "fillColor")
        fillColorAnimation.duration = 0.2
        fillColorAnimation.fromValue = UIColor.clear.cgColor
        fillColorAnimation.toValue = randomColor
        rectangle.add(fillColorAnimation, forKey: "fillColor")
        
        layer.addSublayer(rectangle)
    }
    
    func ChangeColorInLine(count: Int) {
        let y = CGFloat(Int.random(in: 0...49))
        for i in 0..<49 {
            let w = bounds.width / CGFloat(count)
            UIView.animate(withDuration: 2, delay: 0) {
                self.createSquare(x: w*CGFloat(i), y: y * w, width: w, height: w)
            }
            
        }
    }

    func createKey(i: Int, j: Int) -> String {
        return String(i) + "x" + String(j)
    }
    
}
