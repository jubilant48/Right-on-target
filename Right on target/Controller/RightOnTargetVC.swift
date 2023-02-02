//
//  ViewController.swift
//  Right on target
//
//  Created by macbook on 29.07.2022.
//

import UIKit

final class RightOnTargetVC: UIViewController {
     // MARK: Outletes
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    
    // MARK: Properties
    
    private var game: RightOnTarget!
    
    // MARK: Life cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create instance of Game
        game = RightOnTarget(startValue: 1, endValue: 50, rounds: 5)
        
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }
    
    // MARK: View and Model interaction

    // Checking the number selected by the user
    @IBAction private func checkNumber() {
        game.currentRound.calculateScore(with: Int(slider.value))
        
        if game.isGameEnded {
            showAlertWith(score: game.currentRound.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }
    
    // MARK: Refresh View
    
    private func updateLabelWithSecretNumber(newText: String) {
        label.text = newText
    }
    
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Игра окончена", message: "Вы заработали \(score) очков.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

