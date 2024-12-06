//
//  Keyboard.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 12/5/24.
//

import Foundation
import SwiftUI

enum KeyInput {
    
    static let keyboardKeys: [[String]] = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["Z", "X", "C", "V", "B", "N", "M"]
    ]
    
    case character(String)
    case enter
    case delete
    
    static func fromKeyPress(_ keyPress: KeyPress) -> KeyInput? {
        switch keyPress.key {
        case .return:
            return .enter
        case .delete:
            return .delete
        default:
            let char = keyPress.key.character
            if char.isLetter {
                return .character(char.uppercased())
            } else {
                return nil
            }
        }
    }
}
