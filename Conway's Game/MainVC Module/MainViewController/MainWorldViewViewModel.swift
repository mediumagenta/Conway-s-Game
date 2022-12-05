//
//  MainWorldViewViewModel.swift
//  Conway's Game
//
//  Created by Michael on 12/4/22.
//

import Foundation

final class MainWorldViewViewModel {
    
    var updateMainVC: ((MainViewControllerState) -> ())?
    var updatedDataToWorld: ((WorldState) -> ())?
    private lazy var worldManager = WorldManager(sizeOfWorldArea: worldAreaSize, numOfRandomLifeCells: numOfRandomLifeCells)
    
    private var worldAreaSize = 50 {
        willSet {
            updateMinMaxRandomElements(worldSize: newValue)
        }
    }
    var gamingStatus: GamingStatus = .stop
    
    var coefficientForRandomNum: Float = 0.5
    private lazy var minimumRandomElements = Int(Float(worldAreaSize * worldAreaSize) * 0.6 * coefficientForRandomNum)
    private lazy var maximumRandomElements = Int(Float(worldAreaSize * worldAreaSize) * 0.8 * coefficientForRandomNum)
    lazy var numOfRandomLifeCells = Int.random(in: minimumRandomElements...maximumRandomElements) {
        willSet {
            worldManager.changeNumOfRandomCells(to: newValue)
        }
    }
    
    var timer: Timer?
    private var timeInterval: Float = 0.25
    
    
    //MARK: - Methods
    private func updateMinMaxRandomElements(worldSize: Int) {
        minimumRandomElements = Int(Float(worldSize * worldSize) * 0.6 * coefficientForRandomNum)
        maximumRandomElements = Int(Float(worldSize * worldSize) * 0.8 * coefficientForRandomNum)
        numOfRandomLifeCells = Int.random(in: minimumRandomElements...maximumRandomElements)
    }
        
    private func makeStep() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.worldManager.makeGameStep()
            if !self.worldManager.stopFlag {
                DispatchQueue.main.async {
                    self.updatedDataToWorld?(.makeOneStep(self.worldManager.dataToPresent))
                }
            } else {
                DispatchQueue.main.async {
                    self.changeStatusGame()
                    self.updateMainVC?(.stopedGame)
                    self.updateMainVC?(.showAlertOfEndGame)
                }
            }
        }
        
    }
}



//MARK: - MAinWorldViewViewModelProtocol realization
extension MainWorldViewViewModel: MainWorldViewViewModelProtocol {
    func placeRandomLifeCell() {
        gamingStatus = .stop
        DispatchQueue.global(qos: .userInteractive).async {
            self.worldManager.createRandomLifeCells(numberOfCells: self.numOfRandomLifeCells)
            DispatchQueue.main.async {
                self.updatedDataToWorld?(.placeRandomLifeCell(self.worldManager.dataToPresent))
            }
        }
    }
    
    func changeStatusGame() {
        if gamingStatus == .stop {
            gamingStatus = .start
            timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(timeInterval), repeats: true, block: { timer in
                self.makeStep()
            })
            timer?.fire()
            if !worldManager.stopFlag {
                updateMainVC?(.startedGame)
            }
        } else {
            gamingStatus = .stop
            timer?.invalidate()
            updateMainVC?(.stopedGame)
        }
    }
    
    func valueChangedAreaSize(toSize size: Float) {
        updateMainVC?(.wasChangedWorldAreaSizeSlider(Int(size)))
    }
    
    func finishChangeAreaSize(toSize count: Int) {
        worldAreaSize = count
        DispatchQueue.global(qos: .userInteractive).async {
            self.worldManager.changeWorldAreaSize(to: count)
            DispatchQueue.main.async {
                self.updatedDataToWorld?(.placeRandomLifeCell(self.worldManager.dataToPresent))
            }
        }
    }
    
    func changeAnimationSpeedCoefficient(coefficient: Float) {
        timeInterval = 1 - coefficient
    }
    
    func changeRandomLifeCellsCoefficient(coefficient: Float) {
        coefficientForRandomNum = coefficient
        updateMinMaxRandomElements(worldSize: worldAreaSize)
        DispatchQueue.global(qos: .userInteractive).async {
            self.worldManager.changeWorldAreaSize(to: self.worldAreaSize)
            DispatchQueue.main.async {
                self.updatedDataToWorld?(.placeRandomLifeCell(self.worldManager.dataToPresent))
            }
        }
    }
    
}
