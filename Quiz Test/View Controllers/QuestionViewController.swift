//
//  QuestionViewController.swift
//  Quiz Test
//
//  Created by Максим Иванов on 27.01.2021.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multiLabels: [UILabel]!
    @IBOutlet var multiSwitches: [UISwitch]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet weak var questionProgressView: UIProgressView!

    
    private var answerChosen = [Answer]() 
    
    private var currentAnswers: [Answer] {
        currentQuestion.answers
    }
    
    private var currentQuestion: Question {
        Question.all[questionIndex]
    }
    
    var questionIndex = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        rangedSlider.maximumValue = 0.99999
        updateUI()
        
    }
    
    func updateUI() {
        
        func updateSingleStack() {
            
            for (index, button) in singleButtons.enumerated() {
                button.setTitle(nil, for: [])
                button.isHidden = true
                button.tag = index
            }
            
            for (button, answer) in zip(singleButtons, currentAnswers) {
                button.setTitle(answer.text, for: [])
                button.isHidden = false
            }
            
            singleStackView.isHidden = false
        }
        
        func updateMultipleStack() {
            
            for label in multiLabels {
                label.text = nil
                label.isHidden = true
                
            }
            
            
            for (label, answer) in zip(multiLabels, currentAnswers) {
                
                label.text = answer.text
                label.isHidden = false
            }
            
            multipleStackView.isHidden = false
        }

        func updateRangeStack() {
            rangedLabels.first?.text = nil
            rangedLabels.last?.text = nil
            
            rangedLabels.first?.text = currentAnswers.first?.text
            rangedLabels.last?.text = currentAnswers.last?.text
            
            rangedStackView.isHidden = false
        }
        
        
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        let totalProgress = Float(questionIndex) / Float(Question.all.count)
        
        navigationItem.title = "Вопрос №\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack()
        case .multiple:
            updateMultipleStack()
        case .range:
            updateRangeStack()
            
        }
        
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < Question.all.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results Segue", sender: nil)
        }
        
    }
    
    
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        
        let index = sender.tag
        
        guard index >= 0 && index < currentAnswers.count else {
            return
        }
        
        let answer = currentAnswers[index]
        answerChosen.append(answer)
        
        nextQuestion()
        
    }
    
    @IBAction func multiButtonPressed() {
        
        for (index, multiSwitch) in multiSwitches.enumerated() {
            
            if multiSwitch.isOn && index < currentAnswers.count {
                let answer = currentAnswers[index]
                answerChosen.append(answer)
            }
             
        }
        
        nextQuestion()
        
    }
    
    @IBAction func rangedButtonPressed() {
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        guard index >= 0 && index < currentAnswers.count else {
            return
        }
        
        let answer = currentAnswers[index]
        answerChosen.append(answer)
        
        nextQuestion()
 
    }
    

    @IBSegueAction func resultsGegue(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, answerChosen)
    }
}
