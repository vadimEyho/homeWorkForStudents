//
//  Catalog.swift
//  LessonProject
//
//  Created by Александр Трубкин on 24.08.2026.
//

import Foundation

///Разделы каталога
enum Categories: String {
    case Electronics = "Электроника"
    case Clothing = "Одежда"
    case Books = "Книги"
    case HomeAndKitchen = "Дом и кухня"
    case SportsAndOutdoors = "Спорт и отдых"
    case ToysAndGames = "Игрушки и игры"
}

///Свойства товара
struct ProductItem: Equatable {
    let idProduct: Int
    let nameProduct: String
    let priceProduct: Double
    let categoriesProduct: Categories
    var itemsInStock: Int?
    let onSale: Bool
}

///Каталог
struct ProductCatalog {
    //Массив продуктов
    var items: [ProductItem]
}


let item1: ProductItem = ProductItem(idProduct: 1, nameProduct: "iPhone 17", priceProduct: 75376, categoriesProduct: .Electronics, itemsInStock: 1, onSale: true)
let item2: ProductItem = ProductItem(idProduct: 2, nameProduct: "Куртка Columbia", priceProduct: 8897, categoriesProduct: .Clothing, itemsInStock: 50, onSale: false)
let item3: ProductItem = ProductItem(idProduct: 3, nameProduct: "Кулинарная книга", priceProduct: 550, categoriesProduct: .Books, itemsInStock: 1000, onSale: true)
let item4: ProductItem = ProductItem(idProduct: 4, nameProduct: "Рецепты", priceProduct: 250, categoriesProduct: .Books, itemsInStock: 1000, onSale: false)
let item5: ProductItem = ProductItem(idProduct: 5, nameProduct: "Кофеварка Tuvio", priceProduct: 15678, categoriesProduct: .HomeAndKitchen, itemsInStock: 279, onSale: false)
let item6: ProductItem = ProductItem(idProduct: 6, nameProduct: "Палатка", priceProduct: 2389, categoriesProduct: .SportsAndOutdoors, itemsInStock: 2467, onSale: true)
let item7: ProductItem = ProductItem(idProduct: 7, nameProduct: "Шахматы", priceProduct: 1234, categoriesProduct: .ToysAndGames, itemsInStock: nil, onSale: false)

///Массив товаров
let listProducts: [ProductItem] = [item1, item2, item3, item4, item5, item6, item7]

///Вывод товаров
func printItems(items: [ProductItem]) {
    print("=== КАТАЛОГ ===\n")
    for items in items {
        var transformStatus: String {items.onSale ? "Да" : "Нет"}
        let inStock = items.itemsInStock ?? 0
        print("\(items.nameProduct) - \(items.priceProduct) ₽\nКатегория: \(items.categoriesProduct.rawValue)\nНа складе: \(inStock)\nСкидка: \(transformStatus)\n")
    }
}

///Вывод раздела и его товаров
func printTitleCatalogAndCategories(categories: Categories) {
    print("=== \(categories.rawValue) ===\n")
    for items in listProducts {
        if items.categoriesProduct == categories {
            print(items.nameProduct)
        }
    }
}

///Вывод товаров дороже введенной суммы
func printProductOverprice(price: Double, items: [ProductItem]) {
    print("\n=== ТОВАРЫ ДОРОЖЕ \(price) ₽ ===\n")
    var sortItems = ""
    for items in items {
        if items.priceProduct > price {
            sortItems += ("\(items.nameProduct) - \(items.priceProduct) ₽\n")
        }
    }
    print(sortItems)
}
