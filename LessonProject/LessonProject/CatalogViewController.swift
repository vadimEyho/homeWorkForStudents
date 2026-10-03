//
//  File.swift
//  LessonProject
//
//  Created by Александр Трубкин on 01.10.2026.
//

import Foundation
import UIKit

class CatalogViewController: UIViewController {
    
    //Кнопка на страницу корзины
    lazy var buttonToBasket: UIButton = {
        let button = UIButton()
        // Системная иконка стрелки вправо
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //Область карточки товара 1
    lazy var productCart1: UIView = {
        let cart = UIView()
        cart.backgroundColor = .white
        cart.layer.cornerRadius = 20
        cart.translatesAutoresizingMaskIntoConstraints = false
        return cart
    }()
    
    //Изображение карточки товара 1
    lazy var productImageCart1: UIImageView = {
        let icon = UIImageView()
        icon.image = .plugIcon
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    //Название товара 1
    lazy var productNameCart1: UILabel = {
        let name = UILabel()
//        let value = user1.userBasket.addProduct(item: item1)
        name.text = item1.nameProduct
        name.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    //Лейбл SALE для товаров с базовой скидкой
    let saleLabel: UILabel = {
        let saleLabel = UILabel()
        if let itemNil = item1.itemInStock, itemNil != 0{
            print(itemNil)
            saleLabel.text = "SALE"
            saleLabel.textColor = .red
            saleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        } else {
            saleLabel.text = ""
        }
        saleLabel.translatesAutoresizingMaskIntoConstraints = false
        return saleLabel
    }()
    
    //Списано (зачеркивание)
    let attributes: [NSAttributedString.Key: Any] = [
        .strikethroughStyle: NSUnderlineStyle.single.rawValue   // линия сквозь текст
    ]
    
    //Старая цена карточки товара 1
    lazy var productOldPriceCart1: UILabel = {
        let price = UILabel()
        let priceInfo = user1.userBasket.baseSaleOnItem(item: item1)
        //Зачеркивание
        let oldPriceString = NSAttributedString(string: "\(Int(priceInfo.priceNotBaseDiscout)) ₽", attributes: attributes)
        price.attributedText = oldPriceString
        price.font = UIFont.systemFont(ofSize: 7, weight: .bold)
        price.textColor = .black
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    //Новая цена карточки товара 1
    lazy var productNewPriceCart1: UILabel = {
        let price = UILabel()
        let priceInfo = user1.userBasket.baseSaleOnItem(item: item1)
        price.text = "\(Int(priceInfo.priceOnBaseDiscount)) ₽"
        price.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        price.textColor = .black
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    //Кнопка добавить в корзину
    let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 0
        stepper.minimumValue = 0
        if let inStok = item1.itemInStock {
            stepper.maximumValue = Double(inStok)
        }
        stepper.stepValue = 1
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    //Кнопка добавить в корзину
    let stepperLabel: UILabel = {
        let stepperLabel = UILabel()
        stepperLabel.text = "Hello"
        stepperLabel.translatesAutoresizingMaskIntoConstraints = false
        return stepperLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Убираем стандартную навигацию - уточнить
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(red: 247/255, green: 241/255, blue: 229/255, alpha: 1)
        
        
        view.addSubview(buttonToBasket)
        view.addSubview(productCart1)
        view.addSubview(productImageCart1)
        view.addSubview(productNameCart1)
        view.addSubview(saleLabel)
        view.addSubview(productOldPriceCart1)
        view.addSubview(productNewPriceCart1)
        view.addSubview(stepper)
//        view.addSubview(stepperLabel)
        
        
        NSLayoutConstraint.activate([
            buttonToBasket.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonToBasket.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonToBasket.widthAnchor.constraint(equalToConstant: 30),
            buttonToBasket.heightAnchor.constraint(equalToConstant: 30),
            
            productCart1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            productCart1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            productCart1.widthAnchor.constraint(equalToConstant: 190),
            productCart1.heightAnchor.constraint(equalToConstant: 240),
            
            productImageCart1.topAnchor.constraint(equalTo: productCart1.safeAreaLayoutGuide.topAnchor, constant: 10),
            productImageCart1.centerXAnchor.constraint(equalTo: productCart1.centerXAnchor),
            productImageCart1.widthAnchor.constraint(equalToConstant: 100),
            productImageCart1.heightAnchor.constraint(equalToConstant: 100),
            
            productNameCart1.topAnchor.constraint(equalTo: productImageCart1.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            productNameCart1.centerXAnchor.constraint(equalTo: productCart1.centerXAnchor),
            productNameCart1.widthAnchor.constraint(equalToConstant: 70),
            productNameCart1.heightAnchor.constraint(equalToConstant: 10),
            
            saleLabel.bottomAnchor.constraint(equalTo: productOldPriceCart1.safeAreaLayoutGuide.topAnchor, constant: -15),
            saleLabel.leadingAnchor.constraint(equalTo: productCart1.leadingAnchor, constant: 20),
            saleLabel.widthAnchor.constraint(equalToConstant: 40),
            saleLabel.heightAnchor.constraint(equalToConstant: 10),
            
            productOldPriceCart1.topAnchor.constraint(equalTo: productCart1.safeAreaLayoutGuide.topAnchor, constant: 195),
            productOldPriceCart1.leadingAnchor.constraint(equalTo: productCart1.leadingAnchor, constant: 20),
            productOldPriceCart1.widthAnchor.constraint(equalToConstant: 50),
            productOldPriceCart1.heightAnchor.constraint(equalToConstant: 10),
            
            productNewPriceCart1.topAnchor.constraint(equalTo: productOldPriceCart1.safeAreaLayoutGuide.bottomAnchor, constant: 5),
            productNewPriceCart1.leadingAnchor.constraint(equalTo: productCart1.leadingAnchor, constant: 20),
            productNewPriceCart1.widthAnchor.constraint(equalToConstant: 70),
            productNewPriceCart1.heightAnchor.constraint(equalToConstant: 10),
            
            stepper.topAnchor.constraint(equalTo: productCart1.safeAreaLayoutGuide.topAnchor, constant: 195),
            stepper.trailingAnchor.constraint(equalTo: productCart1.trailingAnchor, constant: -5),
//            stepper.widthAnchor.constraint(equalToConstant: 50),
//            stepper.heightAnchor.constraint(equalToConstant: 50),
//
//            stepperLabel.topAnchor.constraint(equalTo: productOldPriceCart1.safeAreaLayoutGuide.bottomAnchor, constant: 5),
//            stepperLabel.leadingAnchor.constraint(equalTo: productCart1.leadingAnchor, constant: 20),
//            stepperLabel.widthAnchor.constraint(equalToConstant: 70),
//            stepperLabel.heightAnchor.constraint(equalToConstant: 10),
            
            
        ])
        
        buttonToBasket.addTarget(self, action: #selector(openBasketTapped), for: .touchUpInside)
//        stepper.addTarget(self, action: #selector(stepperCart1Changed), for: .valueChanged)
    }
    
    @objc func openBasketTapped() {
        navigationController?.pushViewController(BasketViewController(), animated: true)
    }
}
