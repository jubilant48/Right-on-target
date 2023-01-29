//
//  ColorVC.swift
//  Right on target
//
//  Created by macbook on 09.08.2022.
//

import UIKit

class ColorVC: UIViewController {
    // Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet var colorButtons: [UIButton]!
    
    // Logic propetie
    var game: ColorGame!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = ColorGame(rounds: 5)
        updateUI()
    }
    
    // MARK: - View and Model interaction
    
    @IBAction func buttonTapped(_ sender: UIButton) {
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
    
    // MARK: - refresh View
    
    private func updateButtons() {
        let colorKey: Dictionary<UIColor, Int>.Keys? = game.colorDict.keys
        let buttonAndColor = zip(colorButtons, colorKey!)
        for (button, color) in buttonAndColor {
            button.backgroundColor = color
        }
    }
    
    func updateUI() {
        label.text = "Угадай цвет #" + game.currentHexColor!
        updateButtons()
    }
    
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Игра окончена", message: "Вы угадали \(score) цветов.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
