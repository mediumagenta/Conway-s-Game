//
//  StringKeyCoder.swift
//  Conway's Game
//
//  Created by Michael on 12/4/22.
//

import Foundation

final class KeyCoderForCell {
    static let shared = KeyCoderForCell()
    
    func stringKeyForCell(x: Int, y: Int) -> String {
        return String(x) + " " + String(y)
    }
    
    func intCoordinateFromStringKey(stringKeyForCell str: String) -> (x: Int, y: Int) {
        let strArray = str.components(separatedBy: " ")
        guard strArray.count == 2,
              let xInt = Int(strArray[0]),
              let yInt = Int(strArray[1]) else {
            print("error in intCoordinateFromStringKey"); return (0,0)}
        return (x: xInt, y: yInt)
    }
    
}
