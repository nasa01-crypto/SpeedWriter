import UIKit

class ViewController: UIViewController {

    let playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "play"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your username"
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        return tf
    }()
    
    let difficultySegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Easy", "Medium", "Hard"])
        control.selectedSegmentIndex = 1
        control.backgroundColor = UIColor(hex: "#ECECEC")
        control.selectedSegmentTintColor = UIColor.darkGray
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        return control
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "English-Swedish Translation"
        
        if let font = UIFont(name: "GillSans-Bold", size: 24) {
            label.font = font
        } else {
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        }
        label.textAlignment = .center
        return label
    }()

    let speedTranslatorLabel: UILabel = {
        let label = UILabel()
        label.text = "SpeedTranslator"
        if let font = UIFont(name: "GillSans-Bold", size: 24) {
            label.font = font
        } else {
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        }
        label.textAlignment = .center
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(hex: "#eae0e4")
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(usernameTextField)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        difficultySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        

        view.addSubview(playButton)
        view.addSubview(difficultySegmentedControl)
        view.addSubview(titleLabel)
      
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            usernameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            difficultySegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            difficultySegmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            difficultySegmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: difficultySegmentedControl.bottomAnchor, constant: 40),
            playButton.widthAnchor.constraint(equalToConstant: 80),
            playButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        difficultySegmentedControl.layer.cornerRadius = 10
        difficultySegmentedControl.layer.masksToBounds = true
    }
    
    @objc func playButtonTapped() {
        guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespaces), !username.isEmpty else {
            showAlert(message: "Please enter a username")
            return
        }
        
        UserDefaults.standard.set(username, forKey: "currentUsername")
        UserDefaults.standard.synchronize()
        let gameVC = GameViewController()
        gameVC.difficultyLevel = difficultySegmentedControl.selectedSegmentIndex
        gameVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .fade
        view.window?.layer.add(transition, forKey: kCATransition)
        
        present(gameVC, animated: false)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
