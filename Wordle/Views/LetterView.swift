//
//  LetterView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/17/24.
//

import SwiftUI


struct LetterView: View {
    var letter: String = ""
    var letterState: LetterState = .notFilled
    
    var backgroundColor: Color {
        switch letterState {
        case .correct:
            return .letterCorrect
        case .present:
            return .letterPresent
        case .absent:
            return .letterAbsent
        case .notFilled:
            return .clear
        }
    }
    
    var body: some View {
        ZStack {
            backgroundColor
            Text(letter)
                .font(.system(size: 22, weight: .heavy))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    LetterView(letter: "A")
}
