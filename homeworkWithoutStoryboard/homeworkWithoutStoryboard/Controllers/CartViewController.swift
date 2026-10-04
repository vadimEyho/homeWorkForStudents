//
//  ViewController.swift
//  homeworkWithoutStoryboard
//
//  Created by Lizaveta on 26.08.2026.
//

import UIKit
import SnapKit

final class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
        
        tableView.snp.makeConstraints { make in
            // сверху сейф
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            // низ привязан к верху totalLabel с отступом -20
            make.bottom.equalTo(totalLabel.snp.top).offset(-20)
        }

        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        totalLabel.snp.makeConstraints { make in
            // вверх уже привязан через tableView.bottom
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            // низ к верху кнопки с отступом -10
            make.bottom.equalTo(placeOrderButton.snp.top).offset(-10)
        }

        placeOrderButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            // низ к сейф
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            // размеры
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
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
            emptyLabel.isHidden = true  //  прячем лейбл
            totalLabel.text = "Итого: \(Int(currentCart.discountedTotalCost())) ₽"
            
            //  кнопка активна
            placeOrderButton.isEnabled = true
            placeOrderButton.backgroundColor = .systemBlue
            placeOrderButton.setTitleColor(.white, for: .normal)
        } else {
            tableView.isHidden = true   // прячем таблицу
            emptyLabel.isHidden = false
            totalLabel.text = "Итого: 0 ₽"
            
            //  кнопка заблокирована
            placeOrderButton.isEnabled = false
            placeOrderButton.backgroundColor = .systemGray
            placeOrderButton.setTitleColor(.white, for: .normal)
        }
        tableView.reloadData()
    }
    
    private func setupActions() {
        placeOrderButton.addTarget(
            self,
            action: #selector(placeOrderTapped),
            for: .touchUpInside
        )
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
    
    @objc private func placeOrderTapped() {
        guard currentCart.count > 0 else {
            showAlert(title: "Корзина пуста", message: "Добавьте товары перед оформлением")
            return
        }
        
        let checkoutVC = CheckoutViewController(cart: currentCart)
        navigationController?.pushViewController(checkoutVC, animated: true)
    }
}
