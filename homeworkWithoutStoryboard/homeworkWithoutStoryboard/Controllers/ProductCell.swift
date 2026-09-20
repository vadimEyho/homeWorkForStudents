import UIKit

class ProductCell: UITableViewCell {

    // по этому имени таблица будет доставать ячейку из очереди
    static let reuseIdentifier = "ProductCell"

    // делегат — сюда будем отправлять нажатия кнопок
    weak var delegate: ProductCellDelegate?

    // название товара
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // цена товара
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // кнопка "минус"
    private let removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("−", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // кнопка "плюс"
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // счётчик количества
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // контейнер для кнопок и счётчика
    private lazy var counterView = CounterView(
        removeButton: removeButton,
        countLabel: countLabel,
        addButton: addButton
    )

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // расставляем всё внутри ячейки
    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(counterView)

        NSLayoutConstraint.activate([
            // название сверху слева
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: counterView.leadingAnchor, constant: -10),

            // цена под названием
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: counterView.leadingAnchor, constant: -10),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            // счётчик справа по центру
            counterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            counterView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    // подписываемся на нажатия кнопок
    private func setupActions() {
        removeButton.addTarget(self, action: #selector(removeTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }

    // заполняем ячейку данными
    func configure(with product: Product, count: Int) {
        nameLabel.text = product.name
        priceLabel.text = "\(product.price) ₽"
        counterView.setCount(count)
    }

    // нажали "+"
    @objc private func addTapped() {
        // отправляем информацию о том, что кнопка нажалась
        delegate?.productCellDidTapAdd(self)
    }

    // нажали "−"
    @objc private func removeTapped() {
        // отправляем информацию о том, что кнопка нажалась
        delegate?.productCellDidTapRemove(self)
    }
}
