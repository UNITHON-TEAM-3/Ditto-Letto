import UIKit

import SnapKit
import DesignSystem

class HomeEmptyView: UIView {
    // MARK: - Properties
    private let tungLabel: UILabel = {
        $0.text = "텅!"
        $0.font = .ramche(.title2)
        return $0
    }(UILabel())
    private let tungImageView: UIImageView = {
        $0.image = .Image.emptyFolder
        return $0
    }(UIImageView())
    private let questionLabel: UILabel = {
        $0.text = """
            나에게 마음을 전달할 수 있도록\n
            편지를 보내볼까요?
        """
        $0.font = .ramche(.body)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    // MARK: - Life Cycles
    init() {
        super.init(frame: .zero)
        addView()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set UI
    private func addView() {
        addSubview(tungLabel)
        addSubview(tungImageView)
        addSubview(questionLabel)
    }
    private func setLayout() {
        tungImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(51)
            make.width.equalTo(57)
        }
        tungLabel.snp.makeConstraints { make in
            make.bottom.equalTo(tungImageView.snp.top).inset(-20)
            make.centerX.equalToSuperview()
        }
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(tungImageView.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
        }
    }
}
