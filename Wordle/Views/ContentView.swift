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
    
    enum GuessState {
        case valid
        case wrongLength
        case invalidWord
        case wordNotFound
        case correct
        case unknown
    }
    
    @Environment(ModelData.self) var modelData
    
    @State private var targetWord: String = ""
    @State private var inputString: String = ""
    @State private var guessState: GuessState = .valid
    
    var message: String {
        switch guessState {
        case .valid:
            ""
        case .wrongLength:
            "Wong length"
        case .invalidWord:
            "Invalid input"
        case .wordNotFound:
            "Not a word"
        case .correct:
            "Congratulations!"
        case .unknown:
            "Unknown error"
        }
    }
    
    var buttonText: String {
        if guessState == .correct {
            "Next Game"
        } else {
            "Confirm"
        }
    }
    
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
                    .onSubmit {
                        if guessState != .correct {
                            buttonClicked()
                        }
                    }
                
                Text(message)
                    .foregroundStyle(.white)
                    .padding(20)
                
                Button(action: buttonClicked) {
                    Text(buttonText)
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
            targetWord = "TESTS"
        } else {
            assertionFailure("Failed to find target word.")
        }
    }
    
    private func buttonClicked() {
        guard guessState != .correct else {
            restartGame()
            return
        }
        
        guessState = validInput(inputText: inputString)
        
        guard guessState == .valid else { return }
        
        let guessWord: Word = .init(
            id: modelData.guesses.count,
            targetWord: targetWord,
            inputText: inputString
        )
        modelData.guesses.append(guessWord)
        inputString = ""
        
        if guessWord.guessResult.isCorrect {
            guessState = .correct
        }
    }
    
    private func validInput(inputText: String) -> GuessState {
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
    
    private func restartGame() {
        generateWord()
        modelData.guesses = []
        guessState = .valid
    }
}

#Preview {
    ContentView().environment(ModelData())
}
