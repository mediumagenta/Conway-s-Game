//
//  AreaView.swift
//  Conway's Game
//
//  Created by Michael on 12/2/22.
//

import UIKit


final class WorldView: UIView {
    
    var viewModel: WorldViewViewModelProtocol!
    
    override init(frame: CGRect) {
        viewModel = WorldViewViewModel()
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataToPresent: ViewData = .initial {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        switch dataToPresent {
        case .initial:
            break
        case .placeRandomLifeCell(let data):
            let worldAreaSize = data.worldSize
            let dataOfCellsToPresent = data
            showStartWorldWithRandomLifeCells(worldAreaSize: worldAreaSize, dataToPresent: dataOfCellsToPresent)
        case .makeOneStep(let data):
            let worldAreaSize = data.worldSize
            let dataOfCellsToPresent = data
            makeOneStepInWorld(worldAreaSize: worldAreaSize, dataToPresent: dataOfCellsToPresent)
        }
    }
    
    private func showStartWorldWithRandomLifeCells(worldAreaSize size: Int, dataToPresent data: DataToPresent) {
        layer.sublayers?.removeAll()
        let widthAndHeightSize = bounds.width / CGFloat(size)
        for y in 0..<size {
            for x in 0..<size {
                let cellInfo = viewModel.checkInfoOfCell(dataToPresent: data, x: x, y: y)
                createCell(x: x, y: y, width: widthAndHeightSize, height: widthAndHeightSize, status: cellInfo.status)
            }
        }
    }
    
    private func makeOneStepInWorld(worldAreaSize size: Int, dataToPresent data: DataToPresent) {
        let widthAndHeightSize = bounds.width / CGFloat(size)
        if let sublayersCount = layer.sublayers?.count, sublayersCount > 0 {
            layer.sublayers?.forEach({ layer in
                if let layerName = layer.name {
                    let cellInfo = viewModel.checkInfoOfCellOfStringKey(key: layerName, dataToPresent: data)
                    if cellInfo.hasChanges {
                        layer.removeFromSuperlayer()
                        createCell(x: cellInfo.x, y: cellInfo.y, width: widthAndHeightSize, height: widthAndHeightSize, status: cellInfo.status)
                    }
                }
            })
        } else {
            for y in 0..<size {
                for x in 0..<size {
                    let cellInfo = viewModel.checkInfoOfCell(dataToPresent: data, x: x, y: y)
                    createCell(x: x, y: y, width: widthAndHeightSize, height: widthAndHeightSize, status: cellInfo.status)
                }
            }
        }
    }
    
    private func createCell(x: Int, y: Int, width: CGFloat, height: CGFloat, status: CellState) {
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: CGRect(x: CGFloat(x) * height, y: CGFloat(y) * width, width: width, height: height)).cgPath
        
        var fillColor: CGColor
        var startColorAnimating: CGColor
        var durationOfAnimation: CFTimeInterval = 0.2
        
        switch status{
        case .wasWhiteBecameWhite:
            fillColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
            startColorAnimating = fillColor
            durationOfAnimation = 0
        case .wasWhiteBecameBlack:
            fillColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1).cgColor
            startColorAnimating = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
        case .wasBlackBecameWhite:
            fillColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
            startColorAnimating = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1).cgColor
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
        rectangle.name = KeyCoderForCell.shared.stringKeyForCell(x: x, y: y)
        layer.addSublayer(rectangle)
    }

    
    //MARK: - А вот все, что ниже - нужно пихать в модель
    

}
