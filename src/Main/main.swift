//
//  main.swift
//  elizaveta-sidorenkova
//
//  Created by Lizaveta on 14.08.2026.
//

import Foundation

var catalog: Catalog = Catalog()
catalog.addProduct(Product(id: 1, name: "MacBook Pro", price: 149900, category: .electronics, count: 3, discount: false))
catalog.addProduct(Product(id: 2, name: "AirPods Pro", price: 24990, category: .electronics, count: 5, discount: true))
catalog.addProduct(Product(id: 3, name: "Swift Programming", price: 2990, category: .books, count: 10, discount: true))
catalog.addProduct(Product(id: 4, name: "Футболка", price: 1990, category: .clothes, count: 4, discount: false))
catalog.addProduct(Product(id: 5, name: "Кофе", price: 890, category: .product, count: 8, discount: false))
catalog.addProduct(Product(id: 6, name: "Клавиатура", price: 7990, category: .product, count: 0, discount: false))

catalog.printAllProducts()
print("\n=== ЭЛЕКТРОНИКА ===")
for pr in catalog.getProductsByCategory(.electronics) {
    pr.printName()
}

print("\n=== ТОВАРЫ ДОРОЖЕ 10000 ₽ ===")
for pr in catalog.getProductsOverPrice(10000) {
    pr.printInfo()
}
