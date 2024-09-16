//
//  Word.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/11/24.
//

import Foundation


enum LetterState {
    case correctPosition
    case correctLetter
    case noneExist
}

typealias GuessResult = [(String, LetterState)]
extension GuessResult {
    var dispText: String {
        var dispText: String = ""
        
        for (letter, state) in self {
            switch state {
            case .correctPosition:
                dispText += "[" + letter + "]"
            case .correctLetter:
                dispText += "("  + letter + ")"
            case .noneExist:
                dispText += " " + letter + " "
            }
        }
        
        return dispText
    }
    
    var isCorrect: Bool {
        return self.filter({ $0.1 != .correctPosition }).isEmpty
    }
}

struct Word: Identifiable {
    let id: Int
    let guessResult: GuessResult
    
    var text: String {
        guessResult.dispText
    }
    
    init(id: Int) {
        self.id = id
        
        guessResult = [
            ("T", .correctLetter),
            ("E", .correctPosition),
            ("S", .noneExist),
            ("T", .correctLetter),
            ("S", .noneExist),
        ]
    }
    
    init(id: Int, targetWord: String, inputText: String) {
        self.id = id
        
        let letters: Set<Character> = Set(Array(targetWord))
        
        var result: GuessResult = []
        for (idx, inputChar) in inputText.enumerated() {
            let letterResult: (Character, LetterState)
            if inputChar == targetWord[targetWord.index(targetWord.startIndex, offsetBy: idx)] {
                letterResult = (inputChar, .correctPosition)
            } else if letters.contains(inputChar) {
                letterResult = (inputChar, .correctLetter)
            } else {
                letterResult = (inputChar, .noneExist)
            }
            result.append((String(letterResult.0), letterResult.1))
        }
        
        guessResult = result
    }
}
