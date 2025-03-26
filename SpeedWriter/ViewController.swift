//
//  ViewController.swift
//  SpeedWriter
//
//  Created by Natalie S on 2025-03-25.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

      
        let playButton = UIButton(type: .custom)

       
        playButton.translatesAutoresizingMaskIntoConstraints = false

   
        self.view.addSubview(playButton)

      
        playButton.setImage(UIImage(named: "play"), for: .normal)


        playButton.imageView?.contentMode = .scaleAspectFit

     
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)

       
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 80),
            playButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    @objc func playButtonTapped() {
        print("Play button pressed")
       
    }
}
