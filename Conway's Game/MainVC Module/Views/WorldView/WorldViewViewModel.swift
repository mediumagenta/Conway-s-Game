//
//  WorldViewViewModel.swift
//  Conway's Game
//
//  Created by Michael on 12/4/22.
//

import Foundation

final class WorldViewViewModel: WorldViewViewModelProtocol {
    
    func checkInfoOfCell(dataToPresent data: AllDataAboutWorldToPresent, x: Int, y: Int) -> (status: CellState, hasChanges: Bool) {
        let stringKey = KeyCoderForCell.shared.stringKeyForCell(x: x, y: y)
        if let answer = data.dictionaryOfCellsInWorld[stringKey] {
            if answer == .wasBlackBecameWhite || answer == .wasWhiteBecameBlack {
                return (answer, true)
            } else {
                return (answer, false)
            }
        } else {
            return (.errorFindInDictionary, false)
        }
    }
    
    func checkInfoOfCellOfStringKey(key: String, dataToPresent data: AllDataAboutWorldToPresent) -> (status: CellState, hasChanges: Bool, x: Int, y: Int){
        let intCoordinates = KeyCoderForCell.shared.intCoordinateFromStringKey(stringKeyForCell: key)
        let cellInfo = checkInfoOfCell(dataToPresent: data, x: intCoordinates.x, y: intCoordinates.y)
        return (cellInfo.status, cellInfo.hasChanges, intCoordinates.x, intCoordinates.y)
    }
    
    func createStringKeyToLayerName(x: Int, y: Int) -> String {
        return KeyCoderForCell.shared.stringKeyForCell(x: x, y: y)
    }
}
