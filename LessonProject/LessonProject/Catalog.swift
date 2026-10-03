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
class ProductItem: Equatable {
    let idProduct: Int
    let nameProduct: String
    let priceProduct: Double
    let categoriesProduct: Categories
    var itemInStock: Int?
    let onSale: Bool
    
    init(idProduct: Int, nameProduct: String, priceProduct: Double, categoriesProduct: Categories, itemInStock: Int? = nil, onSale: Bool) {
        self.idProduct = idProduct
        self.nameProduct = nameProduct
        self.priceProduct = priceProduct
        self.categoriesProduct = categoriesProduct
        self.itemInStock = itemInStock
        self.onSale = onSale
    }
    
    // Cравнения двух товаров
    static func == (lhs: ProductItem, rhs: ProductItem) -> Bool {
        return lhs.idProduct == rhs.idProduct
    }
}

///Каталог
struct ProductCatalog {
    //Массив продуктов
    var items: [ProductItem]
}

let item1: ProductItem = ProductItem(idProduct: 1, nameProduct: "iPhone 17", priceProduct: 175376, categoriesProduct: .Electronics, itemInStock: 1, onSale: true)
let item2: ProductItem = ProductItem(idProduct: 2, nameProduct: "Куртка Columbia", priceProduct: 8897, categoriesProduct: .Clothing, itemInStock: 50, onSale: false)
let item3: ProductItem = ProductItem(idProduct: 3, nameProduct: "Кулинарная книга", priceProduct: 550, categoriesProduct: .Books, itemInStock: 1000, onSale: true)
let item4: ProductItem = ProductItem(idProduct: 4, nameProduct: "Рецепты", priceProduct: 250, categoriesProduct: .Books, itemInStock: 1000, onSale: false)
let item5: ProductItem = ProductItem(idProduct: 5, nameProduct: "Кофеварка Tuvio", priceProduct: 15678, categoriesProduct: .HomeAndKitchen, itemInStock: 279, onSale: false)
let item6: ProductItem = ProductItem(idProduct: 6, nameProduct: "Палатка", priceProduct: 2389, categoriesProduct: .SportsAndOutdoors, itemInStock: 2467, onSale: true)
let item7: ProductItem = ProductItem(idProduct: 7, nameProduct: "Шахматы", priceProduct: 1234, categoriesProduct: .ToysAndGames, itemInStock: nil, onSale: false)

///Массив товаров
let listProducts: [ProductItem] = [item1, item2, item3, item4, item5, item6, item7]
///Создание каталога
let myCatalog = ProductCatalog(items: listProducts)


