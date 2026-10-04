import UIKit
import SnapKit

//  тк JSON не в основном потоке, а WeatherResponse "привязан" к главному
//  имена должны полностью соответствовать тем, что в JSON
nonisolated struct WeatherResponse: Decodable {
    let location: Location
    let current: Current

    struct Location: Decodable {
        let name: String
        let localtime: String
    }

    struct Current: Decodable {
        let temp_c: Double
        let condition: Condition

        struct Condition: Decodable {
            let text: String
        }
    }
}

class WeatherViewController: UIViewController {

    // MARK: Данные
    private let countries: [String: [String]] = [
        "Armenia":       ["Yerevan", "Gyumri", "Vanadzor", "Vagharshapat", "Abovyan"],
        "Russia":        ["Moscow", "Saint Petersburg", "Novosibirsk", "Yekaterinburg", "Kazan"],
        "Belarus":       ["Minsk", "Gomel", "Brest", "Vitebsk", "Grodno"],
        "Kazakhstan":    ["Almaty", "Astana", "Shymkent", "Karaganda"],
        "USA":           ["New York", "Los Angeles", "Chicago", "Houston", "Miami"],
        "United Kingdom": ["London", "Manchester", "Liverpool", "Edinburgh"],
        "Germany":       ["Berlin", "Munich", "Hamburg", "Frankfurt"],
        "France":        ["Paris", "Marseille", "Lyon", "Toulouse"],
        "Turkey":        ["Istanbul", "Ankara", "Izmir", "Antalya"],
        "China":         ["Beijing", "Shanghai", "Guangzhou", "Shenzhen"],
        "Japan":         ["Tokyo", "Osaka", "Kyoto", "Sapporo"]
    ]

    // MARK: Структуры для заполнения
    private var countryNames: [String] = []
    private var cities: [String] = []
    private var selectedCountry: String = ""
    private var selectedCity: String = ""

    // MARK: UI элементы
    private let countryButton = UIButton(type: .system)
    private let cityButton = UIButton(type: .system)
    private let loadButton = UIButton(type: .system)
    private let tempLabel = UILabel()
    private let conditionLabel = UILabel()
    private let timeLabel = UILabel()

    //  API ключ
    private let apiKey = "d2d282b7daac406e962163332260410"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        countryNames = countries.keys.sorted()
        //  заполняем данными
        if let first = countryNames.first {
            selectedCountry = first
            // если городов нет, то возвращем пустой список
            cities = countries[first] ?? []
            
            // если городов нет, то оставляем пустоту
            selectedCity = cities.first ?? ""
        }

