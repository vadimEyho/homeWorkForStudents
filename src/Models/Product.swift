//
//  ProductClass.swift
//  elizaveta-sidorenkova
//
//  Created by Lizaveta on 14.08.2026.
//

//  во множественном или единственном числе перечисления?
//  с большой или маленькой буквы?
enum Category: String {
    case electronics = "Электроника"
    case product = "Продукты"
    case clothes = "Одежда"
    case books = "Книги"
}

public class Product {
    // UUID???
    var id: Int
    var name: String
    var price: Double
    var category: Category
    var count: Int
    var discount: Bool
    
    init(id: Int, name: String, price: Double, category: Category, count: Int, discount: Bool) {
        self.id = id
        self.name = name
        self.price = price
        self.category = category
        self.count = count
        self.discount = discount
    }
    
    func printInfo() {
        print("\(name) — \(Int(price)) ₽")
    }
    
    func printName() {
        print("Название: \(name) — \(Int(price)) ₽")
    }
    
    func printPrice() {
        print("Стоимость: \(Int(price)) ₽")
    }
    
    func printCategory() {
        print("Категория: \(category)")
    }
    
    func printCount() {
        print("На складе: \(count)")
    }
    
    func printDiscount() {
        if (discount) {
            print("Скилка: да")
        } else {
            print("Скидка: нет")
        }
    }
    
    func printFullInfo() {
        printInfo()
        printCategory()
        printCount()
        printDiscount()
    }
}

