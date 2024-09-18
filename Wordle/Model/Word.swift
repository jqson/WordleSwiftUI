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
    case notFilled
}

typealias GuessResult = [(String, LetterState)]
extension GuessResult {
    var isCorrect: Bool {
        return self.filter({ $0.1 != .correct }).isEmpty
    }
}

struct Word: Identifiable {
    let id: Int
    let guessResult: GuessResult
    
    init(id: Int) {
        self.id = id
        
        guessResult = [
            ("T", .present),
            ("E", .correct),
            ("S", .absent),
            ("T", .present),
            ("S", .absent),
        ]
    }
    
    init(id: Int, targetWord: String, inputText: String) {
        self.id = id
        
        let letters: Set<Character> = Set(Array(targetWord))
        
        var result: GuessResult = []
        for (idx, inputChar) in inputText.enumerated() {
            let letterResult: (Character, LetterState)
            if inputChar == targetWord[targetWord.index(targetWord.startIndex, offsetBy: idx)] {
                letterResult = (inputChar, .correct)
            } else if letters.contains(inputChar) {
                letterResult = (inputChar, .present)
            } else {
                letterResult = (inputChar, .absent)
            }
            result.append((String(letterResult.0), letterResult.1))
        }
        
        guessResult = result
    }
}
