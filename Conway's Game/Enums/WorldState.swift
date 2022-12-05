//
//  ViewData.swift
//  Conway's Game
//
//  Created by Michael on 12/4/22.
//

import Foundation

enum WorldState {
    case initial
    case placeRandomLifeCell(AllDataAboutWorldToPresent)
    case makeOneStep(AllDataAboutWorldToPresent)
}
