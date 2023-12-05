import UIKit

public enum BottomSheetType: CaseIterable {
    case home
    case setNumber
    case modifyDelete
}
public protocol BottomSheetDelegate {
    func save()
    func modify()
    func delete()
    func number(num: String)
}
public final class BottomSheetView: UIViewController {
    enum HomeSheetType: String, CaseIterable {
        case saveNumber = "번호 저장하기"
        case deleteToList = "리스트에서 기록 삭제하기"
    }
    enum SetNumberSheetType: String, CaseIterable {
        case one = "011"
        case six = "016"
        case seven = "017"
        case eight = "018"
        case nine = "019"
    }
    enum ModifyDeleteSheetType: String, CaseIterable {
        case modify = "수정하기"
        case delete = "삭제하기"
    }
    public var bottomSheetType: BottomSheetType = .home
    public var delegate: BottomSheetDelegate?
    // MARK: - Properties
    private let dimmedView: UIView = {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        $0.alpha = 0
        return $0
    }(UIView())
    private let bottomSheetView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 25
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
        return $0
    }(UIView())
    var numberOrFriendLabel: UILabel = {
        $0.font = .ramche(.body)
        $0.textColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UILabel())
    private let seperateLine1: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UIView())
    private let seperateLine2: UIView = {
        $0.backgroundColor = .systemGray4
        return $0
    }(UIView())
    private let deleteSheetButton: UIButton = {
        $0.setTitle("닫기", for: .normal)
        $0.setTitleColor(.color(.dittoLettoColor(.dark)), for: .normal)
        $0.setBackgroundColor(.systemGray6, for: .highlighted)
        $0.titleLabel?.font = .ramche(.body)
        return $0
    }(UIButton())
    private var stackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
        return $0
    }(UIStackView())
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    var defaultHeight: CGFloat = 300
    // MARK: - Life Cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        configGesture()
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    func addView() {
        view.addSubview(dimmedView)
        view.addSubview(bottomSheetView)
        bottomSheetView.addSubview(deleteSheetButton)
        switch bottomSheetType {
        case .home:
            numberOrFriendLabel.text = "친구 ㅋ"
            defaultHeight = UIScreen.main.bounds.height * 0.38
            bottomSheetView.addSubview(numberOrFriendLabel)
            bottomSheetView.addSubview(seperateLine1)
            bottomSheetView.addSubview(seperateLine2)
            bottomSheetView.addSubview(stackView)
        case .setNumber:
            numberOrFriendLabel.text = "번호 설정"
            defaultHeight = UIScreen.main.bounds.height * 0.68
            bottomSheetView.addSubview(numberOrFriendLabel)
            bottomSheetView.addSubview(seperateLine1)
            bottomSheetView.addSubview(seperateLine2)
            bottomSheetView.addSubview(stackView)
        case .modifyDelete:
            defaultHeight = UIScreen.main.bounds.height * 0.33
            bottomSheetView.addSubview(seperateLine2)
            bottomSheetView.addSubview(stackView)
        }
    }
    func setLayout() {
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        deleteSheetButton.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                                            constant: topConstant)
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint,
            
            deleteSheetButton.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            deleteSheetButton.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            deleteSheetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            deleteSheetButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.09)
        ])
        setTypeToLayout()
    }
    private func setTypeToLayout() {
        switch bottomSheetType {
        case .home:
            homeTypeLayout()
        case .setNumber:
            setNumberTypeLayout()
        case .modifyDelete:
            modifyDeleteTypeLayout()
        }
    }
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.6
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    private func hideBottomSheet() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    private func makeStackButton(title: String) -> UIButton {
        let button: UIButton = {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.color(.dittoLettoColor(.dark)), for: .normal)
            $0.titleLabel?.font = .ramche(.body)
            return $0
        }(UIButton())
        return button
    }
    // MARK: - Gesture
    private func configGesture() {
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(dimmedTap)
        dimmedView.isUserInteractionEnabled = true
        deleteSheetButton.addTarget(self, action: #selector(valueButtonTapped(_:)), for: .touchUpInside)
    }
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheet()
    }
    @objc private func valueButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case HomeSheetType.saveNumber.hashValue:
            delegate?.save()
            hideBottomSheet()
        case HomeSheetType.deleteToList.hashValue:
            delegate?.delete()
            hideBottomSheet()
        case SetNumberSheetType.one.hashValue:
            delegate?.number(num: SetNumberSheetType.one.rawValue)
            hideBottomSheet()
        case SetNumberSheetType.six.hashValue:
            delegate?.number(num: SetNumberSheetType.six.rawValue)
            hideBottomSheet()
        case SetNumberSheetType.seven.hashValue:
            delegate?.number(num: SetNumberSheetType.seven.rawValue)
            hideBottomSheet()
        case SetNumberSheetType.eight.hashValue:
            delegate?.number(num: SetNumberSheetType.eight.rawValue)
            hideBottomSheet()
        case SetNumberSheetType.nine.hashValue:
            delegate?.number(num: SetNumberSheetType.nine.rawValue)
            hideBottomSheet()
        case ModifyDeleteSheetType.modify.hashValue:
            delegate?.modify()
            hideBottomSheet()
        case ModifyDeleteSheetType.delete.hashValue:
            delegate?.delete()
            hideBottomSheet()
        default:
            hideBottomSheet()
        }
    }
}
extension BottomSheetView {
    private func homeTypeLayout() {
        HomeSheetType.allCases.forEach { title in
            let button = makeStackButton(title: title.rawValue)
            button.setBackgroundColor(.white, for: .normal)
            button.setBackgroundColor(.color(.dittoLettoColor(.main)), for: .highlighted)
            button.tag = title.hashValue
            button.addTarget(self, action: #selector(valueButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        numberOrFriendLabel.translatesAutoresizingMaskIntoConstraints = false
        seperateLine1.translatesAutoresizingMaskIntoConstraints = false
        seperateLine2.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberOrFriendLabel.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor,
                                                         constant: UIScreen.main.bounds.height * 0.03),
            numberOrFriendLabel.topAnchor.constraint(equalTo: bottomSheetView.topAnchor,
                                                     constant: UIScreen.main.bounds.height * 0.025),
            
            seperateLine1.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            seperateLine1.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            seperateLine1.topAnchor.constraint(equalTo: numberOrFriendLabel.bottomAnchor,
                                              constant: UIScreen.main.bounds.height * 0.02),
            seperateLine1.heightAnchor.constraint(equalToConstant: 0.8),
            
            seperateLine2.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            seperateLine2.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            seperateLine2.topAnchor.constraint(equalTo: deleteSheetButton.topAnchor),
            seperateLine2.heightAnchor.constraint(equalToConstant: 0.8),
            
            stackView.topAnchor.constraint(equalTo: seperateLine1.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: seperateLine2.topAnchor)
        ])
    }
    private func setNumberTypeLayout() {
        SetNumberSheetType.allCases.forEach { title in
            let button = makeStackButton(title: title.rawValue)
            button.setBackgroundColor(.white, for: .normal)
            button.setBackgroundColor(.color(.dittoLettoColor(.main)), for: .highlighted)
            button.tag = title.hashValue
            button.addTarget(self, action: #selector(valueButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        numberOrFriendLabel.translatesAutoresizingMaskIntoConstraints = false
        seperateLine1.translatesAutoresizingMaskIntoConstraints = false
        seperateLine2.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberOrFriendLabel.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor,
                                                         constant: UIScreen.main.bounds.height * 0.03),
            numberOrFriendLabel.topAnchor.constraint(equalTo: bottomSheetView.topAnchor,
                                                     constant: UIScreen.main.bounds.height * 0.025),
            
            seperateLine1.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            seperateLine1.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            seperateLine1.topAnchor.constraint(equalTo: numberOrFriendLabel.bottomAnchor,
                                              constant: UIScreen.main.bounds.height * 0.02),
            seperateLine1.heightAnchor.constraint(equalToConstant: 0.8),
            
            seperateLine2.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            seperateLine2.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            seperateLine2.topAnchor.constraint(equalTo: deleteSheetButton.topAnchor),
            seperateLine2.heightAnchor.constraint(equalToConstant: 0.8),
            
            stackView.topAnchor.constraint(equalTo: seperateLine1.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: seperateLine2.topAnchor)
        ])
    }
    private func modifyDeleteTypeLayout() {
        ModifyDeleteSheetType.allCases.forEach { title in
            let button = makeStackButton(title: title.rawValue)
            button.setBackgroundColor(.white, for: .normal)
            button.setBackgroundColor(.color(.dittoLettoColor(.main)), for: .highlighted)
            button.tag = title.hashValue
            button.addTarget(self, action: #selector(valueButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        seperateLine2.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seperateLine2.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            seperateLine2.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            seperateLine2.topAnchor.constraint(equalTo: deleteSheetButton.topAnchor),
            seperateLine2.heightAnchor.constraint(equalToConstant: 0.8),
            
            stackView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor,
                                           constant: UIScreen.main.bounds.height * 0.025),
            stackView.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: seperateLine2.topAnchor)
        ])
    }
}

// button hilighting 색상 처리
extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(backgroundImage, for: state)
    }
}
