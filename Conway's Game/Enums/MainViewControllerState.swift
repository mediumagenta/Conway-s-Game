//
//  MainVCStates.swift
//  Conway's Game
//
//  Created by Michael on 12/5/22.
//

import Foundation

enum MainViewControllerState {
    case startedGame
    case stopedGame
    case addedRandomLifeCells
    case wasChangedWorldAreaSizeSlider(Int)
    case showAlertOfEndGame
}
