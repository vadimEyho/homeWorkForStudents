//
//  ViewController.swift
//  homeworkWithoutStoryboard
//
//  Created by Lizaveta on 26.08.2026.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var currentUser: User?

    private let nameLabel: UILabel = {
        let label = UILabel()
        // label.text настрою отдельно
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = User(name: "Александр", age: 25, balance: 200000.0, cart: cart)
        updateUI()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
            
        // Добавляем все элементы на экран
        view.addSubview(nameLabel)
        view.addSubview(ageLabel)
        view.addSubview(balanceLabel)

        // Настраиваем Auto Layout
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  // прижат к левому краю
            
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            ageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  // прижат к левому краю
            
            balanceLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10),
            balanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  // прижат к левому краю
            

        ])
    }
    
    private func updateUI() {
        nameLabel.text = currentUser?.name ?? "Гость"
        ageLabel.text = "Возраст : \(currentUser?.age, default: "Возраст не указан")"
        balanceLabel.text = "Баланс \(currentUser?.balance, default: "0") ₽"
    }
    
    //  фабрика лейблов
    static func createPrimaryLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    
}
