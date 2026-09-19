//
//  Basket.swift
//  LessonProject
//
//  Created by Александр Трубкин on 24.08.2026.
//

import Foundation


// Корзина
class Basket {
    
    // Товары в корзине
    var products: [ProductItem] = []
    
    /// Скидка 10%
    var totalSum: Double {
        var valueSum: Double = 0
        for product in products {
            if product.onSale == true {
                valueSum += product.priceProduct * 0.9
            } else {
                valueSum += product.priceProduct
            }
        }
        return valueSum
    }
    
    init(products: [ProductItem]) {
        self.products = products
    }
    
    /// Добавление товара в корзину
    func addProduct(product: ProductItem) {
        if let stock = product.itemsInStock {
            if stock > quantity(product: product) {
                products.append(product)
            } else {
                print("Товар: \(product.nameProduct)\n❌ Ошибка: товара нет в наличии.\n")
                return
            }
        }
    }
    
    /// Количество конкретного товара в корзине
    func quantity(product: ProductItem) -> Int {
        return products.filter { $0.idProduct == product.idProduct }.count
    }
    
    /// Печать корзины с проверкой остатков
    func printBasketStockStatus() {
        var uniqueProducts: [ProductItem] = []
        
        for product in products {
            if !uniqueProducts.contains(product) {
                uniqueProducts.append(product)
            }
        }
        
        for product in uniqueProducts {
            if let stock = product.itemsInStock {
                if stock >= quantity(product: product) {
                    print("Товар: \(product.nameProduct) x\(quantity(product: product))\n✅ Добавлен.\n")
                } else {
                    print("Товар: \(product.nameProduct) x\(quantity(product: product))")
                    print("❌ Ошибка: товара недостаточно")
                    print("На складе: \(stock)\n")
                }
            }
        }
    }
    
    ///Печать итогового состава корзины
    func printBasketSummary() {
        print("=== КОРЗИНА ===\n")
        
        var uniqueProducts: [ProductItem] = []
        
        for product in products {
            if !uniqueProducts.contains(product) {
                uniqueProducts.append(product)
            }
        }
        
        for product in uniqueProducts {
            let quantity = quantity(product: product)
            if product.onSale == true {
                let discountedProduct = product.priceProduct * 0.9
                print("\(product.nameProduct) x\(quantity) — \(Int(discountedProduct * Double(quantity))) ₽")
            } else {
                let notDiscountedProduct = product.priceProduct
                print("\(product.nameProduct) x\(quantity) — \(Int(notDiscountedProduct * Double(quantity))) ₽")
            }
        }
        
        print("Всего позиций: \(products.count)")
    }
    
    ///Печать только название товаров и их общей стоимости для блока пользователя
    func printOnlyItem() -> String {
        var uniqueProducts: [ProductItem] = []
        var isNameProduct = " "
        
        for product in products {
            if !uniqueProducts.contains(product) {
                uniqueProducts.append(product)
            }
        }
        for product in uniqueProducts {
            isNameProduct += product.nameProduct + ", "
        }
        return isNameProduct
    }
    
    /// Применение промокода
    func applyDiscount(price: Double, promocode: PromoCode) -> (Double, String) {
        return promocode.applyPromo(promo: price)
    }
    
    ///Сумма корзины без скидок
    func sumBasketNotDiscont() -> Double {
        var sumBasketItemsNotDiscont = 0.0
        for product in products {
            sumBasketItemsNotDiscont += product.priceProduct
        }
        return sumBasketItemsNotDiscont
    }
    
    
    //Собираем массив уникальных товаров, чтобы товары не дублировались в выдаче, но правильно считалось количество
    func uniqueProducts() -> [ProductItem] {
        
        var uniqueProducts: [ProductItem] = []
        for product in products {
            if !uniqueProducts.contains(product) {
                uniqueProducts.append(product)
            }
        }
        return uniqueProducts
    }
    
    ///Считаем каждый товар
    func calculateItemDetails(product: ProductItem) -> (fullPrice: Double, salePrice: Double, discount: Double) {
        let quantity = quantity(product: product)
        var fullPrice = 0.0
        var salePrice = 0.0
        
        if product.onSale {
            salePrice = (product.priceProduct * 0.9) * Double(quantity)
            fullPrice = product.priceProduct * Double(quantity)
        } else {
            fullPrice = product.priceProduct * Double(quantity)
            salePrice = fullPrice
        }
        
        return (fullPrice, salePrice, fullPrice - salePrice)
    }
    
    // Считаем всю корзину
    func calculateBasket() -> (Double, Double) {
        
        var totalSumWithSale = 0.0
        var totalFullPrice = 0.0
        
        for product in uniqueProducts() {
            let details = calculateItemDetails(product: product)
            
            totalSumWithSale += details.salePrice
            totalFullPrice += details.fullPrice
        }
        
        return (totalSumWithSale, totalFullPrice)
    }
    
