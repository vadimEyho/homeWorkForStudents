//
//  User.swift
//  
//
//  Created by Lizaveta on 15.08.2026.
//

struct User {
    var name: String
    var age: Int
    var balance: Double
    var cart: Cart
    var promo: String?
    
    func checkAge() -> Bool {
        return age >= 18
    }
    
    func printInfo() {
        print("Имя: \(name)")
        print("Возраст: \(age)")
        print("Баланс: \(balance)")
    }
    
    func printAgeCheck() {
        print("\n=== ПРОВЕРКА ВОЗРАСТА ===\n")
        print("Пользователь: \(name)")
        print("Возраст: \(age)\n")
        
        if age >= 18 {
            print("✅ Проверка пройдена")
            print("Пользователь может совершить покупку\n")
            return
        }
        
        let restrictedItems = cart.getForbiddenProducts()
        if restrictedItems.count > 0 {
            for product in restrictedItems {
                print("❌ Покупка запрещена.")
                print("Товар: \(product.name)")
                print("Цена: \(Int(product.price)) ₽")
                print("Пользователь младше 18 лет не может купить этот товар.\n")
            }
        } else {
            print("✅ Проверка пройдена")
            print("Пользователь может совершить покупку\n")
        }
    }
}
