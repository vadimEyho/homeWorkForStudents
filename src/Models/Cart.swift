//
//  ShoppingCart.swift
//  elizaveta-sidorenkova
//
//  Created by Lizaveta on 14.08.2026.
//

public enum PromoCode: String {
    case swift10 = "SWIFT10"
    case student = "STUDENT"
    case sale500 = "SALE500"
    case family = "FAMILY"
    
    func applyDiscount(amount: Double) -> Double {
        switch self {
        case .swift10:
            return amount * 0.9
        case .student:
            return amount * 0.95
        case .sale500:
            return max(0, amount - 500)
        case .family:
            return max(0, amount - 1000)
        }
    }
}
public class CartItem {
    var product: Product
    var count: Int
    
    init(product: Product, count: Int) {
        self.product = product
        self.count = count
    }
    
    var totalPrice: Double {
        return product.price * Double(count)
    }
    
    var discountedPrice: Double {
        if product.discount {
            return totalPrice * 0.9
        } else {
            return totalPrice
        }
    }
    
    var discountAmount: Double {
        return totalPrice - discountedPrice
    }
    
    func printInfo() {
        print("\(product.name) x\(count) — \(Int(product.price * Double(count))) ₽")
    }
}

public class Cart {
    private var items: [CartItem] = []
    private var catalog: Catalog
    
    init(items: [CartItem], catalog: Catalog) {
        self.items = items
        self.catalog = catalog
    }
    
    init() {
        self.items = []
        self.catalog = Catalog()
    }
    
    func productExists(productId: Int) -> Bool {
        return catalog.getProductById(productId) != nil
    }
    
    func checkCount(productId: Int, count: Int) -> (isAvailable: Bool, availableCount: Int) {
        guard let product = catalog.getProductById(productId) else {
            return (false, 0)
        }
        return (product.count >= count, product.count)
    }
    
    func addItemCart(productId: Int, count: Int) -> Bool {
        guard count > 0 else {
            print("❌ Ошибка: количество должно быть больше нуля.")
            return false
        }
        
        guard let product = catalog.getProductById(productId) else {
            print("Товар с ID \(productId) не найден")
            return false
        }

        guard product.count > 0 else {
            print("❌ Ошибка: товара нет в наличии.")
            return false
        }
        
        let check = checkCount(productId: productId, count: count)
        guard check.isAvailable else {
            print("❌ Ошибка: недостаточно товара.")
            return false
        }
        
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            //  товар уже существует в корзине, увеличиваем количество
            items[index].count += count
        } else {
            let item = CartItem(product: product, count: count)
            items.append(item)
        }
        print("✅ Товар добавлен.")
        return true
    }
    
    func addItemCart(name: String, count: Int) -> Bool {
        print("Добавляем товар \(name) x\(count)")
        
        guard count > 0 else {
            print("❌ Ошибка: количество должно быть больше нуля.\n")
            return false
        }
        
        guard let product = catalog.getProductByName(name) else {
            print("❌ Ошибка: Товар с именем \(name) не найден.\n")
            return false
        }

        guard product.count > 0 else {
            print("❌ Ошибка: товара нет в наличии.\n")
            return false
        }
        
        let check = checkCount(productId: product.id, count: count)
        guard check.isAvailable else {
            print("❌ Ошибка: недостаточно товара.")
            print("На складе: \(check.availableCount)\n")
            return false
        }
        
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            //  товар уже существует в корзине, увеличиваем количество
            items[index].count += count
        } else {
            let item = CartItem(product: product, count: count)
            items.append(item)
        }
        print("✅ Товар добавлен.\n")
        return true
    }
    
    // стоимость товаров без скидок
    func totalCostWithoutDiscount() -> Double {
        var totalCost: Double = 0
        
        for item in items {
            totalCost = totalCost + item.totalPrice
        }
        
        return totalCost
    }

    // стоимость товаров со скидкой на товар
    func discountedTotalCost() -> Double {
        var totalCost: Double = 0
        
        for item in items {
            totalCost = totalCost + item.discountedPrice
        }
        
        return totalCost
    }

    // сумма скидок на товары
    func totalDiscountAmount() -> Double {
        var totalDiscount: Double = 0
        
        for item in items {
            totalDiscount = totalDiscount + item.discountAmount
        }
        
        return totalDiscount
    }
    
    // применить промокод
    func applyPromoCode(_ promo: String) -> Double {
        guard let promoCode = PromoCode(rawValue: promo.uppercased()) else {
            print("Неизвестная промо-акция")
            return discountedTotalCost()
        }
        
        let currentTotal = discountedTotalCost()
        let discountedTotal = promoCode.applyDiscount(amount: currentTotal)
        let discountAmount = currentTotal - discountedTotal
        
        print("Промокод: \(promoCode.rawValue)")
        print("Скидка по промокоду: \(Int(discountAmount)) ₽")
        
        return discountedTotal
    }

    func printInfo() {
        print("\n=== РАСЧЁТ КОРЗИНЫ ===\n")
        
        for item in items {
            item.printInfo()
            print()
        }
        print("\nВсего позиций: \(items.count)")
        print("Стоимость без скидок: \(Int(totalCostWithoutDiscount())) ₽")
        print("Скидка на товары: \(Int(totalDiscountAmount())) ₽")
        print()
    }
    
    func printWithPromo(_ promo: String) {
        printInfo()
        
        let finalPrice = applyPromoCode(promo)
        print("Итого к оплате: \(Int(finalPrice)) ₽")
        print()
    }
    
    // получение списка запрещенных товаров
    func getForbiddenProducts() -> [Product] {
        var forbiddenItems: [Product] = []
        for item in items {
            if item.product.category == .electronics && item.product.price > 100000 {
                forbiddenItems.append(item.product)
            }
        }
        return forbiddenItems
    }
}
