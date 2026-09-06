//
//  ViewController.swift
//  homeworkWithoutStoryboard
//
//  Created by Lizaveta on 26.08.2026.
//

import UIKit

class CatalogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //  каталог получим из DataStore
    private var products: [Product] = []
    
    private var currentCart: Cart {
        return cart
    }
    
    //  вспомогательная переменная
    private var groupedProducts: [String: [Product]] = [:]
    
    //  название категорий (название СЕКЦИЙ в таблице)
    private var sectionTitles: [String] = []
    
    //  настройка главного тайтла
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Каталог товаров"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        //  расположение - посередине
        label.textAlignment = .center
        
        //  должно быть всегда
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //  под тайтлом
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Новый экран каталога товаров"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center

        //  должно быть всегда
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //  ТАБЛИЦА
    private let tableView: UITableView = {
        let table = UITableView()
        // обязательно ее регистрируем!!!
        table.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
        
        //  должно быть всегда
        
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
     }()
    
    //  При первой загрузке
    //  Создать view программно
    override func loadView() {
        super.loadView()
    }
    
    //  После загрузки view
    //  настройка UI, подписка на уведомления, загрузить данные
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        //  берем данные каталога
        products = catalog.getAllProducts()
    
        groupProductsByCategory()
        setupUI()
        setupTableView()
        
        // отключить маски
        
    }
    
    //  Перед появлением
    //  Обновить данные, настроить навигацию
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Обновляем данные из корзины
        tableView.reloadData()
    }
    
    //  После появления
    //  Вызывается КАЖДЫЙ раз после показа
    //  Выполняется ПОСЛЕ анимации появления
    //  View уже НА экране
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //  Вызывается КАЖДЫЙ раз перед исчезновением
    //  View еще НА экране
    //  Выполняется ДО анимации исчезновения
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //  Вызывается КАЖДЫЙ раз после исчезновения
    //  View уже НЕ на экране
    //  Выполняется ПОСЛЕ анимации исчезновения
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    private func groupProductsByCategory() {
        //  очищаем перед заполнением
        groupedProducts.removeAll()
        
        for product in products {
            let categoryName = getCategoryName(product.category)
            if groupedProducts[categoryName] == nil {
                groupedProducts[categoryName] = []
            }
            groupedProducts[categoryName]?.append(product)
        }
        
        sectionTitles = groupedProducts.keys.sorted()
    }
    
    private func getCategoryName(_ category: Category) -> String {
        switch category {
        case .electronics:
            return "Электроника"
        case .books:
            return "Книги"
        case .clothes:
            return "Одежда"
        case .product:
            return "Товары"
        }
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
        
    // Количество СЕКЦИЙ (категорий)
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    // Количество строк в каждой секции (товаров в категории)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categoryName = sectionTitles[section]
        return groupedProducts[categoryName]?.count ?? 0
    }
    
    // ЯЧЕЙКА
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //  чтобы отображался сабтайтл
        //  создать класс ячейки
        //
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ProductCell")

        // indexPath.section - ТЕКУЩАЯ СЕКЦИЯ
        let categoryName = sectionTitles[indexPath.section]
        let productsInCategory = groupedProducts[categoryName] ?? []
        
        // indexPath.row - НОМЕР СТРОКИ В ТЕКУЩЕЙ СЕКЦИИ
        let product = productsInCategory[indexPath.row]
        
        //  опционал, тк ячейка еще может быть не создана
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = "\(product.price) ₽"
        
        //  кодирование
        let tag = indexPath.section * 1000 + indexPath.row

        let removeButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("-", for: .normal)
            
            //  минимально возможный размер кнопки Apple так сказали
            // button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            
            //  чтобы понять, какую кнопку нажали
            button.tag = tag
            button.addTarget(self, action: #selector(removeToCartTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false

            return button
        }()
        
        let addButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("+", for: .normal)
            
            //  минимально возможный размер кнопки Apple так сказали
            //  если есть это, то label.translatesAutoresizingMaskIntoConstraints = false
            //  не надо
            //  button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            
            //  чтобы понять, какую кнопку нажали
            button.tag = tag
            button.addTarget(self, action: #selector(addToCartTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false

            return button
        }()
        
        let countLabel: UILabel = {
            let label = UILabel()
            
            let cartItems = currentCart.getAllItems()
            if let index = cartItems.firstIndex(where: { $0.product.name == product.name }) {
                label.text = "\(cartItems[index].count)"  // показываем количество
            } else {
                label.text = "0"  // товара нет в корзине
            }

            label.font = .systemFont(ofSize: 28, weight: .bold)
            label.textColor = .label
            //  расположение - посередине
            label.textAlignment = .center
            
            //  должно быть всегда
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
//        let stackView = UIStackView(arrangedSubviews: [removeButton, countLabel, addButton])
//        stackView.axis = .horizontal            // По умолчанию ось горизонтальная — ряд
//        stackView.distribution = .fillEqually   // Распределяем пространство равномерно
//        stackView.spacing = 10                  // Зазор между элементами
//        //  это если делать по-старому
//        stackView.frame = CGRect(x: 0, y: 0, width: 130, height: 44)
//        cell.accessoryView = stackView

        let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 8
            stackView.translatesAutoresizingMaskIntoConstraints = false

        //  это по-новому, но cell.accessoryView frame-based layout и игнорирует констрейеы
        cell.contentView.addSubview(stackView)
        stackView.addSubview(removeButton)
        stackView.addSubview(countLabel)
        stackView.addSubview(addButton)

        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: 148),
            stackView.heightAnchor.constraint(equalToConstant: 44)
        ])

