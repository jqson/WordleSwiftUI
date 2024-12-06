//
//  KeyboardView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/18/24.
//

import SwiftUI


struct KeyboardView: View {
    
    enum Constants {
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
    
    var keyPressed: (KeyInput) -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: Constants.keyPadding) {
            ForEach(KeyInput.keyboardKeys, id: \.self) { keyboardLine in
                HStack(spacing: Constants.keyPadding) {
                    ForEach(0..<keyboardLine.count, id: \.self) {
                        let key = keyboardLine[$0]
                        KeyView(
                            key: key,
                            keyState: modelData.getKeyState(letter: key),
                            keyPressed: keyPressed
                        )
                        .cornerRadius(5)
                        .frame(width: Constants.keyWidth, height: Constants.keyHeight)
                    }
                }
            }
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
    KeyboardView(keyPressed: {_ in }).environment(ModelData())
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
