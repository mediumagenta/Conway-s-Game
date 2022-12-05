//
//  WorldViewViewModelProtocol.swift
//  Conway's Game
//
//  Created by Michael on 12/4/22.
//

import Foundation

protocol WorldViewViewModelProtocol {
    func checkInfoOfCell(dataToPresent data: AllDataAboutWorldToPresent, x: Int, y: Int) -> (status: CellState, hasChanges: Bool)
    func checkInfoOfCellOfStringKey(key: String, dataToPresent data: AllDataAboutWorldToPresent) -> (status: CellState, hasChanges: Bool, x: Int, y: Int)
    func createStringKeyToLayerName(x: Int, y: Int) -> String
}

