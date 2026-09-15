//
//  Users.swift
//  LessonProject
//
//  Created by Александр Трубкин on 26.08.2026.
//

import Foundation

class Wallet {
    var balance: Double = 0.0
    
    init(balance: Double) {
        self.balance = balance
    }
}

///Свойства пользователя
class User {
    let userName: String
    let userAge: Int
    var moneyCount: Wallet
    var userBasket: Basket
    
    init(userName: String, userAge: Int, moneyCount: Wallet, userBasket: Basket) {
        self.userName = userName
        self.userAge = userAge
        self.moneyCount = moneyCount
        self.userBasket = userBasket
    }
    
    ///Вывод данных пользователя
    func printUserInfo() {
        print("Имя: \(userName)\nВозраст: \(userAge)\nБаланс: \(Int(moneyCount.balance)) ₽\n")
    }
}
    ///Массив пользователей
    var arrayUsers: [User] = [user1, user2]
    
    ///Пользователи
    let user1: User = User(userName: "Alex", userAge: 33, moneyCount: Wallet(balance: 200000.0), userBasket: Basket(products: []))
    let user2: User = User(userName: "Dima", userAge: 17, moneyCount: Wallet(balance: 200000.0), userBasket: Basket(products: []))

    
    
