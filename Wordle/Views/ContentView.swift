//
//  ContentView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/14/24.
//

import SwiftUI

struct ContentView: View {
    
    enum Constants {
        static var wordLength: Int = 5
    }
    
    enum InputState {
        case valid
        case wrongLength
        case invalidWord
        case wordNotFound
        case unknown
    }
    
    @Environment(ModelData.self) var modelData
    
    @State private var targetWord: String = ""
    @State private var inputString: String = ""
    @State private var inputState: InputState = .valid
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                WordListView().environment(modelData)
                TextField(
                    "INPUT",
                    text: $inputString
                )
                .multilineTextAlignment(.center)
                .autocapitalization(.allCharacters)
                
                Button("Confirm", action: buttonClicked)
            }
            .padding()
        }.onAppear(perform: generateWord)
    }
    
    private func generateWord() {
        if let word = WordManager(wordLength: Constants.wordLength).getRandomWord() {
            targetWord = word
        } else {
            assertionFailure("Failed to find target word.")
        }
    }
    
    private func buttonClicked() {
        inputState = validInput(inputText: inputString)
        
        guard inputState == .valid else { return }
        
        modelData.guesses.append(
            .init(
                id: modelData.guesses.count,
                targetWord: targetWord,
                inputText: inputString
            )
        )
        inputString = ""
    }
    
    private func validInput(inputText: String) -> InputState {
        if inputText.count != Constants.wordLength {
            return .wrongLength
        }
        
        if !CharacterSet(charactersIn: inputText).isSubset(of: CharacterSet.letters) {
            return .invalidWord
        }
        
        if !WordManager.validWord(word: inputText) {
            return .wordNotFound
        }
        
        return .valid
    }
}

#Preview {
    ContentView().environment(ModelData())
}
