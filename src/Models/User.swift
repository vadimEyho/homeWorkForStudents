//
//  User.swift
//  
//
//  Created by Lizaveta on 15.08.2026.
//

public class User {
    var name: String
    var age: Int
    var balance: Double
    var cart: Cart
    var promo: String?
    
    init(name: String, age: Int, balance: Double, cart: Cart) {
        self.name = name
        self.age = age
        self.balance = balance
        self.cart = cart
    }
    
    func printInfo() {
        print("Имя: \(name)")
        print("Возраст: \(age)")
        print("Баланс: \(balance)")
    }
    
}
