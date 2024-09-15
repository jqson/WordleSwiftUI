//
//  ContentView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/14/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(ModelData.self) var modelData
    
    @State private var inputString: String = ""
    
    var body: some View {

        VStack(alignment: .center) {
            WordListView().environment(modelData)
            TextField(
                "Input",
                text: $inputString
            )
            .multilineTextAlignment(.center)
        }
        .padding()
        
        Button(
            "Confirm",
            action: {
                modelData.guesses.append(.init(id: modelData.guesses.count, text: inputString))
                inputString = ""
            }
        )
    }
}

#Preview {
    ContentView().environment(ModelData())
}
