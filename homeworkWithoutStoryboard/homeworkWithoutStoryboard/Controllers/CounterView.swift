import UIKit
import SnapKit
// counter
final class CounterView: UIView {
    private let removeButton: UIButton
    private let countLabel: UILabel
    private let addButton: UIButton
    
    init(removeButton: UIButton, countLabel: UILabel, addButton: UIButton) {
        self.removeButton = removeButton
        self.countLabel = countLabel
        self.addButton = addButton
        super.init(frame: .zero)
        //  тут, потому что у UIView нет veiwDidLoad
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [removeButton, countLabel, addButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setCount(_ count: Int) {
        countLabel.text = "\(count)"
    }
}
