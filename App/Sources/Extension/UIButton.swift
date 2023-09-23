//
//  UIButton.swift
//  Ditto-Letto
//
//  Created by 박현준 on 2023/09/23.
//  Copyright © 2023 com.UNITHON-Team3. All rights reserved.
//

import UIKit

extension UIButton {
    func setMainButton(color: String) {
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont(name: "Ramche", size: 16)
        backgroundColor = UIColor(named: color)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
}
