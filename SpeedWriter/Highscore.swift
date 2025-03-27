//
//  Highscore.swift
//  SpeedWriter
//
//  Created by Natalie S on 2025-03-27.
//

import Foundation

class Highscore: Codable {
    var name: String
    var score: Int
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}
