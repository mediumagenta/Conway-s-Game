//
//  WorldManager.swift
//  Conway's Game
//
//  Created by Michael on 12/3/22.
//

import Foundation

struct WorldManager {
    
    private var dictionaryOfLivingCells: [String: CellState] = [:]
    private var worldAreaSize: Int
    private var numOfRandomLifeCells: Int

    init(sizeOfWorldArea: Int, numOfRandomLifeCells: Int) {
        worldAreaSize = sizeOfWorldArea
        self.numOfRandomLifeCells = numOfRandomLifeCells
    }
    
    mutating func createRandomLifeCells(numberOfCells count: Int) {
        numOfRandomLifeCells = count
        for _ in 1..<numOfRandomLifeCells {
            let xRandom = Int.random(in: 0..<worldAreaSize)
            let yRandom = Int.random(in: 0..<worldAreaSize)
            let key = stringKeyForCell(x: xRandom, y: yRandom)
            dictionaryOfLivingCells[key] = .wasWhiteBecameBlack
        }
    }
    
    mutating func makeGameStap() {
        var updatedDictionaryOfLivingCells = dictionaryOfLivingCells
        for y in 0..<worldAreaSize {
            for x in 0..<worldAreaSize {
                if checkLifeInCell(x: x, y: y) {
                    if (2...3).contains(livingNeighborsAround(x: x, y: y)) {
                        updatedDictionaryOfLivingCells[stringKeyForCell(x: x, y: y)] = .wasBlackBecameBlack
                    } else {
                        updatedDictionaryOfLivingCells[stringKeyForCell(x: x, y: y)] = .wasBlackBecameWhite
                    }
                } else {
                    if livingNeighborsAround(x: x, y: y) == 3 {
                        updatedDictionaryOfLivingCells[stringKeyForCell(x: x, y: y)] = .wasWhiteBecameBlack
                    } else {
                        updatedDictionaryOfLivingCells[stringKeyForCell(x: x, y: y)] = .wasWhiteBecameWhite
                    }
                }
            }
        }
        dictionaryOfLivingCells = updatedDictionaryOfLivingCells
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
        switch dictionaryOfLivingCells[stringKeyForCell(x: x, y: y)] {
        case .wasBlackBecameBlack, .wasWhiteBecameBlack:
            return true
        default:
            return false
        }
    }
    
    func checkStatusOfCell(x: Int, y: Int) -> CellState {
        if let answer = dictionaryOfLivingCells [stringKeyForCell(x: x, y: y)] {
            return answer
        } else {
            return .errorFindInDictionary
        }
    }
    
    private func stringKeyForCell(x: Int, y: Int) -> String {
        return String(x) + " " + String(y)
    }
}
