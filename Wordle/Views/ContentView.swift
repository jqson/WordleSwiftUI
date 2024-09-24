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
        static var maxGuess: Int = 6
    }
    
    enum GuessState {
        case valid
        case wrongLength
        case invalidWord
        case wordNotFound
        case correct
        case gameOver
        case unknown
        
        var isFinished: Bool {
            self == .correct || self == .gameOver
        }
    }
    
    @Environment(ModelData.self) var modelData
    
    @State private var targetWord: String = ""
    @State private var inputString: String = ""
    @State private var guessState: GuessState = .valid
    
    @FocusState private var isWordListViewFocused: Bool
    
    var message: String {
        switch guessState {
        case .valid:
            " "
        case .wrongLength:
            "Wong length"
        case .invalidWord:
            "Invalid input"
        case .wordNotFound:
            "Not a word"
        case .correct:
            "Congratulations!"
        case .gameOver:
            targetWord
        case .unknown:
            "Unknown error"
        }
    }
    
    var buttonText: String {
        if guessState.isFinished {
            "Next Game"
        } else {
            "Confirm"
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .center) {
                WordListView()
                    .environment(modelData)
                    .padding(.top, 60)
                    .focusable()
                    .focused($isWordListViewFocused)
                    .onAppear(perform: { isWordListViewFocused = true })
                    .onKeyPress { keyPress in
                        return handleKeyPress(keyPress: keyPress)
                    }
                
                Spacer()
                
                Text(inputString).foregroundStyle(.white)
                
                Text(message)
                    .foregroundStyle(.white)
                
                Button(action: buttonClicked) {
                    Text(buttonText)
                        .font(.system(size: 20, weight: .bold))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.letterCorrect)
                .padding([.top, .bottom], 20)
                
                KeyboardView()
                    .environment(modelData)
                    .padding(.bottom, 40)
            }
            .padding([.leading, .trailing], 40)
            .onAppear(perform: restartGame)
        }
    }
    
    private func generateWord() {
        if let word = WordManager(wordLength: Constants.wordLength).getRandomWord() {
            targetWord = word
        } else {
            assertionFailure("Failed to find target word.")
        }
    }
    
    private func handleKeyPress(keyPress: KeyPress) -> KeyPress.Result {
        guard !guessState.isFinished else { return .ignored }
        
        if keyPress.key == .return, inputString.count == Constants.wordLength {
            buttonClicked()
            return .handled
        }
        
        if keyPress.key == .delete, inputString.count > 0 {
            inputString = String(inputString.dropLast())
            return .handled
        }
        
        let char = keyPress.key.character
        if char.isLetter, inputString.count < Constants.wordLength {
            inputString += char.uppercased()
            return .handled
        }
        
        return .ignored
    }
    
    private func buttonClicked() {
        guard !guessState.isFinished else {
            restartGame()
            return
        }
        
        guessState = validInput(inputText: inputString)
        
        guard guessState == .valid else {
            return
        }
        
        let guessWord: Word = .init(targetWord: targetWord, inputText: inputString)
        
        modelData.guesses.append(guessWord)
        inputString = ""
        
        if guessWord.guessResult.isCorrect {
            guessState = .correct
        } else if modelData.guesses.count >= Constants.maxGuess {
            guessState = .gameOver
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
