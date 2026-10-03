//
//  Users.swift
//  LessonProject
//
//  Created by Александр Трубкин on 26.08.2026.
//

import Foundation

///Кошелек
class Wallet {
    var balance: Double = 0.0
    
    init(balance: Double) {
        self.balance = balance
    }
}

///История заказов
struct OrderHistory {
    let itemCount: Int
    let itemName: String
    let itemPrice: Double
    let priceNotDiscount: Double
    let finalPriceOrder: Double
    let valueSale: Double
    let numberOrder: Int
    let saleIndicator: Bool

}

///Свойства пользователя
class User {
    let userName: String
    let userAge: Int
    var moneyCount: Wallet
    var userBasket: Basket
    var userOrderHistory: [OrderHistory] = []
    
    init(userName: String, userAge: Int, moneyCount: Wallet, userBasket: Basket) {
        self.userName = userName
        self.userAge = userAge
        self.moneyCount = moneyCount
        self.userBasket = userBasket
    }
}
///Массив пользователей
var arrayUsers: [User] = [user1, user2]

///Пользователи
let user1: User = User(userName: "Александр", userAge: 33, moneyCount: Wallet(balance: 200000.0), userBasket: Basket(products: []))
let user2: User = User(userName: "Дмитрий", userAge: 17, moneyCount: Wallet(balance: 200000.0), userBasket: Basket(products: []))



