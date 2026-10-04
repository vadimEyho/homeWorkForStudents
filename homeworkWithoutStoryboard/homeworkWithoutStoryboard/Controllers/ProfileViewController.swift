//
//  ViewController.swift
//  homeworkWithoutStoryboard
//
//  Created by Lizaveta on 26.08.2026.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
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
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            make.leading.equalToSuperview().offset(20)   // прижат к левому краю
        }

        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)   // прижат к левому краю
        }

        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)   // прижат к левому краю
        }
    }
    
    private func updateUI() {
        nameLabel.text = currentUser?.name ?? "Гость"
        ageLabel.text = "Возраст: \(currentUser?.age ?? 0)"
        balanceLabel.text = "Баланс: \(Int(currentUser?.balance ?? 0)) ₽"
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
