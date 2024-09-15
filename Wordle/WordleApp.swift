//
//  WordleApp.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/8/24.
//

import SwiftUI

@main
struct WordleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environment(ModelData())
        }
    }
}
