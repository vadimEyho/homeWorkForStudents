//
//  ViewController.swift
//  LessonProject
//
//  Created by Александр Трубкин on 24.08.2026.
//

import UIKit

class BasketViewController: UIViewController {
    
    lazy var catalogDataSource = CatalogDataSource()
    lazy var basketPageTitle: UILabel = printPageTitle(text: "Корзина")
    lazy var basketIcon: UIImageView = printBasketIcon(img: .basketIcon2)
    lazy var payOrder: UIButton = printButtonOrder()
    
    //Стрелка назад
    lazy var backToCatalogButton: UIButton = {
        let button = UIButton()
        // Системная иконка стрелки влево
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //Заголовок
    func printPageTitle(text: String) -> UILabel {
        let pageTitle = UILabel()
        pageTitle.text = text
        pageTitle.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        pageTitle.textColor = .black
        pageTitle.translatesAutoresizingMaskIntoConstraints = false
        return pageTitle
    }
    
    //Иконка
    func printBasketIcon(img: UIImage) -> UIImageView {
        let icon = UIImageView()
        icon.image = img
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }
    
    //Таблица - каталог
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .insetGrouped)
        //Регистрация ячейки
        tableView.register(ProductCell.self, forCellReuseIdentifier: "idCatalog")
        tableView.dataSource = catalogDataSource
        tableView.separatorColor = .black
        tableView.backgroundColor = UIColor(red: 247/255, green: 241/255, blue: 229/255, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    //Область оплаты
    lazy var printPayArea: UIView = {
        let payArea = UIView()
        payArea.backgroundColor = .white
        payArea.layer.cornerRadius = 20
        payArea.translatesAutoresizingMaskIntoConstraints = false
        return payArea
    }()
    
    //Cтоимость
    lazy var subTotalText: UILabel = {
        let subTotalText = UILabel()
        subTotalText.text = "Стоимость"
        subTotalText.textColor = .black
        subTotalText.translatesAutoresizingMaskIntoConstraints = false
        return subTotalText
    }()
    
    //Стоимость промежуточная
    lazy var subTotalPrice: UILabel = {
        let price = UILabel()
//        let totalFullPrice = user1.userBasket.calculateBasket()
//        price.text = "\(Int(totalFullPrice.0)) ₽"
        price.textColor = .black
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    //Промокод заголовок
    lazy var promoCodeTitle: UILabel = {
        let promoCodeTitle = UILabel()
        promoCodeTitle.text = "Промокод"
        promoCodeTitle.textColor = .black
        promoCodeTitle.translatesAutoresizingMaskIntoConstraints = false
        return promoCodeTitle
    }()
    
    //Промокод значение
    lazy var promoCodeValue: UILabel = {
        let promoCodeValue = UILabel()
//        let totalFullPrice = user1.userBasket.applyDiscount(price: 1, promocode: .swift10)
//        promoCodeValue.text = "\(totalFullPrice.1)"
        promoCodeValue.textColor = .black
        promoCodeValue.translatesAutoresizingMaskIntoConstraints = false
        return promoCodeValue
    }()
    
    // Создаём линию разделитель
    let separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray3  // цвет линии
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    //Итого заголовок
    lazy var totalText: UILabel = {
        let TotalText = UILabel()
        TotalText.text = "Итого"
        TotalText.textColor = .black
        TotalText.translatesAutoresizingMaskIntoConstraints = false
        return TotalText
    }()
    
    //Итоговая стоимость
    lazy var totalPrice: UILabel = {
        let price = UILabel()
//        let totalPriceUi = user1.userBasket.printBasketOnSale(promo: .swift10)
//        price.text = "\(Int(totalPriceUi.0)) ₽"
        price.textColor = .black
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    //Кнопка добавить в корзину
    func printButtonOrder() -> UIButton {
        let payButton = UIButton()
        payButton.setTitle("Перейти к оформлению", for: .normal)
        payButton.setTitleColor(.white, for: .normal)
        payButton.setTitleColor(.gray, for: .highlighted)
        payButton.backgroundColor = .black
        payButton.layer.cornerRadius = 20
        payButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        return payButton
    }
    
    // Получение/обновление цены
//    func updatePrice() {
//        let totalFullPrice = user1.userBasket.calculateBasket()
//        subTotalPrice.text = "\(Int(totalFullPrice.0)) ₽"
//        let totalPriceUi = user1.userBasket.printBasketOnSale(promo: .swift10)
//        totalPrice.text = "\(totalPriceUi.0) ₽"
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 247/255, green: 241/255, blue: 229/255, alpha: 1)
        
        view.addSubview(backToCatalogButton)
        view.addSubview(basketPageTitle)
        view.addSubview(basketIcon)
        view.addSubview(tableView)
        view.addSubview(printPayArea)
        view.addSubview(subTotalText)
        view.addSubview(subTotalPrice)
        view.addSubview(payOrder)
        view.addSubview(promoCodeTitle)
        view.addSubview(promoCodeValue)
        view.addSubview(separatorLine)
        view.addSubview(totalText)
        view.addSubview(totalPrice)
        
        
        
        
        
        NSLayoutConstraint.activate([
            backToCatalogButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backToCatalogButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backToCatalogButton.widthAnchor.constraint(equalToConstant: 30),
            backToCatalogButton.heightAnchor.constraint(equalToConstant: 30),
            
            basketPageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            basketPageTitle.leadingAnchor.constraint(equalTo: backToCatalogButton.trailingAnchor, constant: 100),
            basketPageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -130),
            basketPageTitle.heightAnchor.constraint(equalToConstant: 32),
            
            basketIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            basketIcon.leadingAnchor.constraint(equalTo: basketPageTitle.leadingAnchor, constant: 200),
            basketIcon.widthAnchor.constraint(equalToConstant: 22),
            basketIcon.heightAnchor.constraint(equalToConstant: 22),
            
            tableView.topAnchor.constraint(equalTo: basketPageTitle.bottomAnchor, constant: 70),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            tableView.heightAnchor.constraint(equalToConstant: 700),
            
            payOrder.topAnchor.constraint(equalTo: backToCatalogButton.bottomAnchor, constant: 650),
            payOrder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            payOrder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            payOrder.heightAnchor.constraint(equalToConstant: 50),
            
            printPayArea.topAnchor.constraint(equalTo: basketPageTitle.bottomAnchor, constant: 520),
            printPayArea.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            printPayArea.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            printPayArea.heightAnchor.constraint(equalToConstant: 200),
            
            subTotalPrice.topAnchor.constraint(equalTo: printPayArea.topAnchor, constant: 5),
            subTotalPrice.leadingAnchor.constraint(equalTo: printPayArea.leadingAnchor, constant: 265),
            subTotalPrice.trailingAnchor.constraint(equalTo: printPayArea.trailingAnchor, constant: -5),
            subTotalPrice.heightAnchor.constraint(equalToConstant: 50),
            
            subTotalText.topAnchor.constraint(equalTo: printPayArea.topAnchor, constant: 5),
            subTotalText.leadingAnchor.constraint(equalTo: printPayArea.leadingAnchor, constant: 15),
            subTotalText.trailingAnchor.constraint(equalTo: printPayArea.trailingAnchor, constant: -135),
            subTotalText.heightAnchor.constraint(equalToConstant: 50),
            
            promoCodeTitle.topAnchor.constraint(equalTo: subTotalText.topAnchor, constant: 25),
            promoCodeTitle.leadingAnchor.constraint(equalTo: printPayArea.leadingAnchor, constant: 15),
            promoCodeTitle.trailingAnchor.constraint(equalTo: printPayArea.trailingAnchor, constant: -135),
            promoCodeTitle.heightAnchor.constraint(equalToConstant: 50),
            
            promoCodeValue.topAnchor.constraint(equalTo: subTotalText.topAnchor, constant: 25),
            promoCodeValue.leadingAnchor.constraint(equalTo: printPayArea.leadingAnchor, constant: 265),
            promoCodeValue.trailingAnchor.constraint(equalTo: printPayArea.trailingAnchor, constant: -5),
            promoCodeValue.heightAnchor.constraint(equalToConstant: 50),
            
            separatorLine.topAnchor.constraint(equalTo: printPayArea.topAnchor, constant: 75),
            separatorLine.leadingAnchor.constraint(equalTo: printPayArea.leadingAnchor, constant: 15),
            separatorLine.trailingAnchor.constraint(equalTo: printPayArea.trailingAnchor, constant: -15),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            totalText.topAnchor.constraint(equalTo: promoCodeTitle.topAnchor, constant: 39),
            totalText.leadingAnchor.constraint(equalTo: printPayArea.leadingAnchor, constant: 15),
            totalText.trailingAnchor.constraint(equalTo: printPayArea.trailingAnchor, constant: -135),
            totalText.heightAnchor.constraint(equalToConstant: 50),
            
            totalPrice.topAnchor.constraint(equalTo: promoCodeTitle.topAnchor, constant: 39),
            totalPrice.leadingAnchor.constraint(equalTo: printPayArea.leadingAnchor, constant: 265),
            totalPrice.trailingAnchor.constraint(equalTo: printPayArea.trailingAnchor, constant: -5),
            totalPrice.heightAnchor.constraint(equalToConstant: 50),
        ])
        
//        payOrder.addTarget(self, action: #selector(addBasketTapped), for: .touchUpInside)
        backToCatalogButton.addTarget(self, action: #selector(openBasketTapped), for: .touchUpInside)
        
    }
    
//    @objc func addBasketTapped() {
//        user1.userBasket.addProduct(product: item1)
//        user1.userBasket.addProduct(product: item2)
//        user1.userBasket.addProduct(product: item3)
//        user1.userBasket.addProduct(product: item4)
//        user1.userBasket.addProduct(product: item5)
//        user1.userBasket.addProduct(product: item6)
//        user1.userBasket.addProduct(product: item7)
//        //        print("Товары добавлены в корзину")
//        tableView.reloadData()
//        updatePrice()
//    }
    
    @objc func openBasketTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

//Настройка таблицы (каталога)
class CatalogDataSource: NSObject, UITableViewDataSource {
    //Сколько ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        min(user1.userBasket.products.count, 7)
        return 1
    }
    //Как выглядит одна ячейка
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Получить ячейку
        let idTable = tableView.dequeueReusableCell(withIdentifier: "idCatalog", for: indexPath)
        //Получаем товары
//        let product = user1.userBasket.products[indexPath.row]
        
        //Оформление
        idTable.imageView?.image = UIImage(named: "plugIcon")
//        idTable.textLabel?.text = product.nameProduct
//        idTable.detailTextLabel?.text = "\(Int(product.priceProduct)) ₽"
        idTable.detailTextLabel?.textColor = .black
        return idTable
    }
    
}

//Объяснить зачем и почему так
class ProductCell: UITableViewCell {
    
    // Инициализатор с правильным стилем
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // Вызываем родительский инициализатор со стилем .value1
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    // Требуется для работы со Storyboard (нам не нужен, но Swift требует)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
