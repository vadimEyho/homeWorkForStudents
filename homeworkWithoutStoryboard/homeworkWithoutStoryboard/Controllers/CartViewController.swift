//
//  ViewController.swift
//  homeworkWithoutStoryboard
//
//  Created by Lizaveta on 26.08.2026.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //  каталог получим из DataStore
    private var currentCart: Cart {
        return cart
    }
    
    //  лейбл если корзина пуста
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Корзина пуста"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //  стоимость корзины
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let placeOrderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Оформить заказ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        return button
    }()
    
//    //  кнопка которая справа сверху
    private var clearButton: UIBarButtonItem!

//    private let clearButton: UIBarButtonItem = {
//        let button = UIBarButtonItem(
//            title: "Очистить",
//            style: .plain,
//            target: self,
//            // сразу слот
//            action: #selector(clearCart)
//        )
//        return button
//    }()
    
    
    //  ТАБЛИЦА
    private let tableView: UITableView = {
        let table = UITableView()
        // обязательно ее регистрируем!!!
        table.register(UITableViewCell.self, forCellReuseIdentifier: "CartCell")
        
        //  должно быть всегда
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        clearButton = UIBarButtonItem(
            title: "Очистить",
            style: .plain,
            target: self,
            action: #selector(clearCart)
        )
        
        //  навигация сверху
        navigationItem.rightBarButtonItem = clearButton
        
        setupUI()
        setupTableView()
        setupActions()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //  обновляем инфу при возвращении на экран
        updateUI()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
        view.addSubview(totalLabel)
        view.addSubview(placeOrderButton)
        
        NSLayoutConstraint.activate([
            //  сверху сейф
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //  чтобы был нормальный отступ между таблицей и тотал
            tableView.bottomAnchor.constraint(equalTo: totalLabel.topAnchor, constant: -20),
            
            // по центру экрана
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            //  вверх уже привязали к таблице
            totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            totalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            //  привязываем вверх кнопки к низу лейбла
            totalLabel.bottomAnchor.constraint(equalTo: placeOrderButton.topAnchor, constant: -10),
            
            // посередине по X
            placeOrderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //  низ привязываем к сейф и отступ 20
            placeOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            // размер кнопки
            placeOrderButton.widthAnchor.constraint(equalToConstant: 250),
            placeOrderButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCart.count
    }
    
    // ЯЧЕЙКА
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CartCell")
                
        if let item = currentCart.getItem(at: indexPath.row) {
            cell.textLabel?.text = "\(item.product.name) x\(item.count)"
            
            if item.product.discount {
                let discountedPrice = Int(item.discountedPrice)
                let originalPrice = Int(item.totalPrice)
                cell.detailTextLabel?.text = "\(discountedPrice) ₽ (было \(originalPrice) ₽)"
                cell.detailTextLabel?.textColor = .systemRed
            } else {
                cell.detailTextLabel?.text = "\(Int(item.totalPrice)) ₽"
                cell.detailTextLabel?.textColor = .systemGreen
            }
        } else {
            cell.textLabel?.text = "Товар не найден"
            cell.detailTextLabel?.text = ""
        }

        cell.accessoryType = .none
        return cell
    }
        
    //  если будет выбрана ячейка
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    private func updateUI() {
        if currentCart.count > 0 {
            tableView.isHidden = false
            emptyLabel.isHidden = true  // прячем лейбл
            totalLabel.text = "Итого: \(Int(currentCart.discountedTotalCost())) ₽"
            placeOrderButton.isEnabled = true
        } else {
            tableView.isHidden = true   // прячем таблицу
            emptyLabel.isHidden = false
            totalLabel.text = "Итого: 0 ₽ "
            placeOrderButton.isEnabled = false
        }
        tableView.reloadData()
    }
    
    private func setupActions() {
    }
    
    @objc private func clearCart() {
        guard currentCart.count > 0 else {
            showAlert(title: "Корзина пуста", message: "Нечего очищать")
            return
        }
        
        let alert = UIAlertController(
            title: "Очистить корзину",
            message: "Вы уверены, что хотите удалить все товары?",
            preferredStyle: .alert
        )
        
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//        NSLog("The \"OK\" alert occured.")
//        }))
        
        alert.addAction(UIAlertAction(title: "Очистить", style: .destructive) { _ in
            for item in self.currentCart.getAllItems() {
                _ = self.currentCart.removeItem(name: item.product.name, count: item.count)
            }
            self.updateUI()
            self.showAlert(title: "Готово", message: "Корзина очищена")
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    //  фабрика алертов
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
}
