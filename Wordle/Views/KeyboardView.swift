//
//  KeyboardView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/18/24.
//

import SwiftUI


struct KeyboardView: View {
    
    enum KeyState {
        case correct
        case present
        case absent
        case unknown
    }
    
    struct KeyboardKey: Hashable {
        
        enum Constants {
            static let charKeyFontSize: CGFloat = 18
            static let funcKeyFontSize: CGFloat = 14
            static let keyWidth: CGFloat = 32
            static let keyHeight: CGFloat = 45
            static let keyPadding: CGFloat = 5
        }
        
        let text: String
        let fontSize: CGFloat
        let width: CGFloat
        let height: CGFloat
        
        init(keyText: String) {
            text = keyText
            
            let isFunctionKey: Bool = keyText.count > 1
            fontSize = isFunctionKey ? KeyboardKey.Constants.funcKeyFontSize : KeyboardKey.Constants.charKeyFontSize
            width = Constants.keyWidth +
                (isFunctionKey ? (Constants.keyWidth + Constants.keyPadding) / 2 : 0)
            height = Constants.keyHeight
        }
    }
    
    @Environment(ModelData.self) var modelData
    
    var keyPressed: (KeyInput) -> Void
    
    var keyboardKeys: [[KeyboardKey]] {
        KeyInput.keyboardKeys.map { keyLine in
            keyLine.map { keyText in .init(keyText: keyText) }
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: KeyboardKey.Constants.keyPadding) {
            ForEach(keyboardKeys, id: \.self) { keyboardLine in
                HStack(spacing: KeyboardKey.Constants.keyPadding) {
                    ForEach(keyboardLine, id: \.self) { key in
                        KeyView(
                            key: key.text,
                            fontSize: key.fontSize,
                            keyState: modelData.getKeyState(letter: key.text),
                            keyPressed: keyPressed
                        )
                        .cornerRadius(5)
                        .frame(width: key.width, height: key.height)
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
