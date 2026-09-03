//
//  ViewController.swift
//  LessonProject
//
//  Created by Александр Трубкин on 24.08.2026.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
            ///Часть 1
//            printItems(items: listProducts)
//            printTitleCatalogAndCategories(categories: .Books)
//            printProductOverprice(price: 10000, items: listProducts)
        
            ///Добавления товара в корзину определенному пользователю
            user1.userBasket.addProduct(product: item1)
//            user1.userBasket.addProduct(product: item1)
            user1.userBasket.addProduct(product: item2)
            user1.userBasket.addProduct(product: item2)
//            user1.userBasket.addProduct(product: item3)
            user1.userBasket.addProduct(product: item7)
        
            ///Часть 2
            //Вывод данных пользователя
//            user1.printUserInfo()
//            user1.userBasket.printBasketStockStatus()
//            user1.userBasket.printBasketSummary()
            
            ///Часть 3
//            user1.userBasket.calculatePriceFinal(promo: "SWIFT10")
//            user1.printBasketAndCheckAge()
        
            ///Часть 4
            user1.chekout()
    }


}

