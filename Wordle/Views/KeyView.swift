//
//  KeyView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/18/24.
//

import SwiftUI

struct KeyView: View {
    
    var key: String
    var keyState: KeyboardView.KeyState
    var keyPressed: (KeyInput) -> Void
    
    var backgroundColor: Color {
        switch keyState {
        case .correct:
            return .letterCorrect
        case .present:
            return .letterPresent
        case .absent:
            return .letterAbsent
        case .unknown:
            return .letterUnknown
        }
    }
    
    var body: some View {
        ZStack {
            backgroundColor
            Text(key)
                .font(.system(size: 18, weight: .heavy))
                .foregroundStyle(.white)
                .onTapGesture {
                    keyPressed(KeyInput.fromKey(key))
                }
        }
    }
}

#Preview {
    KeyView(key: "A", keyState: .unknown, keyPressed: {_ in })
}
