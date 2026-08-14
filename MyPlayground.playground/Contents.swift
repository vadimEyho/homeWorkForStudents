//Разделы каталога
enum Categories: String {
    case Electronics = "Электроника"
    case Clothing = "Одежда"
    case Books = "Книги"
    case HomeAndKitchen = "Дом и кухня"
    case SportsAndOutdoors = "Спорт и отдых"
    case ToysAndGames = "Игрушки и игры"
}

//Свойства товара
struct productCatalog {
    let idProduct: Int
    let nameProduct: String
    var priceProduct: Int
    var categoriesProduct: Categories
    var itemsInStock: Int?
    var onSale: Bool
}

let product1 = productCatalog(idProduct: 1, nameProduct: "iPhone 17", priceProduct: 75376, categoriesProduct: .Electronics, itemsInStock: 10, onSale: true)
let product2 = productCatalog(idProduct: 2, nameProduct: "Куртка Columbia", priceProduct: 8897, categoriesProduct: .Clothing, itemsInStock: 50, onSale: false)
let product3 = productCatalog(idProduct: 3, nameProduct: "Кулинарная книга", priceProduct: 550, categoriesProduct: .Books, itemsInStock: 1000, onSale: true)
let product4 = productCatalog(idProduct: 4, nameProduct: "Рецепты", priceProduct: 250, categoriesProduct: .Books, itemsInStock: 1000, onSale: true)
let product5 = productCatalog(idProduct: 5, nameProduct: "Кофеварка Tuvio", priceProduct: 15678, categoriesProduct: .HomeAndKitchen, itemsInStock: 279, onSale: false)
let product6 = productCatalog(idProduct: 6, nameProduct: "Палатка", priceProduct: 2389, categoriesProduct: .SportsAndOutdoors, itemsInStock: 2467, onSale: true)
let product7 = productCatalog(idProduct: 7, nameProduct: "Шахматы", priceProduct: 1234, categoriesProduct: .ToysAndGames, itemsInStock: nil, onSale: true)

let arrayProduct: [productCatalog] = [product1, product2, product3, product4, product5, product6, product7]


//Принимает статус в Bool и конвертирует в String
func transformSaleStatus(saleStatus: productCatalog) -> String {
    if saleStatus.onSale == true {
        return "Да"
    } else {
        return "Нет"
    }
}

//Выводит информацию о товарах (Каталог товаров)
func catalogItems(productInfo: [productCatalog]) {
    print("=== КАТАЛОГ === \n")
    for productInfo in productInfo {
        let boolInText = transformSaleStatus(saleStatus: productInfo)
        let inStock = productInfo.itemsInStock ?? 0
        
        print("\(productInfo.nameProduct) - \(productInfo.priceProduct) ₽\nКатегория: \(productInfo.categoriesProduct.rawValue)\nНа складе: \(inStock)\nСкидка: \(boolInText)\n ")
    }
}
catalogItems(productInfo: arrayProduct)


//Ввод через свойство Enum, раздела из которого нужно отобразить товары
let categoriesName: Categories = .Books

//Поиск товаров по переданной категории из categoriesName
func findCategoriesItem(productInfo: [productCatalog]) {
    print("=== \(categoriesName.rawValue) === \n")
    var items = ""
    
    
    for productInfo in productInfo {
        if productInfo.categoriesProduct.rawValue == categoriesName.rawValue {
            items += productInfo.nameProduct + "\n"
        }
    }
    print(items)
}
findCategoriesItem(productInfo: arrayProduct)

//Задаем значение для фильтра по стоимости
let valueOverPrice = 10000

//Фильтр по стоимости
func findOverpriceItem(productInfo: [productCatalog]){
    print("=== ТОВАРЫ ДОРОЖЕ 10000 ₽ === \n")
    var items = ""
    for productInfo in productInfo {
        if productInfo.priceProduct >= valueOverPrice {
            items += "\(productInfo.nameProduct) - \(productInfo.priceProduct) ₽\n"
        }
    }
    print(items)
}
findOverpriceItem(productInfo: arrayProduct)

