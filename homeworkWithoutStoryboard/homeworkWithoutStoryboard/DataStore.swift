//
//  DataStore.swift
//  homeworkWithoutStoryboard
//
//  Created by Lizaveta on 26.08.2026.
//

import Foundation

// Глобальная переменная с каталогом
let catalog = Catalog()
let cart = Cart(items: [], catalog: catalog)

// Функция для заполнения данными каталога
func setupCatalog() {
    catalog.addProduct(Product(id: 1, name: "MacBook Pro", price: 149900, category: .electronics, count: 3, discount: false))
    catalog.addProduct(Product(id: 2, name: "AirPods Pro", price: 24990, category: .electronics, count: 5, discount: true))
    catalog.addProduct(Product(id: 3, name: "Swift Programming", price: 2990, category: .books, count: 10, discount: true))
    catalog.addProduct(Product(id: 4, name: "Футболка", price: 1990, category: .clothes, count: 4, discount: false))
    catalog.addProduct(Product(id: 5, name: "Кофе", price: 890, category: .product, count: 8, discount: false))
    catalog.addProduct(Product(id: 6, name: "Клавиатура", price: 7990, category: .product, count: 0, discount: false))
}

// Функция для заполнения данными корзины
func setupCart() {
    _ = cart.addItemCart(name: "MacBook Pro", count: 1)
    _ = cart.addItemCart(name: "AirPods Pro", count: 1)
    _ = cart.addItemCart(name: "Футболка", count: 2)
}
