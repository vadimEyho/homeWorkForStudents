//
//  ViewController.swift
//  homeworkWithoutStoryboard
//
//  Created by Lizaveta on 26.08.2026.
//

import UIKit

class CatalogViewController: UIViewController {

    //  каталог получим из DataStore
    private var products: [Product] = []
    
    private var currentCart: Cart {
        return cart
    }
    
    
    private let tableManager = CatalogTableManager()

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
    
    
    // таблица
       private let tableView: UITableView = {
           let table = UITableView()
           // регистрируем нашу ячейку, чтобы потом можно было её доставать
           table.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
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

        // берём все товары из каталога
        products = catalog.getAllProducts()

        // настраиваем таблицу
        setupUI()
        setupTableView()

        // говорим менеджеру, какие у нас товары
        tableManager.configure(with: products)

        // менеджер должен уметь узнать, сколько товара в корзине
        tableManager.countForProduct = { product in // это необязательно
            let items = cart.getAllItems()
            for item in items {
                if item.product.name == product.name {
                    return item.count
                }
            }
            return 0
        }
        
        // когда в ячейке нажали "+", добавляем товар в корзину
        // onAddProduct - свойство-замыкание
        // оно получает product и ничего не возвращает, а просто меняет значения в корзине
        tableManager.onAddProduct = { product in
            _ = cart.addItemCart(name: product.name, count: 1)
            self.tableView.reloadData()
        }

        // когда в ячейке нажали "−", убираем товар из корзины
        // мы в контроллере определяем поведение замыканий
        tableManager.onRemoveProduct = { product in
            _ = cart.removeItem(name: product.name, count: 1)
            self.tableView.reloadData()
        }
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
    
    private func setupUI() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // подключаем менеджер к таблице
    private func setupTableView() {
        tableView.delegate = tableManager
        tableView.dataSource = tableManager
        tableManager.tableView = tableView
    }
}
