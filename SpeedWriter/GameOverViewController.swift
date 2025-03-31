//
//  GameOver.swift
//  SpeedWriter
//
//  Created by Natalie S on 2025-03-27.

import UIKit

class GameOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var finalScore = 0
    
    var allScores: [Int] {
        get { return UserDefaults.standard.array(forKey: "allScores") as? [Int] ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: "allScores") }
    }
    
    var uniqueScores: [Int] {
        return Array(Set(allScores)).sorted(by: >)
    }

    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.5, blue: 0.6, alpha: 0.9)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let gameOverLabel: UILabel = {
        let label = UILabel()
        label.text = "Game Over"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let highScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemGroupedBackground
        table.layer.cornerRadius = 12
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private let restartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play New Game", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateScores()
    }

    // MARK: - Setup
    private func setupUI() {
        view.setBackgroundColor(hex: "#EAE0E4")
        containerView.addSubview(usernameLabel)
            containerView.addSubview(gameOverLabel)
            containerView.addSubview(scoreLabel)
            containerView.addSubview(highScoreLabel)
            
            view.addSubview(containerView)
            view.addSubview(tableView)
            view.addSubview(restartButton)
            view.addSubview(backButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: "scoreCell")
        
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            containerView.heightAnchor.constraint(equalToConstant: 180),
            
            gameOverLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            gameOverLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: gameOverLabel.bottomAnchor, constant: 8),
            usernameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            scoreLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            highScoreLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 8),
            highScoreLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            highScoreLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -12),
            
            tableView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            restartButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 30),
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    private func updateScores() {
        allScores.append(finalScore)
        scoreLabel.text = "Score: \(finalScore)"
        let highScore = uniqueScores.max() ?? 0
        highScoreLabel.text = "Best Score: \(highScore)"
        
    
        if let username = UserDefaults.standard.string(forKey: "currentUsername") {
            usernameLabel.text = "Player: \(username)"
            print("Username found: \(username)")
        } else {
            usernameLabel.text = "Player: Guest"
            print("No username found")
        }
        
        tableView.reloadData()
    }

    // MARK: - Actions
    @objc private func restartGame() {
        let gameVC = GameViewController()
        gameVC.modalPresentationStyle = .fullScreen
        gameVC.modalTransitionStyle = .crossDissolve
        present(gameVC, animated: true)
    }

    @objc private func backToMain() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uniqueScores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! ScoreTableViewCell
        
        let score = uniqueScores[indexPath.row]
        cell.configure(with: score, index: indexPath.row + 1,
                      isHighScore: score == (uniqueScores.max() ?? 0))
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// Custom TableView Cell
class ScoreTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gameNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trophyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "crown.fill")
        imageView.tintColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(gameNumberLabel)
        containerView.addSubview(scoreLabel)
        containerView.addSubview(trophyImageView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            gameNumberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            gameNumberLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            scoreLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            trophyImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            trophyImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            trophyImageView.widthAnchor.constraint(equalToConstant: 24),
            trophyImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with score: Int, index: Int, isHighScore: Bool) {
        gameNumberLabel.text = "Game \(index)"
        scoreLabel.text = "\(score) Points"
        trophyImageView.isHidden = !isHighScore
        
        if isHighScore {
            containerView.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.2)
            scoreLabel.textColor = .systemYellow
        } else {
            containerView.backgroundColor = .secondarySystemBackground
            scoreLabel.textColor = .label
        }
    }
}