        setupUI()
        updateCountryMenu()
        updateCityMenu()
    }

    private func setupUI() {
        // выпадающий список стран
        makeDropdownButton(countryButton, title: "Страна: \(selectedCountry)")
        view.addSubview(countryButton)

        // выпадающий список городов
        makeDropdownButton(cityButton, title: "Город: \(selectedCity)")
        view.addSubview(cityButton)

        // Кнопка "Узнать погоду"
        makeLoadButton(loadButton)
        view.addSubview(loadButton)

        // Температура
        tempLabel.font = .systemFont(ofSize: 60, weight: .thin)
        tempLabel.textAlignment = .center
        tempLabel.text = "--"
        view.addSubview(tempLabel)

        // Описание
        conditionLabel.font = .systemFont(ofSize: 18)
        conditionLabel.textColor = .secondaryLabel
        conditionLabel.textAlignment = .center
        conditionLabel.text = "Выберите страну и город"
        conditionLabel.numberOfLines = 0
        view.addSubview(conditionLabel)

        // Время
        timeLabel.font = .systemFont(ofSize: 16)
        timeLabel.textColor = .secondaryLabel
        timeLabel.textAlignment = .center
        timeLabel.text = "Время: --:--"
        view.addSubview(timeLabel)

        // Констрейнты
        countryButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        cityButton.snp.makeConstraints { make in
            make.top.equalTo(countryButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        loadButton.snp.makeConstraints { make in
            make.top.equalTo(cityButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(loadButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        conditionLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(conditionLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    private func makeLoadButton(_ button: UIButton) {
        button.setTitle("Узнать погоду", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loadWeather), for: .touchUpInside)
    }
    
    // Фабрика выпадающих списков
    private func makeDropdownButton(_ button: UIButton, title: String) {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = .secondarySystemBackground
        config.baseForegroundColor = .label
        config.cornerStyle = .medium

        config.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,     // отступ слева, чтобы слова не прилипали к левому краю
            bottom: 0,
            trailing: 16
        )
        
        button.configuration = config
        button.contentHorizontalAlignment = .leading
        button.showsMenuAsPrimaryAction = true
    }

    // меню стран
    private func updateCountryMenu() {
        let actions = countryNames.map { name in
            UIAction(title: name, state: name == selectedCountry ? .on : .off) { [weak self] _ in
                guard let self = self else { return }
                self.selectedCountry = name
                self.cities = self.countries[name] ?? []
                self.selectedCity = self.cities.first ?? ""
                self.countryButton.setTitle("Страна: \(name)", for: .normal)
                self.updateCountryMenu()
                self.updateCityMenu()
            }
        }
        countryButton.menu = UIMenu(title: "Выберите страну", children: actions)
    }

    // Меню городов
    private func updateCityMenu() {
        cityButton.setTitle("Город: \(selectedCity)", for: .normal)

        let actions = cities.map { name in
            UIAction(title: name, state: name == selectedCity ? .on : .off) { [weak self] _ in
                guard let self = self else { return }
                self.selectedCity = name
                self.cityButton.setTitle("Город: \(name)", for: .normal)
                self.updateCityMenu()
            }
        }
        cityButton.menu = UIMenu(title: "Выберите город", children: actions)
    }

    // Запрос на получение погоды
    @objc private func loadWeather() {
        // проверяем есть ли выбранный город
        guard !selectedCity.isEmpty else { return }

        loadButton.isEnabled = false
        loadButton.setTitle("Загрузка...", for: .normal)
        conditionLabel.text = "Загрузка..."

        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(selectedCity)&lang=ru"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString) else { return }

        //  Лог запроса в консоль
        print("-> ЗАПРОС:")
        print("URL: \(url.absoluteString)") //  вся ссылка
        print("Город: \(selectedCity)")
        print("─────────────")

        URLSession.shared.dataTask(with: url) { data, response, error in
            // Лог ошибки сети
            if let error = error {
                print("ОШИБКА СЕТИ: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.conditionLabel.text = "Ошибка сети"
                    self.loadButton.isEnabled = true
                    self.loadButton.setTitle("Узнать погоду", for: .normal)
                }
                return
            }

            // Лог HTTP-статуса
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP статус: \(httpResponse.statusCode)")
            }

            // Лог JSON
            if let data = data,
               let jsonString = String(data: data, encoding: .utf8) {
                print("<- ОТВЕТ JSON:")
                print(jsonString)
                print("─────────────")
            }

            // Парсим
            guard let data = data else {
                print("ОШИБКА: Нет данных")
                //  тк UI обновляется только в главном потоке
                DispatchQueue.main.async {
                    self.conditionLabel.text = "Ошибка, нет данных"
                    self.loadButton.isEnabled = true
                    self.loadButton.setTitle("Узнать погоду", for: .normal)
                }
                return
            }

            do {
                let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)

                let name = weather.location.name
                let temp = weather.current.temp_c
                let text = weather.current.condition.text
                let localtime = weather.location.localtime
                let time = String(localtime.split(separator: " ").last ?? "")

                // Лог распарсенных данных
                print("РЕЗУЛЬТАТ:")
                print("Город: \(name)")
                print("Температура: \(temp)°C")
                print("Погода: \(text)")
                print("Время: \(time)")
                print("─────────────")
                
                //  тк UI обновляется только в главном потоке
                DispatchQueue.main.async {
                    self.tempLabel.text = String(format: "%.1f°C", temp)
                    self.conditionLabel.text = "\(name): \(text)"
                    self.timeLabel.text = "Время: \(time)"
                    self.loadButton.isEnabled = true
                    self.loadButton.setTitle("Узнать погоду", for: .normal)
                }

            } catch {
                print("Ошибка декодирования: \(error)")
                //  тк UI обновляется только в главном потоке
                DispatchQueue.main.async {
                    self.conditionLabel.text = "Ошибка декодирования"
                    self.loadButton.isEnabled = true
                    self.loadButton.setTitle("Узнать погоду", for: .normal)
                }
            }
        }.resume()  //  resume отправляет сам запрос
    }
}