//
//        NSLayoutConstraint.activate([
//            removeButton.widthAnchor.constraint(equalToConstant: 44),
//            removeButton.heightAnchor.constraint(equalToConstant: 44),
//            addButton.widthAnchor.constraint(equalToConstant: 44),
//            addButton.heightAnchor.constraint(equalToConstant: 44),
//            countLabel.widthAnchor.constraint(equalToConstant: 44),
//            countLabel.heightAnchor.constraint(equalToConstant: 44),
//            stackView.widthAnchor.constraint(equalToConstant: 140),
//            stackView.heightAnchor.constraint(equalToConstant: 44),
//            
//            stackView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
//            stackView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
//            
//            cell.textLabel!.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
//            cell.textLabel!.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
//            cell.textLabel!.trailingAnchor.constraint(lessThanOrEqualTo: stackView.leadingAnchor, constant: -16),
//            
//            cell.detailTextLabel!.leadingAnchor.constraint(equalTo: cell.textLabel!.leadingAnchor),
//            cell.detailTextLabel!.topAnchor.constraint(equalTo: cell.textLabel!.bottomAnchor, constant: 4),
//            cell.detailTextLabel!.trailingAnchor.constraint(lessThanOrEqualTo: stackView.leadingAnchor, constant: -16),
//            cell.detailTextLabel!.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10)
//        ])
        return cell
    }
    
    //  для названия секций
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let categoryName = sectionTitles[section]
        return "\(categoryName)"
    }
    
    //  если будет выбрана ячейка
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    @objc private func addToCartTapped(_ sender: UIButton) {
        let row = sender.tag % 1000
        let section = sender.tag / 1000
    
        let categoryName = sectionTitles[section]
        let products = groupedProducts[categoryName] ?? []
        let product = products[row]
        
        _ = cart.addItemCart(name: product.name, count: 1)
        tableView.reloadData()
    }
    
    @objc private func removeToCartTapped(_ sender: UIButton) {
        let row = sender.tag % 1000
        let section = sender.tag / 1000
    
        let categoryName = sectionTitles[section]
        let products = groupedProducts[categoryName] ?? []
        let product = products[row]
        
        _ = cart.removeItem(name: product.name, count: 1)
        tableView.reloadData()
    }
}


