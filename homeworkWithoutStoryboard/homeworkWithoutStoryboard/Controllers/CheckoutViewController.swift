import UIKit
import SnapKit

final class CheckoutViewController: UIViewController {

    private let cart: Cart

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Итоговый чек"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tableView: UITableView = {
        let table = UITableView()
        //  регистрируем таблицу, без этого не работает
        table.register(UITableViewCell.self, forCellReuseIdentifier: "ReceiptCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private let totalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Подтвердить оплату", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    init(cart: Cart) {
        self.cart = cart
        super.init(nibName: nil, bundle: nil)
    }

    //  обязательно нужен
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Оформление"

        setupUI()
        tableView.dataSource = self
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        updateUI()
    }


    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(totalLabel)
        view.addSubview(balanceLabel)
        view.addSubview(statusLabel)
        view.addSubview(confirmButton)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            //  выше total
            make.bottom.equalTo(totalLabel.snp.top).offset(-12)
        }

        totalLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(balanceLabel.snp.top).offset(-8)
        }

        balanceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(statusLabel.snp.top).offset(-8)
        }

        statusLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(confirmButton.snp.top).offset(-12)
        }

        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }

    private func updateUI() {
        let total = cart.discountedTotalCost()
        let balance = currentUser?.balance ?? 0

        totalLabel.text = "Итого к оплате: \(Int(total)) ₽"
        balanceLabel.text = "Ваш баланс: \(Int(balance)) ₽"

        if balance >= total {
            statusLabel.text = "Средств достаточно"
            statusLabel.textColor = .systemGreen
            confirmButton.isEnabled = true
            confirmButton.backgroundColor = .systemGreen
        } else {
            let missing = total - balance
            statusLabel.text = "Не хватает \(Int(missing)) ₽"
            statusLabel.textColor = .systemRed
            confirmButton.isEnabled = false
            confirmButton.backgroundColor = .systemGray
        }
    }

    @objc private func confirmTapped() {
        //  проверяем наличие пользователя
        guard let user = currentUser else {
            showAlert(title: "Ошибка", message: "Пользователь не авторизован")
            return
        }

        let total = cart.discountedTotalCost()

        //  проверяем баланс
        guard user.balance >= total else {
            showAlert(title: "Ошибка", message: "Недостаточно средств")
            return
        }

        //  списываем средства
        user.balance -= total

        //  очищаем корзину после успешной оплаты
        for item in cart.getAllItems() {
            _ = cart.removeItem(name: item.product.name, count: item.count)
        }

        let alert = UIAlertController(
            title: "Оплачено",
            message: "Заказ на сумму \(Int(total)) ₽ успешно оформлен.\nОстаток: \(Int(user.balance)) ₽",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            //  закрывает все экраны поверх главного
            self?.navigationController?.popToRootViewController(animated: true)
        })
        present(alert, animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension CheckoutViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ReceiptCell")

        guard let item = cart.getItem(at: indexPath.row) else {
            cell.textLabel?.text = "—"
            return cell
        }

        cell.textLabel?.text = "\(item.product.name) x\(item.count)"

        if item.product.discount {
            cell.detailTextLabel?.text =
                "\(Int(item.discountedPrice)) ₽ (было \(Int(item.totalPrice)) ₽)"
            cell.detailTextLabel?.textColor = .systemRed
        } else {
            cell.detailTextLabel?.text = "\(Int(item.totalPrice)) ₽"
            cell.detailTextLabel?.textColor = .systemGreen
        }

        cell.selectionStyle = .none
        return cell
    }
}
