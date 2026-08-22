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
let item4: ProductItem = ProductItem(idProduct: 4, nameProduct: "Рецепты", priceProduct: 250, categoriesProduct: .Books, itemsInStock: 1000, onSale: true)
let item5: ProductItem = ProductItem(idProduct: 5, nameProduct: "Кофеварка Tuvio", priceProduct: 15678, categoriesProduct: .HomeAndKitchen, itemsInStock: 279, onSale: false)
let item6: ProductItem = ProductItem(idProduct: 6, nameProduct: "Палатка", priceProduct: 2389, categoriesProduct: .SportsAndOutdoors, itemsInStock: 2467, onSale: true)
let item7: ProductItem = ProductItem(idProduct: 7, nameProduct: "Шахматы", priceProduct: 1234, categoriesProduct: .ToysAndGames, itemsInStock: nil, onSale: true)

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
//printItems(items: listProducts)

///Вывод раздела и его товаров
func printTitleCatalogAndCategories(categories: Categories) {
    print("=== \(categories.rawValue) ===\n")
    for items in listProducts {
        if items.categoriesProduct == categories {
            print(items.nameProduct)
        }
    }
}
//printTitleCatalogAndCategories(categories: .Books)

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
//printProductOverprice(price: 10000, items: listProducts)

///Свойства пользователя
struct User {
    let userName: String
    let userAge: Int
    var moneyCount: Double
    var userBasket: Basket

    ///Вывод данных пользователя
    func printUserInfo() {
        print("=== ПОЛЬЗОВАТЕЛЬ ===\n")
        print("Имя: \(userName)\nВозраст: \(userAge)\nБаланс: \(moneyCount)\n")
    }
}

//Корзина
class Basket {
    //Товары в корзине
    var products: [ProductItem] = []

    init(products: [ProductItem]) {
        self.products = products
    }

    //Добавление товара в корзину
    func addProduct(product: ProductItem) {
        guard let stock = product.itemsInStock else {
            print("Товар: \(product.nameProduct)\n❌ Ошибка: товара нет в наличии.\n")
            return
        }
        products.append(product)
    }

    ///Количество конкретного товара в корзине
    func quantity(product: ProductItem) -> Int {
        products.filter { $0.idProduct == product.idProduct }.count
    }

    ///Печать корзины с проверкой остатков
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
            let price = product.priceProduct
            print("\(product.nameProduct) x\(quantity) — \(price) ₽\n")
        }

        print("Всего позиций: \(products.count)")
    }
}

///Пользователи
let user1: User = User(userName: "Alex", userAge: 33, moneyCount: 20000, userBasket: Basket(products: []))
let user2: User = User(userName: "Dima", userAge: 30, moneyCount: 10000, userBasket: Basket(products: []))

///Массив пользователей
var arrayUsers: [User] = [user1, user2]




///Вывод данных пользователя
user1.printUserInfo()
///Добавления товара в корзину определенному пользователю
user1.userBasket.addProduct(product: item1)
user1.userBasket.addProduct(product: item1)
user1.userBasket.addProduct(product: item2)
user1.userBasket.addProduct(product: item2)
user1.userBasket.addProduct(product: item3)
user1.userBasket.addProduct(product: item7)
user1.userBasket.printBasketStockStatus()
user1.userBasket.printBasketSummary()
