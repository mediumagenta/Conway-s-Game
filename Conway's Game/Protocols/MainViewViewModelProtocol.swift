//
//  MainViewViewModelProtocol.swift
//  Conway's Game
//
//  Created by Michael on 12/4/22.
//

import Foundation

protocol MainWorldViewViewModelProtocol {
    var updatedDataToWorld: ((WorldState) -> ())? {get set}
    var updateMainVC: ((MainViewControllerState) -> ())? {get set}
    var numOfRandomLifeCells: Int {get set}
    var gamingStatus: GamingStatus {get set}

    func placeRandomLifeCell()
    func changeStatusGame()
    func valueChangedAreaSize(toSize size: Float)
    func finishChangeAreaSize(toSize size: Int)
    func changeRandomLifeCellsCoefficient(coefficient: Float)
    func changeAnimationSpeedCoefficient(coefficient: Float)
}
