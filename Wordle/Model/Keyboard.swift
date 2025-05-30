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
        [keyboardEnter, "Z", "X", "C", "V", "B", "N", "M", keyboardDelete]
    ]
    
    static let keyboardEnter: String = "Enter"
    static let keyboardDelete: String = "Del"
    
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
    
    static func fromKey(_ key: String) -> KeyInput {
        switch key {
        case keyboardEnter:
            return .enter
        case keyboardDelete:
            return .delete
        default:
            return .character(key)
        }
    }
}
