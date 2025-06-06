//
//  WordPool.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/11/24.
//

import Foundation
import UIKit

class WordManager {
    
    enum Constants {
        static let fileName: String = "english-words"
        static let fileType: String = "txt"
    }
    
    private var wordList: [String] = []

    init(wordLength: Int) {
        if let fileURL = Bundle.main.url(forResource: Constants.fileName, withExtension: Constants.fileType) {
            do {
                let fileString = try String(contentsOf: fileURL)
                let allWords: [String] = fileString.components(separatedBy: "\n")
                wordList = allWords.filter({ $0.count == wordLength && WordManager.validWord(word: $0) }).map { $0.uppercased() }
            } catch {
                print("Load file error.")
            }
        }
        
        guard !wordList.isEmpty else {
            print("No word found.")
            return
        }
    }
    
    func getRandomWord() -> String? {
        return wordList.randomElement()
    }
    
    static func validWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word.lowercased(), range: range, startingAt: 0, wrap: false, language: "en"
        )

        return misspelledRange.location == NSNotFound
    }
}

