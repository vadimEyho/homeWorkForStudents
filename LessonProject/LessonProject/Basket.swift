//
//  Basket.swift
//  LessonProject
//
//  Created by Александр Трубкин on 24.08.2026.
//

import Foundation

//Цены для карточек товаров в каталоге
struct cartPrice {
    var priceNotBaseDiscout: Double
    var priceOnBaseDiscount: Double
}

// Корзина
class Basket {
    
    // Товары в корзине
    var productsInBasket: [ProductItem] = []
    
    init(products: [ProductItem]) {
        self.productsInBasket = products
    }
    
    /// Добавление товара в корзину
    func addProduct(item: ProductItem) {
        //Проверка на nil
        if let stock = item.itemInStock {
            //Сравнение наличия со складом
            if stock > quantity(product: item) {
                productsInBasket.append(item)
            } else {
                print("Товар: \(item.nameProduct) ❌ Товар закончился.\n")
                return
            }
        }
    }
    
    /// Количество конкретного товара в корзине
    func quantity(product: ProductItem) -> Int {
        return productsInBasket.filter { $0.idProduct == product.idProduct }.count
    }
    
    /// Скидка 10% на товар
    func baseSaleOnItem(item: ProductItem) -> cartPrice {
        
        var itemPrice = cartPrice (
            priceNotBaseDiscout: 0.0,
            priceOnBaseDiscount: 0.0
        )
        if item.onSale == true {
            itemPrice.priceOnBaseDiscount += item.priceProduct * 0.9
            itemPrice.priceNotBaseDiscout += item.priceProduct
        } else {
            itemPrice.priceNotBaseDiscout += item.priceProduct
            itemPrice.priceOnBaseDiscount += item.priceProduct
        }
        return itemPrice
    }
    
    /// Скидка 10% на корзину
    var baseSaleBasket: Double {
        var valueSum: Double = 0
        for product in productsInBasket {
            let item = baseSaleOnItem(item: product)
            valueSum += item.priceOnBaseDiscount
        }
        return valueSum
    }
    
    
}
