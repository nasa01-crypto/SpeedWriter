//
//  GameModeViewController.swift
//  SpeedWriter
//
//  Created by Beles on 2025-03-30.
//

import UIKit

class GameModeViewController: UIViewController {
    
    var selectedDifficulty: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func EasyButton(_ sender: UIButton) {
        selectedDifficulty = 0
        performSegue(withIdentifier: "toGameVC", sender: self)
    }
    
    
    @IBAction func MediumButton(_ sender: UIButton) {
        selectedDifficulty = 1
        performSegue(withIdentifier: "toGameVC", sender: self)
    }
    
    
    @IBAction func HardButton(_ sender: UIButton) {
        selectedDifficulty = 2
        performSegue(withIdentifier: "toGameVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameVC",
           let destinationVC = segue.destination as? GameViewController{
            destinationVC.difficultyLevel = selectedDifficulty
        }
    }
    
}
