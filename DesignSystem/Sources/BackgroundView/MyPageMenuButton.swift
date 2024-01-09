import UIKit

public class MyPageMenuButton: UIButton {
    public var text: String {
        get { textLabel.text ?? "" }
        set { textLabel.text = newValue }
    }    
    private let textLabel: UILabel = {
        $0.textColor = .color(.dittoLettoColor(.dark))
        $0.font = .ramche(.body)
        return $0
    }(UILabel())
    private let cursorImageView: UIImageView = {
        $0.image = .Image.cursor
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    public init() {
        super.init(frame: .zero)
        self.backgroundColor = .color(.dittoLettoColor(.gray1))
        self.addView()
        self.setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setBackgroundColor(.color(.dittoLettoColor(.gray2)), for: .highlighted)
    }
    func addView() {
        [
            cursorImageView,
            textLabel
        ].forEach { addSubview($0) }
        self.backgroundColor = .color(.dittoLettoColor(.gray1))
        self.layer.borderColor = UIColor.color(.dittoLettoColor(.dark)).cgColor
        self.layer.borderWidth = UIScreen.main.bounds.width * 0.003
    }

    func setLayout() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        cursorImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cursorImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.044),
            cursorImageView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: UIScreen.main.bounds.height * 0.03
            ),
            cursorImageView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -UIScreen.main.bounds.height * 0.03
            ),
            cursorImageView.rightAnchor.constraint(
                equalTo: self.rightAnchor,
                constant: -UIScreen.main.bounds.width * 0.08
            ),
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textLabel.leftAnchor.constraint(
                equalTo: self.leftAnchor,
                constant: UIScreen.main.bounds.width * 0.026
            )
        ])
    }
}
