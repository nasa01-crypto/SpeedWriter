//
//  GameViewController.swift
//  SpeedWriter
//
//  Created by Beles on 2025-03-26.
//

import UIKit

class GameViewController: UIViewController {
    
    var score = 0
    var timer: Timer?
    var timeLeft = 0
    var currentWordIndex = 0
    var difficultyLevel = 1 // 0: Lätt, 1: Medel, 2: Svår
    
    // English to Swedish word pairs
    let wordPairs = [
        ("Hello", "Hej"),
        ("Goodbye", "Adjö"),
        ("Apple", "Äpple"),
        ("Computer", "Dator"),
        ("House", "Hus"),
        ("Dog", "Hund"),
        ("Cat", "Katt"),
        ("Book", "Bok"),
        ("Water", "Vatten"),
        ("Food", "Mat")
    ]
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Write the Swedish translation"
        tf.autocorrectionType = .no
        return tf
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    let difficultyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupDifficulty()
        startGame()
    }
    
    private func setupUI() {
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(wordLabel)
        view.addSubview(textField)
        view.addSubview(timerLabel)
        view.addSubview(scoreLabel)
        view.addSubview(difficultyLabel)
        
        NSLayoutConstraint.activate([
            difficultyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            difficultyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: 10),
            
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 40),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 20),
            textField.widthAnchor.constraint(equalToConstant: 250),
            
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20)
        ])
        
        textField.addTarget(self, action: #selector(checkWord), for: .editingDidEndOnExit)
    }
    
    private func setupDifficulty() {
        switch difficultyLevel {
        case 0: // Lätt
            timeLeft = 20
            difficultyLabel.text = "Difficulty: Easy"
        case 1: // Medel
            timeLeft = 10
            difficultyLabel.text = "Difficulty: Medium"
        case 2: // Svår
            timeLeft = 5
            difficultyLabel.text = "Difficulty: Hard"
        default:
            timeLeft = 7
            difficultyLabel.text = "ifficulty: Medium"
        }
    }
    
    func startGame() {
        currentWordIndex = 0
        score = 0
        scoreLabel.text = "Point: \(score)"
        showNextWord()
    }
    
    func showNextWord() {
        if currentWordIndex < wordPairs.count {
            wordLabel.text = wordPairs[currentWordIndex].0
            textField.text = ""
            textField.becomeFirstResponder()
            startTimer()
        } else {
            endGame()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timeLeft = difficultyLevel == 0 ? 20 : (difficultyLevel == 1 ? 10 : 5)
        updateTimerLabel()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            self.timeLeft -= 1
            self.updateTimerLabel()
            
            if self.timeLeft <= 0 {
                timer.invalidate()
                self.handleTimeUp()
            }
        }
    }
    
    func updateTimerLabel() {
        timerLabel.text = "Time left: \(timeLeft)s"
        timerLabel.textColor = timeLeft <= 3 ? .red : .black
    }
    
    @objc func checkWord() {
        timer?.invalidate()
        
        let (englishWord, correctSwedishWord) = wordPairs[currentWordIndex]
        let userAnswer = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        
        let normalizedUserAnswer = userAnswer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedCorrectAnswer = correctSwedishWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if normalizedUserAnswer == normalizedCorrectAnswer {
            score += difficultyLevel == 0 ? 5 : (difficultyLevel == 1 ? 10 : 15)
            scoreLabel.text = "Point: \(score)"
        } else {
            score = max(0, score - 5)
            scoreLabel.text = "Point: \(score)"
            
            let alert = UIAlertController(
                title: "Wrong answer",
                message: "Correct answer was: \(correctSwedishWord)",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.nextWord()
            })
            present(alert, animated: true)
            return
        }
        
        nextWord()
    }
    
    func nextWord() {
        currentWordIndex += 1
        showNextWord()
    }
    
    func handleTimeUp() {
        score = max(0, score - 3)
        scoreLabel.text = "Point: \(score)"
        
        let alert = UIAlertController(
            title: "Time is up!",
            message: "You didn't have time to respond",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Next word", style: .default) { _ in
            self.nextWord()
        })
        present(alert, animated: true)
    }
    
    func endGame() {
        timer?.invalidate()
        
        let gameOverVC = GameOverViewController()
        gameOverVC.finalScore = score
        gameOverVC.modalPresentationStyle = .fullScreen
        present(gameOverVC, animated: true)
    }
}
