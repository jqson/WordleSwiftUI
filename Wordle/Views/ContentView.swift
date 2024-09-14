//
//  ContentView.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/14/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputString: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            WordListView().environment(ModelData())
            TextField(
                "Input",
                text: $inputString
            )
            .multilineTextAlignment(.center)
        }
        .padding()
        
        Button("Confirm", action: {})
    }
}

#Preview {
    ContentView()
}
