//
//  TrainViewController.swift
//  MathematicalTraining
//
//  Created by Vitaly on 25.10.2023.
//

import UIKit

final class TrainViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    //MARK: - Properties
    var type:MathTypes = .add {
        didSet{
            switch type{
            case .add:
                sing = "+"
            case .subtract:
                sing = "-"
            case .multiply:
                sing = "*"
            case .divide:
                sing = "/"
            }
        }
    }
    
    private var firstNumber = 0
    private var secondNumber = 0
    private var sing:String = ""
    private var count:Int = 0{
        didSet{
            print("Count: \(count)")
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        //super.viewDidLoad()
        configureQuestion()
        configureTrainButton()
        configureButtonBack()
    }
    
    //MARK: - IBActions
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    //MARK: - Methods
    private func configureTrainButton() {
        let buttonsArray = [leftButton, rightButton]
        
        buttonsArray.forEach { button in
            button?.backgroundColor = .systemYellow
        }
        buttonsArray.forEach { button in
            button?.layer.shadowColor = UIColor.darkGray.cgColor
            button?.layer.shadowOffset = CGSize(width: 0, height: 2)
            button?.layer.shadowOpacity = 0.4
            button?.layer.shadowRadius = 3
        }
        let isRightButton = Bool.random()
        var randomAnswer:Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        }while randomAnswer == answer
        
        rightButton.setTitle(isRightButton ? String(answer) : String(randomAnswer), for: .normal)
        leftButton.setTitle(isRightButton ? String(randomAnswer) : String(answer), for: .normal)
    }
    
    private func configureQuestion() {
        firstNumber = Int.random(in: 1...99)
        secondNumber = Int.random(in: 1...99)
        
        let question: String = "\(firstNumber) \(sing) \(secondNumber) ="
        questionLabel.text = question
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .green : .red
        
        if isRightAnswer{
            let isSecondAttempt = rightButton.backgroundColor == .red || leftButton.backgroundColor == .red
            count += isSecondAttempt ? 0 : 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configureTrainButton()
            }
        }
    }
    
    private func configureButtonBack() {
        buttonBack.layer.cornerRadius = 8
    }
}
