import UIKit

public enum BottomSheetType: CaseIterable {
    case home
    case setNumber
    case modifyDelete
}

public protocol BottomSheetDelegate {
    func tappedEvent()
}

public final class BottomSheetView: UIViewController {
    public var bottomSheetType: BottomSheetType = .home
    var delegate: BottomSheetDelegate?
    // MARK: - Properties
    private let dimmedView: UIView = {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.6)
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
        $0.text = "바텀시트 title"
        $0.font = .ramche(.body)
        $0.textColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UILabel())
    private let seperateLine: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UIView())
    private let bottomTableSheetController = BottomTableSheetController()
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
        switch bottomSheetType {
        case .home:
            defaultHeight = UIScreen.main.bounds.height * 0.8
            bottomSheetView.addSubview(numberOrFriendLabel)
            bottomSheetView.addSubview(seperateLine)
        case .setNumber:
            defaultHeight = UIScreen.main.bounds.height * 0.4
            bottomSheetView.addSubview(numberOrFriendLabel)
            bottomSheetView.addSubview(seperateLine)
        case .modifyDelete:
            defaultHeight = UIScreen.main.bounds.height * 0.3
        }
    }
    func setLayout() {
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
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
            bottomSheetViewTopConstraint
        ])
        setTypeToLayout()
    }
    private func setTypeToLayout() {
        switch bottomSheetType {
        case .home:
            addChild(bottomTableSheetController)
            bottomSheetView.addSubview(bottomTableSheetController.view)
            bottomTableSheetController.didMove(toParent: self)
            bottomSheetView.clipsToBounds = true
            numberOrFriendLabel.translatesAutoresizingMaskIntoConstraints = false
            seperateLine.translatesAutoresizingMaskIntoConstraints = false
            bottomTableSheetController.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                numberOrFriendLabel.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor),
                numberOrFriendLabel.topAnchor.constraint(equalTo: bottomSheetView.topAnchor,
                                                         constant: UIScreen.main.bounds.height * 0.025),
                
                seperateLine.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
                seperateLine.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
                seperateLine.topAnchor.constraint(equalTo: numberOrFriendLabel.bottomAnchor,
                                                  constant: UIScreen.main.bounds.height * 0.02),
                seperateLine.heightAnchor.constraint(equalToConstant: 0.8),
                
                bottomTableSheetController.view.topAnchor.constraint(equalTo: seperateLine.bottomAnchor),
                bottomTableSheetController.view.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
                bottomTableSheetController.view.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
                bottomTableSheetController.view.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor)
            ])
        case .setNumber:
            numberOrFriendLabel.translatesAutoresizingMaskIntoConstraints = false
            seperateLine.translatesAutoresizingMaskIntoConstraints = false
            addChild(bottomTableSheetController)
            bottomSheetView.addSubview(bottomTableSheetController.view)
            bottomTableSheetController.didMove(toParent: self)
            bottomSheetView.clipsToBounds = true
            
            NSLayoutConstraint.activate([
                numberOrFriendLabel.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor),
                numberOrFriendLabel.topAnchor.constraint(equalTo: bottomSheetView.topAnchor,
                                                         constant: UIScreen.main.bounds.height * 0.025),
                
                seperateLine.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
                seperateLine.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
                seperateLine.topAnchor.constraint(equalTo: numberOrFriendLabel.bottomAnchor,
                                                  constant: UIScreen.main.bounds.height * 0.02),
                seperateLine.heightAnchor.constraint(equalToConstant: 0.8),
                
                bottomTableSheetController.view.topAnchor.constraint(equalTo: seperateLine.bottomAnchor),
                bottomTableSheetController.view.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
                bottomTableSheetController.view.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
                bottomTableSheetController.view.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor)
            ])
        case .modifyDelete:
            addChild(bottomTableSheetController)
            bottomSheetView.addSubview(bottomTableSheetController.view)
            bottomTableSheetController.didMove(toParent: self)
            bottomSheetView.clipsToBounds = true
            
            bottomTableSheetController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bottomTableSheetController.view.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
                bottomTableSheetController.view.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
                bottomTableSheetController.view.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
                bottomTableSheetController.view.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor)
            ])
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
    // MARK: - Gesture
    private func configGesture() {
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(dimmedTap)
        dimmedView.isUserInteractionEnabled = true
    }
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheet()
    }
}
