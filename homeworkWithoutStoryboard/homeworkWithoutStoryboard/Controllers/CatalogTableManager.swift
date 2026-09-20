import UIKit

import Foundation

// только классы могут быть делегатами (поэтому AnyObject)
protocol ProductCellDelegate: AnyObject {
    func productCellDidTapAdd(_ cell: ProductCell)
    func productCellDidTapRemove(_ cell: ProductCell)
}

class CatalogTableManager: NSObject {

    // таблица
    weak var tableView: UITableView?

    // товары, сгруппированные по категориям
    private var groupedProducts: [String: [Product]] = [:]

    // названия категорий (заголовки секций)
    private var sectionTitles: [String] = []

    // пользователь нажимает "+" или "−"
    // это свойство-замыкание
    // void - ничего не возвращает
    var onAddProduct: ((Product) -> Void)?
    var onRemoveProduct: ((Product) -> Void)?

    // сюда контроллер положит функцию, которая скажет, сколько товара в корзине
    var countForProduct: ((Product) -> Int)?

    // вызывается из контроллера, чтобы передать товары менеджеру
    func configure(with products: [Product]) {
        groupProductsByCategory(products)
    }

    // группируем товары по категориям
    private func groupProductsByCategory(_ products: [Product]) {
        groupedProducts.removeAll()

        for product in products {
            let categoryName = getCategoryName(product.category)
            if groupedProducts[categoryName] == nil {
                groupedProducts[categoryName] = []
            }
            groupedProducts[categoryName]?.append(product)
        }

        sectionTitles = groupedProducts.keys.sorted()
    }

    private func getCategoryName(_ category: Category) -> String {
        switch category {
        case .electronics:
            return "Электроника"
        case .books:
            return "Книги"
        case .clothes:
            return "Одежда"
        case .product:
            return "Товары"
        }
    }

    // достаём товар по indexPath
    private func product(at indexPath: IndexPath) -> Product? {
        let categoryName = sectionTitles[indexPath.section]
        guard let productsInCategory = groupedProducts[categoryName] else {
            return nil
        }
        if indexPath.row >= productsInCategory.count {
            return nil
        }
        return productsInCategory[indexPath.row]
    }
}


extension CatalogTableManager: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categoryName = sectionTitles[section]
        return groupedProducts[categoryName]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // достаём нашу ячейку из очереди
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductCell.reuseIdentifier,
            for: indexPath
        ) as! ProductCell

        // узнаём товар для этой строки
        guard let product = product(at: indexPath) else {
            return cell
        }

        // сколько этого товара в корзине
        var count = 0
        if let countForProduct = countForProduct {
            count = countForProduct(product)
        }

        // настраиваем ячейку
        cell.configure(with: product, count: count)

        // говорим ячейке, что мы её делегат
        cell.delegate = self

        return cell
    }
}

extension CatalogTableManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}

extension CatalogTableManager: ProductCellDelegate {

    // нажали "+" в ячейке
    func productCellDidTapAdd(_ cell: ProductCell) {
        // проверяем наличие таблицы
        guard let tableView = tableView else { return }
        // проверяем что ячейка отображается
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        // проверяем что товар реально есть
        guard let product = product(at: indexPath) else { return }

        // вызываем слот
        onAddProduct?(product)
    }

    // нажали "−" в ячейке
    func productCellDidTapRemove(_ cell: ProductCell) {
        guard let tableView = tableView else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let product = product(at: indexPath) else { return }

        onRemoveProduct?(product)
    }
}
