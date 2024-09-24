//
//  WordListView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/11/24.
//

import SwiftUI

struct WordListView: View {
    
    @Environment(ModelData.self) var modelData
    
    var inputString: String

    var guesses: [Word] {
        modelData.guesses
    }
    
    var body: some View {
        VStack(spacing: WordView.Constants.letterPadding) {
            ForEach(0..<ContentView.Constants.maxGuess, id: \.self) {
                if $0 < guesses.count {
                    WordView(word: guesses[$0])
                } else if $0 == guesses.count {
                    let inputWord: Word = .init(
                        wordLength: ContentView.Constants.wordLength, inputText: inputString
                    )
                    WordView(word: inputWord)
                } else {
                    WordView(word: .init(wordLength: ContentView.Constants.wordLength))
                }
            }
        }
    }
}

#Preview {
    WordListView(inputString: "TEST").environment(ModelData())
}
