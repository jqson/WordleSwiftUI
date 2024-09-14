//
//  WordListView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/11/24.
//

import SwiftUI

struct WordListView: View {
    @Environment(ModelData.self) var modelData

    var gusses: [Word] {
        modelData.guesses
    }
    
    var body: some View {
        VStack {
            ForEach(gusses) { guess in
                WordView(word: guess)
            }
        }
    }
}

#Preview {
    WordListView().environment(ModelData())
}
