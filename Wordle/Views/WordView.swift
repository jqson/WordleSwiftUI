//
//  WordView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/11/24.
//

import SwiftUI

struct WordView: View {
    var word: Word
    
    var body: some View {
        Text(word.text)
    }
}

#Preview {
    WordView(word: .init(id: 0, text: "above"))
}
