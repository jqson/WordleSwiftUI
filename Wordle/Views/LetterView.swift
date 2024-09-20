//
//  LetterView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/17/24.
//

import SwiftUI


struct LetterView: View {
    
    var letter: String
    var letterState: LetterState
    
    var backgroundColor: Color {
        switch letterState {
        case .correct:
            return .letterCorrect
        case .present:
            return .letterPresent
        case .absent:
            return .letterAbsent
        case .pending:
            return .clear
        }
    }
    
    var borderColor: Color {
        if letterState == .pending {
            return .letterAbsent
        } else {
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
        .border(borderColor, width: 2)
    }
}

#Preview {
    LetterView(letter: "A", letterState: .correct)
}
