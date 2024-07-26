//
//  ViewController.swift
//  Tic tac toe - Storyboard
//
//  Created by Ruslan Yelguldinov on 06.07.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonsInArray()
        
        turnLabel.text = CROSS
    }
    
    enum Turn {
        case Cross
        case Nought
    }

    var currentTurn = Turn.Cross
    
    var btnArray: [UIButton] = []
    
    var CROSS = "X"
    var NOUGHT = "O"
    
    @IBOutlet weak var turnLabel: UILabel!
    
    func addButtonsInArray() {
        for i in 1...9 {
            if let button = self.view.viewWithTag(i) as? UIButton {
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                btnArray.append(button)
                
                // Проверяем настройки кнопки
                print("Button tag: \(button.tag)")
                print("Button title: \(button.title(for: .normal) ?? "No title")")
                print("Button font: \(String(describing: button.titleLabel?.font))")
            }
            
        }
    }
    
    @objc func btnTapped(sender: UIButton) {
        print("Btn \(sender.tag) tapped")
        
        if sender.title(for: .normal) == nil {
            if currentTurn == Turn.Cross {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            } else {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            if checkForWinner() == true {
                let winner = currentTurn == Turn.Cross ? NOUGHT : CROSS
                displayResult(result: "\(winner) wins!")
            } else if checkForDraw() {
                displayResult(result: "It's a draw!")
            }
            return
        }
        
    }
    func checkForWinner() -> Bool {
        // Проверяем горизонтальные линии
        if checkLine(a: 0, b: 1, c: 2) { return true }
        if checkLine(a: 3, b: 4, c: 5) { return true }
        if checkLine(a: 6, b: 7, c: 8) { return true }
        // Проверяем вертикальные линии
        if checkLine(a: 0, b: 3, c: 6) { return true }
        if checkLine(a: 1, b: 4, c: 7) { return true }
        if checkLine(a: 2, b: 5, c: 8) { return true }
        // Проверяем диагональные линии
        if checkLine(a: 0, b: 4, c: 8) { return true }
        if checkLine(a: 2, b: 4, c: 6) { return true }
        // Если выигрышных комбинаций нет, возвращаем false
        return false
    }

    func checkLine(a: Int, b: Int, c: Int) -> Bool {
        if let titleA = btnArray[a].title(for: .normal),
           let titleB = btnArray[b].title(for: .normal),
           let titleC = btnArray[c].title(for: .normal),
           titleA == titleB, titleB == titleC {
            return true
        }
        return false
    }
    
    func checkForDraw() -> Bool {
           // Проверяем, что все кнопки заполнены
           for button in btnArray {
               if button.title(for: .normal) == nil {
                   return false
               }
           }
           return true
       }
    
    func displayResult(result: String) {
           let alertController = UIAlertController(title: result, message: nil, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alertController, animated: true, completion: nil)
           resetGame()
       }

    func resetGame() {
        for button in btnArray {
            button.setTitle(nil, for: .normal)
        }
        currentTurn = Turn.Cross
        turnLabel.text = CROSS
    }
    
}


