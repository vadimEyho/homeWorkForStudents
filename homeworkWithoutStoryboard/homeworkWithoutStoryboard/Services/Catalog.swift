//
//  CatalogClass.swift
//  elizaveta-sidorenkova
//
//  Created by Lizaveta on 14.08.2026.
//

public class Catalog {
    private var products: [Product] = []
    
    init(products: [Product]) {
        self.products = products
    }
    
    init() {
        self.products = []
    }
    
    func addProduct(_ product: Product) {
        products.append(product)
    }
    
    func printAllProducts() {
        guard !products.isEmpty else {
            print("Каталог товаров пуст")
            return
        }
        
        print("\n=== КАТАЛОГ ===\n")
        for product in products {
            product.printFullInfo()
            print("\n") //  почему два переноса строки???
        }
    }
    
    func getProductsByCategory(_ category: Category) -> [Product] {
        var result: [Product] = []

        for product in products {
            if product.category == category {
                result.append(product)
            }
        }
        return result
    }
    
    func getProductsOverPrice(_ price: Double) -> [Product] {
        var result: [Product] = []
        
        for product in products {
            if product.price > price {
                result.append(product)
            }
        }
        return result
    }
    
    func getProductById(_ id: Int) -> Product? {
        for product in products {
            if product.id == id {
                return product
            }
        }
        return nil
    }
    
    func getProductByName(_ name: String) -> Product? {
        for product in products {
            if product.name == name {
                return product
            }
        }
        return nil
    }
    
    func getAllProducts() -> [Product]
    {
        return products
    }
    
}
