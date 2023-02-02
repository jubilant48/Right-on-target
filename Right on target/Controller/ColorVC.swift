//
//  ColorVC.swift
//  Right on target
//
//  Created by macbook on 09.08.2022.
//

import UIKit

final class ColorVC: UIViewController {
    // MARK: Outletes
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private var colorButtons: [UIButton]!
    
    // MARK: Properties
    
    private var game: ColorGame!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = ColorGame(rounds: 5)
        updateUI()
    }
    
    // MARK: View and Model interaction
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        guard let value = game.colorDict[color] else { return }
        game.currentRound.calculateScore(with: value)
        
        if game.isGameEnded {
            showAlertWith(score: game.currentRound.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        
        updateUI()
    }
    
    // MARK: Refresh View
    
    private func updateButtons() {
        let colorKey: Dictionary<UIColor, Int>.Keys? = game.colorDict.keys
        let buttonAndColor = zip(colorButtons, colorKey!)
        for (button, color) in buttonAndColor {
            button.backgroundColor = color
        }
    }
    
    private func updateUI() {
        label.text = "Угадай цвет #" + game.currentHexColor!
        updateButtons()
    }
    
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Игра окончена", message: "Вы угадали \(score) цветов.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
