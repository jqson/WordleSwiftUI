//
//  WordView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/11/24.
//

import SwiftUI

struct WordView: View {
    
    enum Constants {
        static var letterSize: CGFloat = 50
        static var letterPadding: CGFloat = 5
    }
    
    var word: Word
    
    var body: some View {
        HStack(spacing: Constants.letterPadding) {
            ForEach(0..<word.guessResult.count, id: \.self) {
                LetterView(
                    letter: word.guessResult[$0].0,
                    letterState: word.guessResult[$0].1
                )
                .frame(width: Constants.letterSize, height: Constants.letterSize)
            }
        }
    }
}

#Preview {
    WordView(word: .init())
}
