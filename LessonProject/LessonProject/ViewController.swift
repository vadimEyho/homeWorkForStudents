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
        //        printItems(items: listProducts)
        //        printTitleCatalogAndCategories(categories: .Books)
        //        printProductOverprice(price: 10000, items: listProducts)
        
        ///Добавления товара в корзину определенному пользователю
        //        user1.userBasket.addProduct(product: item1)
        //        user1.userBasket.addProduct(product: item1)
        //        user1.userBasket.addProduct(product: item2)
        //        user1.userBasket.addProduct(product: item2)
        //        user1.userBasket.addProduct(product: item3)
        //        user1.userBasket.addProduct(product: item7)
        
        ///Часть 2
        ///Вывод данных пользователя
        //        print("=== ПОЛЬЗОВАТЕЛЬ ===\n")
        //        user1.printUserInfo()
        //        user1.userBasket.printBasketStockStatus()
        //        user1.userBasket.printBasketSummary()
        
        
        ///Часть 3
        //        print("=== РАСЧЁТ КОРЗИНЫ ===\n")
        //        user1.userBasket.printBasketOnSale(promo: .student)
        //        user1.userBasket.moneyAndAge(user: user1)
        
        
        ///Часть 4
        //Чекаунт покупки, оформление заказа + печать чека
        //        user1.userBasket.moneyAndAge(user: user1, promo: .student)
        
        //        user1.userBasket.addProduct(product: item1)
        //        user1.userBasket.addProduct(product: item2)
        //        user1.userBasket.addProduct(product: item2)
        //        user1.userBasket.moneyAndAge(user: user1, promo: .student)
        
        //Часть 5
        user1.userBasket.addProduct(product: item1)
        user1.userBasket.addProduct(product: item2)
        user1.userBasket.addProduct(product: item2)
        user1.userBasket.moneyAndAge(user: user1, promo: .student)
        
//        user1.userBasket.addProduct(product: item1)
//        user1.userBasket.addProduct(product: item2)
//        user1.userBasket.addProduct(product: item2)
//        user1.userBasket.moneyAndAge(user: user1, promo: .swift10)
        
    }
    
}

