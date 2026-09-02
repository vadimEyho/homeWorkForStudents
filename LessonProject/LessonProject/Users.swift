//
//  Users.swift
//  LessonProject
//
//  Created by Александр Трубкин on 26.08.2026.
//

import Foundation

///Свойства пользователя
struct User {
    let userName: String
    let userAge: Int
    var moneyCount: Double
    var userBasket: Basket

    ///Вывод данных пользователя
    func printUserInfo() {
        print("=== ПОЛЬЗОВАТЕЛЬ ===\n")
        print("Имя: \(userName)\nВозраст: \(userAge)\nБаланс: \(moneyCount)\n")
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
}

///Пользователи
let user1: User = User(userName: "Alex", userAge: 33, moneyCount: 20000, userBasket: Basket(products: []))
let user2: User = User(userName: "Dima", userAge: 17, moneyCount: 10000, userBasket: Basket(products: []))

///Массив пользователей
var arrayUsers: [User] = [user1, user2]

