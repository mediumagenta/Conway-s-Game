//
//  WorldManager.swift
//  Conway's Game
//
//  Created by Michael on 12/3/22.
//

import Foundation

struct WorldManager {
    
    private var dictionaryOfCellsInWorld: [String: CellState] = [:]
    private var worldAreaSize: Int
    private var numOfRandomLifeCells: Int
    var dataToPresent = DataToPresent()

    init(sizeOfWorldArea: Int, numOfRandomLifeCells: Int) {
        worldAreaSize = sizeOfWorldArea
        self.numOfRandomLifeCells = numOfRandomLifeCells
        createRandomLifeCells(numberOfCells: numOfRandomLifeCells)
    }
    
    mutating func updateDataToPresent() {
        dataToPresent.dictionaryOfCellsInWorld = dictionaryOfCellsInWorld
        dataToPresent.worldSize = worldAreaSize
    }
    
    mutating func changeWorldAreaSize(to newSize: Int) {
        worldAreaSize = newSize
    }
    
    mutating func changeNumOfRandomCells(to newNum: Int) {
        numOfRandomLifeCells = newNum
    }

    mutating func clearAllWorld() {
        for y in 0..<worldAreaSize {
            for x in 0..<worldAreaSize {
                let stringKey = KeyCoderForCell.shared.stringKeyForCell(x: x, y: y)
                dictionaryOfCellsInWorld[stringKey] = .wasWhiteBecameWhite
            }
        }
    }
    
    mutating func createRandomLifeCells(numberOfCells count: Int) {
        clearAllWorld()
        for _ in 1...count {
            let xRandom = Int.random(in: 2..<worldAreaSize-2)
            let yRandom = Int.random(in: 2..<worldAreaSize-2)
            let stringKey = KeyCoderForCell.shared.stringKeyForCell(x: xRandom, y: yRandom)
            dictionaryOfCellsInWorld[stringKey] = .wasWhiteBecameBlack
        }
        updateDataToPresent()
    }
    
    mutating func makeGameStep() {
        var updatedDictionaryOfLivingCells = dictionaryOfCellsInWorld
        for y in 0..<worldAreaSize {
            for x in 0..<worldAreaSize {
                let stringKey = KeyCoderForCell.shared.stringKeyForCell(x: x, y: y)
                if checkLifeInCell(x: x, y: y) {
                    if (2...3).contains(livingNeighborsAround(x: x, y: y)) {
                        updatedDictionaryOfLivingCells[stringKey] = .wasBlackBecameBlack
                    } else {
                        updatedDictionaryOfLivingCells[stringKey] = .wasBlackBecameWhite
                    }
                } else {
                    if livingNeighborsAround(x: x, y: y) == 3 {
                        updatedDictionaryOfLivingCells[stringKey] = .wasWhiteBecameBlack
                    } else {
                        updatedDictionaryOfLivingCells[stringKey] = .wasWhiteBecameWhite
                    }
                }
            }
        }
        dictionaryOfCellsInWorld = updatedDictionaryOfLivingCells
        updateDataToPresent()
    }
    
    private func livingNeighborsAround(x: Int, y: Int) -> Int {
        var countLivingCellsAround = 0
        
        if checkLifeInCell(x: x - 1, y: y - 1) {
            countLivingCellsAround += 1
        }
        if checkLifeInCell(x: x,   y: y - 1) {
            countLivingCellsAround += 1
        }
        if checkLifeInCell(x: x + 1, y: y - 1) {
            countLivingCellsAround += 1
        }
        
        if checkLifeInCell(x: x - 1, y: y) {
            countLivingCellsAround += 1
        }
        if checkLifeInCell(x: x + 1, y: y) {
            countLivingCellsAround += 1
        }
        
        if checkLifeInCell(x: x - 1, y: y + 1) {
            countLivingCellsAround += 1
        }
        if checkLifeInCell(x: x,   y: y + 1) {
            countLivingCellsAround += 1
        }
        if checkLifeInCell(x: x + 1, y: y + 1) {
            countLivingCellsAround += 1
        }
        
        return countLivingCellsAround
    }
    
    private func checkLifeInCell(x: Int, y: Int) -> Bool {
        let stringKey = KeyCoderForCell.shared.stringKeyForCell(x: x, y: y)
        switch dictionaryOfCellsInWorld[stringKey] {
        case .wasBlackBecameBlack, .wasWhiteBecameBlack:
            return true
        default:
            return false
        }
    }
    
    func checkStatusOfCell(x: Int, y: Int) -> CellState {
        let stringKey = KeyCoderForCell.shared.stringKeyForCell(x: x, y: y)
        if let answer = dictionaryOfCellsInWorld [stringKey] {
            return answer
        } else {
            print("Произошла ошибка в поиске индекса")
            return .errorFindInDictionary
        }
    }
}
