//
//  KeyboardView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/18/24.
//

import SwiftUI


struct KeyboardView: View {
    
    enum Constants {
        static let keyboardLine1: [String] = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
        static let keyboardLine2: [String] = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
        static let keyboardLine3: [String] = ["Z", "X", "C", "V", "B", "N", "M"]
        
        static let keyWidth: CGFloat = 30
        static let keyHeight: CGFloat = 40
        static let keyPadding: CGFloat = 5
    }
    
    enum KeyState {
        case correct
        case present
        case absent
        case unknown
    }
    
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        VStack(alignment: .center, spacing: Constants.keyPadding) {
            HStack(spacing: Constants.keyPadding) {
                ForEach(0..<Constants.keyboardLine1.count, id: \.self) {
                    let key = Constants.keyboardLine1[$0]
                    KeyView(
                        key: key,
                        keyState: modelData.getKeyState(letter: key)
                    )
                    .cornerRadius(5)
                    .frame(width: Constants.keyWidth, height: Constants.keyHeight)
                }
            }
            
            HStack(spacing: Constants.keyPadding) {
                ForEach(0..<Constants.keyboardLine2.count, id: \.self) {
                    let key = Constants.keyboardLine2[$0]
                    KeyView(
                        key: key,
                        keyState: modelData.getKeyState(letter: key)
                    )
                    .cornerRadius(5)
                    .frame(width: Constants.keyWidth, height: Constants.keyHeight)
                }
            }
            
            HStack(spacing: Constants.keyPadding) {
                ForEach(0..<Constants.keyboardLine3.count, id: \.self) {
                    let key = Constants.keyboardLine3[$0]
                    KeyView(
                        key: key,
                        keyState: modelData.getKeyState(letter: key)
                    )
                    .cornerRadius(3)
                    .frame(width: Constants.keyWidth, height: Constants.keyHeight)
                }
            }
            .offset(x: -Constants.keyWidth / 2)
        }
    }
    
    private func getKeyBoard(keyLine: [String]) -> String {
        var s: String = ""
        for key in keyLine {
            switch modelData.getKeyState(letter: key) {
            case .correct:
                s += "[\(key)]"
            case .present:
                s += "(\(key))"
            case .absent:
                s += "|\(key)|"
            case .unknown:
                s += " \(key) "
            }
        }
        return s
    }
}

#Preview {
    KeyboardView().environment(ModelData())
}

extension ModelData {
    
    func getKeyState(letter: String) -> KeyboardView.KeyState {
        guard letter.count == 1 else {
            return .unknown
        }
        
        let guessResults: GuessResult =
            guesses.flatMap({ $0.guessResult }).filter({ $0.0 == letter })
        
        if guessResults.contains(where: { $0.1 == .correct }) {
            return .correct
        } else if guessResults.contains(where: { $0.1 == .present }) {
            return .present
        } else if guessResults.contains(where: { $0.1 == .absent }) {
            return .absent
        }
        
        return .unknown
    }
}
