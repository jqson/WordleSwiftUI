//
//  ModelData.swift
//  Wordle
//
//  Created by Yuanfeng Jiao on 9/11/24.
//

import Foundation

@Observable
class ModelData {
    var guesses: [Word] = [.init(id: 0, text: "above"), .init(id: 1, text: "aside")]
}
