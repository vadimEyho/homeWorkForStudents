//
//  ViewController.swift
//  homeworkWithoutStoryboard
//
//  Created by Lizaveta on 26.08.2026.
//

import UIKit

class ViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Моё приложение"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Практическое задание по Swift Playground"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let catalogButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Каталог товаров", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Корзина", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        setupNavigationBar()

    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
            
        // Добавляем все элементы на экран
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(catalogButton)
        view.addSubview(cartButton)
        // Настраиваем Auto Layout
        NSLayoutConstraint.activate([
            // тайтл
            // верх прикрепляем к safearea
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Description Label
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12), // ПОД тайтлом
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            catalogButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            catalogButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),   // ПОД описанием
            catalogButton.widthAnchor.constraint(equalToConstant: 200),
            catalogButton.heightAnchor.constraint(equalToConstant: 60),
            
            cartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cartButton.topAnchor.constraint(equalTo: catalogButton.bottomAnchor, constant: 40), // ПОД кнопкой каталог
            cartButton.widthAnchor.constraint(equalToConstant: 200),
            cartButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setupActions() {
        //  сигнал слот
        catalogButton.addTarget(self, action: #selector(catalogButtonTapped), for: .touchUpInside)
        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        catalogButton.addTarget(self, action: #selector(catalogButtonTapped), for: .touchUpInside)
        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
    }
    
    @objc private func catalogButtonTapped() {
    }
    
    @objc private func cartButtonTapped() {
    }
}

