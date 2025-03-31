//
//  GameViewController.swift
//  SpeedWriter
//
//  Created by Isaac Strandh on 2025-03-27.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var translationWord: UITextView!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var wordArray : [String] = ["Hello", "Dog", "World", "Cooking", "Clear", "Open", "Track", "Swift", "Apple", "Banana"]
    var correctWordarray : [String] = ["Hej", "Hund", "Världen", "Matlagning", "Rensa", "Öppna", "Spår", "Snabb", "Äpple", "Banan"]
    
    
    var randomInt = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomInt = Int.random(in: 0..<wordArray.count)
        
        scoreLabel.text = "\(score)"
        
        translationWord.text = wordArray[randomInt]
        
        if(userInput.text == correctWordarray[randomInt]){
            score+=1
            scoreLabel.text = "\(score)"
            randomInt = Int.random(in: 0..<wordArray.count)
            translationWord.text = wordArray[randomInt]
            //timer reset
        }else {
            //gameover
        }
        
    }

    
    
        
}
