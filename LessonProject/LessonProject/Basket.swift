//
//  Basket.swift
//  LessonProject
//
//  Created by Александр Трубкин on 24.08.2026.
//

import Foundation

// TODO: Поменять логику на свитч через енам

//enum PromoCode: String {
//    case swift10 = ""
//    case student10 = ""
//    case sale500 = "SALE500"
//
//    func validPromo(promo: String ) -> String {
//
//    }
//}


enum TypeSale {
    case percent(Double)
    case sum(Double)
}

struct

// Корзина
class Basket {

   private var promocode = ["SWIFT10","STUDENT","SALE500"]

    // Товары в корзине
    var products: [ProductItem] = []


    /// Посмотри что можно еще вынести в переменную
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

    // Добавление товара в корзину
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
        products.filter { $0.idProduct == product.idProduct }.count
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

    ///Печать итогового состава корзины cо скидкой
    func printBasketOnSale() -> Int {
        print("=== РАСЧЁТ КОРЗИНЫ ===\n")

        // Уникальные?
        var uniqueProducts: [ProductItem] = []

        var fullPriceBasketNotSale = 0.0
        var totalFullSalePrice = 0.0
        var totalDiscountSum = 0.0

        for product in products {
            if !uniqueProducts.contains(product) {
                uniqueProducts.append(product)
            }
            fullPriceBasketNotSale += product.priceProduct
        }

        for product in uniqueProducts {
            let quantity = quantity(product: product)
            if product.onSale == true {
                // Делаем скидку 10%
                let discountedProduct = product.priceProduct * 0.9
                // Считаем размер получившейся скидки
                let sumSale = product.priceProduct - discountedProduct
                // Добавляем значения во внешние переменные для print
                totalFullSalePrice += discountedProduct * Double(quantity)
                totalDiscountSum += sumSale * Double(quantity)

                print("\(product.nameProduct) x\(quantity)\nСтоимость: \(Int(discountedProduct * Double(quantity))) ₽\nТовар учавствует в акции, применена скидка 10%: \(Int(sumSale)) ₽\n")
            } else {
                let notDiscountedProduct = product.priceProduct
                print("\(product.nameProduct) x\(quantity)\nСтоимость: \(Int(notDiscountedProduct * Double(quantity))) ₽\nСкидка на товар: 0 ₽\n")
            }
        }
        print("Общая стоимость без скидок: \(Int(fullPriceBasketNotSale))")
        print("Общая стоимость со скидками: \(Int(totalFullSalePrice))")
        print("Общая скидка: \(Int(totalDiscountSum))\n")
        return Int(totalDiscountSum)
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

    func sumBasketNotSaleAndDiscont() -> Int {
        var isSumBasketNotSaleAndDiscount: [ProductItem] = []
        var isSumBasket = 0.0

        for product in products {
            if !isSumBasketNotSaleAndDiscount.contains(product) {
                isSumBasketNotSaleAndDiscount.append(product)
            }
        }
        for product in isSumBasketNotSaleAndDiscount {
            isSumBasket += product.priceProduct
        }
        return Int(isSumBasket)
    }

    ///Варианты промкодов
    func promocodes(promocode: String) -> TypeSale {
        let promocodeUppercase = promocode.uppercased()
        switch promocodeUppercase {
        case "SWIFT10":
            return .percent(0.9)
        case "STUDENT":
            return .percent(0.95)
        case "SALE500":
            return .sum(500)
        default:
            print("Такого промокода не существует или он истек")
            return .percent(0.0)
        }
    }

    /// Применение промокодов
    func applyDiscount(currentPrice: Double, promocode: TypeSale) -> Double {
        switch promocode {
        case let .percent(value):
            return currentPrice * value
        case .sum(let value):
            return currentPrice - value
        }
    }

    /// Почистить разобраться!
    /// Расчет финальной цены скидка 10% (где можно) + промокод и вывод
    func calculatePriceFinal(promo: String) {
//        let promoUser = promocodes(promocode: promo)
//        let currentPrice = calculateTotal()
//        let finalPrice = applyDiscount(currentPrice: currentPrice, promocode: promoUser)
        let printBasketOnSale = printBasketOnSale()
        if promo != "" {
            print("Промокод: \(promo)")
            print("Скидка по промокоду: \(printBasketOnSale) ₽\n")
        } else {
            print("Промокод: - \n")
        }
    }

    ///Печать чека
    func printCheckUser() -> Int {
        print("=== ЧЕК ===\n")
        var uniqueProducts: [ProductItem] = []
        var fullPriceBasketNotSale = 0.0
        //            var totalFullSalePrice = 0.0
        var totalDiscountSum = 0.0
        var sumBasket = 0.0

        for product in products {
            if !uniqueProducts.contains(product) {
                uniqueProducts.append(product)
            }
            fullPriceBasketNotSale += product.priceProduct
        }

        for product in uniqueProducts {
            let quantity = quantity(product: product)
            if product.onSale == true {
                // Делаем скидку 10%
                let discountedProduct = product.priceProduct * 0.9
                // Считаем размер получившейся скидки
                let sumSale = product.priceProduct - discountedProduct
                // Добавляем значения во внешние переменные для print
                sumBasket += discountedProduct * Double(quantity)
                totalDiscountSum += sumSale * Double(quantity)

                print("\(product.nameProduct) x\(quantity) - \(Int(discountedProduct * Double(quantity))) ₽")
            } else {
                let notDiscountedProduct = product.priceProduct
                sumBasket += product.priceProduct * Double(quantity)
                print("\(product.nameProduct) x\(quantity) - \(Int(notDiscountedProduct * Double(quantity))) ₽\n")
            }
        }
        print("Стоимость товаров: \(Int(fullPriceBasketNotSale))")
        print("Скидка: \(Int(totalDiscountSum))\n")
        print("Итого: \(Int(sumBasket))\n")
        return Int(sumBasket)
    }
}
