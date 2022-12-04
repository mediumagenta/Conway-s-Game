//
//  WorldViewViewModelProtocol.swift
//  Conway's Game
//
//  Created by Michael on 12/4/22.
//

import Foundation

protocol WorldViewViewModelProtocol {
    func checkInfoOfCell(dataToPresent data: DataToPresent, x: Int, y: Int) -> (status: CellState, hasChanges: Bool)
    func checkInfoOfCellOfStringKey(key: String, dataToPresent data: DataToPresent) -> (status: CellState, hasChanges: Bool, x: Int, y: Int)
}

