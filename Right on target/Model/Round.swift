//
//  Round.swift
//  Right on target
//
//  Created by macbook on 04.08.2022.
//

import UIKit

// MARK: - Protocols

protocol GameRoundProtocol {
    var score: Int { get set }
    var currentSecretValue: Int! { get set }
    var round: Int { get set }
    var lastRound: Int { get }
    
    func calculateScore(with value: Int)
    func isGameEnded() -> Bool
}

// MARK: - Structures and Classes


/// Class for game "Right of Target"
class RoundForRightOnTarget: GameRoundProtocol {
    var score: Int = 0
    var currentSecretValue: Int!
    var round: Int = 1
    var lastRound: Int
    
    init(secretValue: Int, rounds: Int) {
        self.currentSecretValue = secretValue
        self.lastRound = rounds
    }
    
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
    }
    
    func isGameEnded() -> Bool {
        if round >= lastRound {
            return true
        } else {
            return false
        }
    }
}


/// Class for game "Color game"
class RoundForColorGame: RoundForRightOnTarget {
    
    init(valueColor: Int, rounds: Int) {
        super.init(secretValue: valueColor, rounds: rounds)
    }

    override func calculateScore(with value: Int) {
        if value == currentSecretValue {
            score += 1
        }
    }
}

