//
//  ColorGame.swift
//  Right on target
//
//  Created by macbook on 09.08.2022.
//

import UIKit

// MARK: - Structures and Classes

class ColorGame: GameProtocol {
    var colorDict: [UIColor: Int] = [:]
    var currentHexColor: String?
    let generator: GeneratorProtocol
    var currentRound: GameRoundProtocol!
    var isGameEnded: Bool {
        currentRound.isGameEnded()
    }

    init?(rounds: Int) {
        guard let generator = Generator(minValue: 0, maxValue: 255) else { return nil }
        
        self.generator = generator
        
        generateNewColorDicionary { (intValue) in
            self.currentRound = RoundForColorGame(valueColor: intValue, rounds: rounds)
        }
    }
    
    private func generateNewColorDicionary(clouser: (Int) -> Void) {
        
        for num in 1...4 {
            let red = generator.getRandomValue()
            let green = generator.getRandomValue()
            let blue = generator.getRandomValue()
            
            let hexString = String(format: "%02X", red) + String(format: "%02X", green) + String(format: "%02X", blue)
            let intValue = Int(hexString, radix: 16) ?? 0
            let color = generator.getColor(intValue)
            self.colorDict[color] = intValue
            
            if num == 1 {
                self.currentHexColor = hexString
                clouser(intValue)
            }
        }
    }
    
    func restartGame() {
        currentRound.round = 0
        currentRound.score = 0
        startNewRound()
    }
    
    func startNewRound() {
        self.colorDict = [:]
        generateNewColorDicionary() { (intValue) in
            currentRound.currentSecretValue = intValue
        }
        currentRound.round += 1
    }
    
    
}

