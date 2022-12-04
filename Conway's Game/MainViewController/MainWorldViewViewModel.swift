//
//  MainWorldViewViewModel.swift
//  Conway's Game
//
//  Created by Michael on 12/4/22.
//

import Foundation

final class MainWorldViewViewModel: MainWorldViewViewModelProtocol {
    
    var gamingStatus: GamingStatus = .stop
    var coefficientForRandomNum = 1
    
    var worldAreaSize = 50 {
        willSet {
            worldManager.changeWorldAreaSize(to: newValue)
        }
    }
    
    lazy var numOfRandomLifeCells =  Int.random(in: (Int(50 * 50 * 0.4)...Int(50 * 50 * 0.6))) {//Int.random(in: (worldAreaSize * worldAreaSize * 0.4 * coefficientForRandomNum) ... (worldAreaSize * worldAreaSize * 0.6 * coefficientForRandomNum)) {
        willSet {
            worldManager.changeNumOfRandomCells(to: newValue)
        }
    }
    
    private lazy var worldManager = WorldManager(sizeOfWorldArea: worldAreaSize, numOfRandomLifeCells: numOfRandomLifeCells)
    
    var updateViewData: ((ViewData) -> ())?
    var timer: Timer?
    
    func changeStatusGame() {
        if gamingStatus == .stop {
            gamingStatus = .start
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
                self.makeStep()
            })
            timer?.fire()
        } else {
            gamingStatus = .stop
            timer?.invalidate()
        }
    }
    
    func placeRandomLifeCell() {
        gamingStatus = .stop
        DispatchQueue.global(qos: .userInteractive).async {
            self.worldManager.createRandomLifeCells(numberOfCells: self.numOfRandomLifeCells)
            DispatchQueue.main.async {
                self.updateViewData?(.placeRandomLifeCell(self.worldManager.dataToPresent))
            }
        }
    }
    
    func makeStep() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.worldManager.makeGameStep()
            DispatchQueue.main.async {
                self.updateViewData?(.makeOneStep(self.worldManager.dataToPresent))
            }
        }
        
    }
}
