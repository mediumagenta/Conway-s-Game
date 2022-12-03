//
//  AreaView.swift
//  Conway's Game
//
//  Created by Michael on 12/2/22.
//

import UIKit


final class WorldView: UIView {
    

    var worldAreaSize = 300
    var worldManager = WorldManager(sizeOfWorldArea: 300, numOfRandomLifeCells: 6000)
    
    func createRandomPositions(numberOfPositions count: Int) {
        worldManager.createRandomLifeCells(numberOfCells: count)
    }
    
    func makeStap() {
        worldManager.makeGameStap()
        createWorld()
    }
    
    private func floatFromKey(_ str: String) -> (x: CGFloat, y: CGFloat) {
        let strArray = str.components(separatedBy: " ")
        guard strArray.count == 2,
              let xFloat = Float(strArray[0]),
              let yFloat = Float(strArray[1]) else {
            print("error in intForKey"); return (0,0)}
        return (x: CGFloat(xFloat), y: CGFloat(yFloat))
    }
    
    func createWorld() {
        let startTime = CFAbsoluteTimeGetCurrent()
        let w = bounds.width / CGFloat(worldAreaSize)

        if let sublayersCount = layer.sublayers?.count, sublayersCount > 2000 {
            layer.sublayers?.forEach({ layer in
                if let layerName = layer.name {
                    let key = floatFromKey(layerName)
                    let cell = worldManager.checkStatusOfCell(x: Int(key.x / w), y: Int(key.y / w))
                    if cell == .wasWhiteBecameBlack || cell == .wasBlackBecameWhite {
                        layer.removeFromSuperlayer()
                        createCell(x: key.x, y: key.y, width: w, height: w, status: cell)
                    } else {
                        // нет изменений
                    }
                }
            })
        } else {
            for y in 0..<worldAreaSize {
                for x in 0..<worldAreaSize {
                    let cell = worldManager.checkStatusOfCell(x: x, y: y)
                    createCell(x: w*CGFloat(x), y: w*CGFloat(y), width: w, height: w, status: cell)
                }
            }
        }
        
        
        
        print("\nМир создан за \(CFAbsoluteTimeGetCurrent() - startTime)")
    }
    
    private func createCell(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, status: CellState) {
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: CGRect(x: y, y: x, width: width, height: height)).cgPath
        
        var fillColor: CGColor
        var startColorAnimating: CGColor //= UIColor.clear.cgColor
        var durationOfAnimation: CFTimeInterval = 0.2
        
        switch status{
        case .wasWhiteBecameWhite:
            fillColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
            startColorAnimating = fillColor
            durationOfAnimation = 0
        case .wasWhiteBecameBlack:
            startColorAnimating = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
            fillColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1).cgColor
        case .wasBlackBecameWhite:
            startColorAnimating = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1).cgColor
            fillColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
        case .wasBlackBecameBlack:
            fillColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1).cgColor
            startColorAnimating = fillColor
            durationOfAnimation = 0
        case .errorFindInDictionary:
            fillColor = UIColor.white.cgColor
            startColorAnimating = fillColor
            durationOfAnimation = 0
        }

        rectangle.fillColor = fillColor
        
        let fillColorAnimation = CABasicAnimation(keyPath: "fillColor")
        fillColorAnimation.duration = durationOfAnimation
        fillColorAnimation.fromValue = startColorAnimating
        fillColorAnimation.toValue = fillColor
        rectangle.add(fillColorAnimation, forKey: "fillColor")
        rectangle.name = "\(x) \(y)"
        layer.addSublayer(rectangle)
    }   
    
}
