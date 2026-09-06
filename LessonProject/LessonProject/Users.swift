//
//  Users.swift
//  LessonProject
//
//  Created by Александр Трубкин on 26.08.2026.
//

import Foundation

///Свойства пользователя
class User {
    let userName: String
    let userAge: Int
    var moneyCount: Double
    var userBasket: Basket
    let wallet: Wallet

    init(userName: String, userAge: Int, moneyCount: Double, userBasket: Basket) {
        self.userName = userName
        self.userAge = userAge
        self.moneyCount = moneyCount
        self.userBasket = userBasket
    }

    ///Вывод данных пользователя
    func printUserInfo() {
        print("=== ПОЛЬЗОВАТЕЛЬ ===\n")
        print("Имя: \(userName)\nВозраст: \(userAge)\nБаланс: \(Int(moneyCount))\n")
    }

    ///Проверк возраста при превышении лимита корзины
    func printBasketAndCheckAge() {
        print("=== ПРОВЕРКА ВОЗРАСТА ===\n")
        print("Пользователь: \(userName)\nВозраст: \(userAge)\nКорзина:\(userBasket.printOnlyItem().dropLast().dropLast())")
        let sum = userBasket.sumBasketNotSaleAndDiscont()

        if userAge < 18 && Int(sum) >= 100000 {
            print("❌ Пользователь младше 18 лет, не может совершать покупки дороже 100000 ₽")
        } else {
            print("Цена: \(Int(sum))")
        }
    }

    /// Создать кошелек юзера и вынести от сюда

    func printMoneyUser() {
        print("=== ОФОРМЛЕНИЕ ЗАКАЗА ===\n")
        print("Имя: \(userName)\nБаланс до покупки: \(Int(moneyCount)) ₽\n\n")
    }

    func printRemainMoneyUser() {
        let balanceUser = moneyCount
        let sumBasket = userBasket.printCheckUser()
        let remainMoneyUser = Int(balanceUser) - Int(sumBasket)
        if Int(balanceUser) < Int(sumBasket) {
            print("Стоимость заказа: \(sumBasket) ₽\nБаланс: \(Int(balanceUser)) ₽\n")
            print("❌ Недостаточно средств\n")
        } else {
            print("✅ Заказ успешно оформлен\n")
            print("Баланс до покупки: \(Int(balanceUser)) ₽\nБаланс после покупки: \(remainMoneyUser) ₽")
            moneyCount = Double(remainMoneyUser)
        }

    }

    /// Вынести логику в корзину и разделить

    ///Чекаут негативных кейсов перед покупкой
    func chekout() -> (Bool, resoms: String?) {

        // Проверка корзины на пустоту
        guard userBasket.products.isEmpty else {
            print("❌ Корзина пуста.")
            return
        }

        /// Вынести логику в корзину
        // Проверка наличия товара на складе
        for items in userBasket.products {
            guard let stock = items.itemsInStock,
                  stock > 0 else {
                print("❌ Нет товара \(items.nameProduct) на складе")
                return
            }
        }

        /// Вынести логику в корзину
        if userBasket.totalSum >= 100000 && userAge < 18 {
            print("❌ Пользователь младше 18 лет, не может совершать покупки дороже 100000 ₽")
            return
        }

        /// Вынести логику в корзину
        //Сопоставление денег пользователя с суммой корзины
        if moneyCount < userBasket.calculateTotal() {
            print("❌ Недостаточно средств\n")
            return
        }
//
//        processOrder()
    }

    /// Вынести логику в корзину
    func processOrder() {

      guard chekout() else {
          print("\(_, chekout.resoms)")
            return
        }

        printMoneyUser()
        printRemainMoneyUser()

        // В корзину
        // Уменьшаем остатки
        for product in userBasket.products {
            if let currentStock = product.itemsInStock {
                product.itemsInStock = currentStock - 1
            }
        }

        ///  в корзину
        userBasket.products.removeAll()
        myCatalog.printStockStatus()
        if userBasket.products == [] {
            print("\n=== КОРЗИНА ===\nКорзина пуста")
        } else {
            print("Завалялось в корзине \(userBasket.products)")
        }
    }
}

///Пользователи
let user1: User = User(userName: "Alex", userAge: 33, moneyCount: wallet., userBasket: Basket(products: []))
let user2: User = User(userName: "Dima", userAge: 17, moneyCount: 10000, userBasket: Basket(products: []))

///Массив пользователей
var arrayUsers: [User] = [user1, user2]

