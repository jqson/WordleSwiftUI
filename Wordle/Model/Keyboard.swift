//
//  Keyboard.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 12/5/24.
//

import Foundation
import SwiftUI

enum KeyInput {
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
