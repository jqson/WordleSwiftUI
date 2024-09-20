//
//  Word.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/11/24.
//

import Foundation


enum LetterState {
    case correct
    case present
    case absent
    case pending
}

typealias GuessResult = [(String, LetterState)]
extension GuessResult {
    var isCorrect: Bool {
        return self.filter({ $0.1 != .correct }).isEmpty
    }
}

struct Word {
    let guessResult: GuessResult
    
    init() {
        guessResult = [
            ("T", .present),
            ("E", .correct),
            ("S", .absent),
            ("T", .present),
            ("S", .pending),
        ]
    }
    
    init(targetWord: String, inputText: String) {
        let unmatchedCounts: Set<Character> = Set(
            targetWord.enumerated().compactMap {
                inputText[inputText.index(inputText.startIndex, offsetBy: $0)] != $1 ? $1 : nil
            }
        )
        
        var result: GuessResult = []
        for (idx, inputChar) in inputText.enumerated() {
            let letterResult: (Character, LetterState)
            if inputChar == targetWord[targetWord.index(targetWord.startIndex, offsetBy: idx)] {
                letterResult = (inputChar, .correct)
            } else if unmatchedCounts.contains(inputChar) {
                letterResult = (inputChar, .present)
            } else {
                letterResult = (inputChar, .absent)
            }
            result.append((String(letterResult.0), letterResult.1))
        }
        
        guessResult = result
    }
    
    init(wordLength: Int, inputText: String = "") {
        var result: GuessResult = []
        for idx in 0..<wordLength {
            let letter: String
            if idx < inputText.count {
                letter = String(inputText[inputText.index(inputText.startIndex, offsetBy: idx)])
            } else {
                letter = ""
            }
            
            result.append((letter, .pending))
        }
        guessResult = result
    }
}
