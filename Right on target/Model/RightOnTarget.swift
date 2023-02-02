//
//  Game.swift
//  Right on target
//
//  Created by macbook on 04.08.2022.
//

import UIKit

// MARK: - Protocols

protocol GameProtocol {
    var generator: GeneratorProtocol { get }
    var isGameEnded: Bool { get }
    var currentRound: GameRoundProtocol! { get set }
    
    func restartGame()
    func startNewRound()
}

// MARK:  - Structures and Classes

final class RightOnTarget: GameProtocol {
    let generator: GeneratorProtocol
    var currentRound: GameRoundProtocol!
    var isGameEnded: Bool {
        currentRound.isGameEnded() 
    }
    
    init?(startValue: Int, endValue: Int, rounds: Int) {
        guard let generator = Generator(minValue: startValue, maxValue: endValue) else { return nil }
        
        self.generator = generator
        currentRound = RoundForRightOnTarget(secretValue: self.generator.getRandomValue(), rounds: rounds)
    }
    
    func restartGame() {
        currentRound.round = 0
        currentRound.score = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentRound.currentSecretValue = self.generator.getRandomValue()
        currentRound.round += 1
    }
    
}

