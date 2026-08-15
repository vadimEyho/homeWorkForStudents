//
//  ShoppingCart.swift
//  elizaveta-sidorenkova
//
//  Created by Lizaveta on 14.08.2026.
//

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
    
    func printInfo() {
        for item in items {
            item.printInfo()
        }
        print("\nВсего позиций: \(items.count)")
    }
}
