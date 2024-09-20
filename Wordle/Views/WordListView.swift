//
//  WordListView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/11/24.
//

import SwiftUI

struct WordListView: View {
    @Environment(ModelData.self) var modelData

    var guesses: [Word] {
        modelData.guesses
    }
    
    var body: some View {
        VStack(spacing: WordView.Constants.letterPadding) {
            ForEach(0..<ContentView.Constants.maxGuess, id: \.self) {
                if $0 < guesses.count {
                    WordView(word: guesses[$0])
                } else {
                    WordView(word: .init(wordLength: ContentView.Constants.wordLength))
                }
            }
        }
    }
}

#Preview {
    WordListView().environment(ModelData())
}
