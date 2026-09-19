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

struct OrderItem {
    let nameItem: String
    let priceOnSale: Bool
    let count: Int
    let priceProduct: Double
}

///История заказов
struct OrderHistory {
    let user: String
    let userCartItem: [OrderItem]
    let itemCount: Int
    let priceNotDiscount: Double
    let valueSale: Double
    let finalPriceOrder: Double
    let numberOrder: Int
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
    
    ///Вывод данных пользователя
    func printUserInfo() {
        print("Имя: \(userName)\nВозраст: \(userAge)\nБаланс: \(Int(moneyCount.balance)) ₽\n")
    }
    
    func printUserHistory() {
        
        print("\n=== ИСТОРИЯ ЗАКАЗОВ ===\n")
        for history in userOrderHistory {
            print("Заказ: №\(history.numberOrder)\nПокупатель: \(history.user)\nТоваров: \(history.itemCount)\nИтого: \(Int(history.finalPriceOrder))\n")
        }
        
        print("\n=== АНАЛИТИКА ===\n")
        let sortedOrdersPriceMax = userOrderHistory.max { $0.finalPriceOrder < $1.finalPriceOrder }
        let sortedOrdersPriceMin = userOrderHistory.min { $0.finalPriceOrder < $1.finalPriceOrder }
        guard let mostExpensive = sortedOrdersPriceMax,
              let cheapest = sortedOrdersPriceMin else {
            print("История заказов пуста")
            return
        }
        
        print("Количество заказов: \(userOrderHistory.count)\n")
        print("Самый дорогой заказ: \(Int(mostExpensive.finalPriceOrder))")
        print("Самый дешёвый заказ: \(Int(cheapest.finalPriceOrder))")
        
        
        print("\n=== ТОВАРЫ ДОРОЖЕ 5000 ₽ ===\n")
        var printedNames: [String] = []
        for order in userOrderHistory {
            for item in order.userCartItem {
                if item.priceProduct > 5000 {
                    if !printedNames.contains(item.nameItem) {
                        print("\(item.nameItem) - \(Int(item.priceProduct))")
                        printedNames.append(item.nameItem)
                    }
                }
            }
        }
        
        print("\n=== ТОВАРЫ СО СКИДКОЙ ===\n")
        for OrderHistory in userOrderHistory {
            for OrderItem in OrderHistory.userCartItem{
                if OrderItem.priceOnSale == true {
                    print("\(OrderItem.nameItem)\n")
                }
            }
        }
        
        
        print("\n=== ТОВАРЫ ПО ВОЗРАСТАНИЮ ЦЕНЫ ===\n")
        var uniqueNames: [String] = []
        var allItems: [OrderItem] = []
        for OrderHistory in userOrderHistory {
            for OrderItem in OrderHistory.userCartItem {
                if !uniqueNames.contains(OrderItem.nameItem) {
                    uniqueNames.append(OrderItem.nameItem)
                    allItems.append(OrderItem)
                }
            }
        }
        let sortedItems = allItems.sorted { $0.priceProduct < $1.priceProduct }
        for priceSort in sortedItems {
            print("\(priceSort.nameItem) - \(Int(priceSort.priceProduct))")
        }
        
        
        
        print("\n=== НАЗВАНИЯ КУПЛЕННЫХ ТОВАРОВ ===\n")
        var sortItems: [String] = []
        for OrderHistory in userOrderHistory {
            for OrderItem in OrderHistory.userCartItem {
                if !sortItems.contains(OrderItem.nameItem) {
                    sortItems.append(OrderItem.nameItem)
                }
            }
        }
        for nameItems in sortItems {
            print("\(nameItems)")
        }
    }
}
///Массив пользователей
var arrayUsers: [User] = [user1, user2]

///Пользователи
let user1: User = User(userName: "Alex", userAge: 33, moneyCount: Wallet(balance: 200000.0), userBasket: Basket(products: []))
let user2: User = User(userName: "Dima", userAge: 17, moneyCount: Wallet(balance: 200000.0), userBasket: Basket(products: []))



