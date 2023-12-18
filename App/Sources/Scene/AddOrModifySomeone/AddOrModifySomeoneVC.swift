//
//  AddOrModifySomeoneVC.swift
//  Ditto-Letto
//
//  Created by 박현준 on 12/18/23.
//  Copyright © 2023 com.UNITHON-Team3. All rights reserved.
//

import UIKit
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
        
    }
    override func setLayout() {
        
    }
    override func configureVC() {
        
    }
}
