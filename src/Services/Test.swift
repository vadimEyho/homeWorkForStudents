//
//  Test.swift
//
//
//  Created by Lizaveta on 19.08.2026.
//

class Test {
    var catalog: Catalog?
    var user: User?
    
    func checkFirstFeat() -> Catalog {
        //  let, потому что ссылка на объект не меняется
        let catalog: Catalog = Catalog()
        catalog.addProduct(Product(id: 1, name: "MacBook Pro", price: 149900, category: .electronics, count: 3, discount: false))
        catalog.addProduct(Product(id: 2, name: "AirPods Pro", price: 24990, category: .electronics, count: 5, discount: true))
        catalog.addProduct(Product(id: 3, name: "Swift Programming", price: 2990, category: .books, count: 10, discount: true))
        catalog.addProduct(Product(id: 4, name: "Футболка", price: 1990, category: .clothes, count: 4, discount: false))
        catalog.addProduct(Product(id: 5, name: "Кофе", price: 890, category: .product, count: 8, discount: false))
        catalog.addProduct(Product(id: 6, name: "Клавиатура", price: 7990, category: .product, count: 0, discount: false))

        catalog.printAllProducts()
        print("\n=== ЭЛЕКТРОНИКА ===\n")
        for pr in catalog.getProductsByCategory(.electronics) {
            pr.printName()
        }

        print("\n=== ТОВАРЫ ДОРОЖЕ 10000 ₽ ===\n")
        for pr in catalog.getProductsOverPrice(10000) {
            pr.printInfo()
        }
        
        self.catalog = catalog
        return catalog
    }
    
    func checkSecondFeat(_ catalog: Catalog) {
        let cart: Cart = Cart(items: [], catalog: catalog)
        let user: User = User(name: "Александр", age: 17, balance: 200000, cart: cart)
        print("\n=== ДОБАВЛЕНИЕ ТОВАРОВ ===\n")
        //  чтобы не было предупреждения
        _ = user.cart.addItemCart(name: "MacBook Pro", count: 1)
        _ = user.cart.addItemCart(name: "Swift Programming", count: 2)
        _ = user.cart.addItemCart(name: "Клавиатура", count: 1)
        _ = user.cart.addItemCart(name: "Кофе", count: 20)
        _ = user.cart.addItemCart(name: "AirPods Pro", count: 0)

        user.cart.printInfo()
        
        self.user = user
    }
    
    func checkThirsFeat() {
        // Проверяем, что пользователь и корзина созданы
        guard let user = user else {
            return
        }
        
        printWithPromo(user: user, promo: "SWIFT10")
        printAgeCheck(user: user)
    }
        
    func printWithPromo(user: User, promo: String) {
        user.cart.printWithPromo(promo)
    }
    
    func printAgeCheck(user: User) {
        user.printAgeCheck()
    }
}

