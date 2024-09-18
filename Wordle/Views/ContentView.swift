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
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .center) {
                WordListView().environment(modelData)
                
                Spacer()
                
                TextField("", text: $inputString, prompt: Text("INPUT").foregroundStyle(.gray))
                    .multilineTextAlignment(.center)
                    .autocapitalization(.allCharacters)
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                    .tint(.white)
                
                Text(getMessage())
                    .foregroundStyle(.white)
                    .padding(20)
                
                Button(action: buttonClicked) {
                    Text("Confirm")
                        .font(.system(size: 20, weight: .bold))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.letterCorrect)
            }
            .padding([.top, .bottom], 150)
            .padding([.leading, .trailing], 40)
            .onAppear(perform: generateWord)
        }
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
    
    private func getMessage() -> String {
        let message: String
        switch inputState {
        case .wrongLength:
            message = "Wong length"
        case .invalidWord:
            message = "Invalid input"
        case .wordNotFound:
            message = "Not a word"
        case .unknown:
            message = "Unknown error"
        case .valid:
            message = ""
        }
        
        return message
    }
}

#Preview {
    ContentView().environment(ModelData())
}
