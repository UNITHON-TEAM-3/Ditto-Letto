//
//  AddOrModifySomeoneVC.swift
//  Ditto-Letto
//
//  Created by 박현준 on 12/18/23.
//  Copyright © 2023 com.UNITHON-Team3. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AddOrModifySomeoneVC: BaseVC {
    enum AddOrModifySomeoneType: CaseIterable {
        case add
        case modify
    }
    // MARK: Properties
    private lazy var phoneBookInfoView: PhoneBookInfoView = {
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
        return $0
    }(PhoneBookInfoView(type: .add))
    private let setCharaterAndNameView = SetCharacterAndNameView()
    private let addButton: UIButton = {
        $0.setTitle("추가하기", for: .normal)
        $0.setMainButton(color: .main)
        return $0
    }(UIButton())
    let type: AddOrModifySomeoneType
    // MARK: - Life Cycles
    init(type: AddOrModifySomeoneType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        switch type {
        case .add:
            self.phoneBookInfoView.type = .add
        case .modify:
            self.phoneBookInfoView.type = .modify
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(phoneBookInfoView.type)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    // MARK: - Set UI
    override func addView() {
        [
            phoneBookInfoView,
            setCharaterAndNameView,
            addButton
        ].forEach {
            view.addSubview($0)
        }
    }
    override func setLayout() {
        phoneBookInfoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.height * 0.03)
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.053)
            make.height.equalToSuperview().multipliedBy(0.13)
        }
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(UIScreen.main.bounds.height * 0.075)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.height * 0.03)
        }
        setCharaterAndNameView.snp.makeConstraints { make in
            make.leading.equalTo(phoneBookInfoView.snp.leading)
            make.trailing.equalTo(phoneBookInfoView.snp.trailing)
            make.top.equalTo(phoneBookInfoView.snp.bottom).inset(-(UIScreen.main.bounds.height * 0.022))
            make.bottom.equalTo(addButton.snp.top).inset(-(UIScreen.main.bounds.height * 0.025))
        }
    }
    override func configureVC() {
        
    }
}
