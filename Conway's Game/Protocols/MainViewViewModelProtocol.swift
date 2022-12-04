//
//  MainViewViewModelProtocol.swift
//  Conway's Game
//
//  Created by Michael on 12/4/22.
//

import Foundation

protocol MainWorldViewViewModelProtocol {
    var updateViewData: ((ViewData) -> ())? {get set}
    var worldAreaSize: Int {get set}
    var numOfRandomLifeCells: Int {get set}
    var gamingStatus: GamingStatus {get set}

    func placeRandomLifeCell()
    func makeStep()
    func changeStatusGame()
}
