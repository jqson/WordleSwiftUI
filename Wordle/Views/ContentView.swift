//
//  ContentView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/14/24.
//

import SwiftUI

struct ContentView: View {
    
    enum Constants {
        static var wordLenght: Int = 5
    }
    
    @Environment(ModelData.self) var modelData
    
    @State private var inputString: String = ""
    @State private var targetWord: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                WordListView().environment(modelData)
                TextField(
                    "Input",
                    text: $inputString
                )
                .multilineTextAlignment(.center)
                
                Button(
                    "Confirm",
                    action: {
                        modelData.guesses.append(.init(id: modelData.guesses.count, text: targetWord))
                        inputString = ""
                    }
                )
            }
            .padding()
        }.onAppear(perform: generateWord)
    }
    
    private func generateWord() {
        if let word = WordManager(wordLength: Constants.wordLenght).getRandomWord() {
            targetWord = word
        } else {
            assertionFailure("Failed to find target word.")
        }
    }
}

#Preview {
    ContentView().environment(ModelData())
}