    ///Печать итогового состава корзины
    func printBasketOnSale(promo: PromoCode) -> (Int, PromoCode) {
        //Получаем общие суммы
        let (totalSumWithSale, totalFullPrice) = calculateBasket()
        
        for product in uniqueProducts() {
            //Получаем детальные суммы
            let details = calculateItemDetails(product: product)
            print("\(product.nameProduct) x\(quantity(product: product))")
            print("Стоимость: \(Int(details.fullPrice)) ₽")
            print("Скидка на товар: \(Int(details.discount)) ₽\n")
        }
        
        //Стоимость со скидкой 10% + промокод
        let sale10AndPromo = applyDiscount(price: totalSumWithSale, promocode: promo)
        
        print("Примокод: \(sale10AndPromo.1)")
        print("Скидка по промокоду: \(Int(totalSumWithSale - sale10AndPromo.0)) ₽\n")
        
        print("Итого к оплате: \(Int(sale10AndPromo.0)) ₽\n")
        
        return (Int(sale10AndPromo.0), promo)
        
    }
    
    ///Проверка возраста и суммы покупки
    func moneyAndAge(user: User, promo: PromoCode) {
        
        if user.userBasket.totalSum >= 100000 && user.userAge < 18 {
            print("❌ Покупка запрещена.\nПользователь младше 18 лет, не может совершать покупки дороже 100000 ₽")
            return
        }
        chekout(user: user, promo: promo)
    }
    
    ///Чекаут негативных кейсов перед покупкой
    func chekout(user: User, promo: PromoCode) {
        
        // Проверка корзины на пустоту
        guard !products.isEmpty else {
            print("❌ Корзина пуста.")
            return
        }
        
        // Проверка наличия товара на складе
        for items in products {
            guard let stock = items.itemsInStock,
                  stock > 0 else {
                print("❌ Нет товара \(items.nameProduct) на складе")
                return
            }
        }
        processOrder(user: user, promo: promo)
    }
    
    
    ///Оформляем заказ и чек
    func processOrder(user: User, promo: PromoCode){
        //Собираем детальную история заказа
        var orderItems: [OrderItem] = []
        //Собираем история заказа
        //        var orderHistory: [OrderHistory] = []
        print("=== ОФОРМЛЕНИЕ ЗАКАЗА ===\n")
        user.printUserInfo()
        print("\n=== ЧЕК ===\n")
        // Вывод товаров
        for product in uniqueProducts() {
            let quantity = quantity(product: product)
            let details = calculateItemDetails(product: product)
            
            //Создаем OrderItems
            let item = OrderItem (
                nameItem: product.nameProduct,
                priceOnSale: product.onSale,
                count: quantity,
                priceProduct: product.priceProduct
            )
            orderItems.append(item)
            
            // Формат: Название xКоличество — Цена
            print("\(product.nameProduct) x\(quantity) — \(Int(details.salePrice)) ₽")
        }
        
        //Общие суммы
        let (totalSumWithSale, totalFullPrice) = calculateBasket()
        
        //рименяем промокод
        let sale10AndPromo = applyDiscount(price: totalSumWithSale, promocode: promo)
        let finalPrice = sale10AndPromo.0
        let totalDiscount = totalFullPrice - finalPrice
        
        //Создаем OrderHistory
        let valueHistory = OrderHistory (
            user: user.userName,
            userCartItem: orderItems,
            itemCount: orderItems.count,
            priceNotDiscount: totalFullPrice,
            valueSale: totalDiscount,
            finalPriceOrder: finalPrice,
            numberOrder: user.userOrderHistory.count + 1
        )
        user.userOrderHistory.append(valueHistory)
        
        print("\nСтоимость товаров: \(Int(totalFullPrice)) ₽")
        print("Скидка: \(Int(totalDiscount)) ₽")
        print("\nИтого: \(Int(finalPrice)) ₽")
        print("\n✅ Заказ успешно оформлен\n")
        
        
        //Вычитаем со склада и с баланса
        for product in user.userBasket.uniqueProducts() {
            let quantity = user.userBasket.quantity(product: product)
            
            if let currentStock = product.itemsInStock {
                product.itemsInStock = currentStock - quantity
            }
            
        }
        
        let balanceBefore = Int(user.moneyCount.balance)
        user.moneyCount.balance -= finalPrice
        let balanceAfter = Int(user.moneyCount.balance)
        print("Баланc до покупки: \(Int(balanceBefore)) ₽\nБаланс после покупки: \(balanceAfter)")
        
        //Обновляем статус склада
        myCatalog.printStockStatus()
        
        //Очищаем корзину
        user.userBasket.products.removeAll()
        
        //Проверяем очистку
        if user.userBasket.products.isEmpty {
            print("\n✅ Корзина успешно очищена\n =================================\n")
        }
        
        user.printUserHistory()
        
    }
}
