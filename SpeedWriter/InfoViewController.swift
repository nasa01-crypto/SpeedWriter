//
//  InfoViewConroller.swift
//  SpeedWriter
//
//  Created by Natalie S on 2025-03-27.
//

import UIKit

class InfoViewController: UIViewController {

   
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    @IBOutlet weak var QuitLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#EAE0E4")
        setupUI()
    }

    private func setupUI() {
        TitleLabel.text = "Om Spelet"
        TitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        TitleLabel.textAlignment = .center
        TitleLabel.textColor = .black

        DescriptionLabel.text = "SpeedTranslator är ett snabbt och roligt spel där du får ett engelskt ord och har 5 sekunder på dig att skriva in den korrekta svenska översättningen. Ju snabbare och mer korrekt du är, desto fler poäng får du!"
        DescriptionLabel.font = UIFont.systemFont(ofSize: 18)
        DescriptionLabel.textAlignment = .center
        DescriptionLabel.textColor = .black
        DescriptionLabel.numberOfLines = 0
        
        QuitLabel.setTitle("Stäng", for: .normal)
        QuitLabel.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }

    @IBAction func closeView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
