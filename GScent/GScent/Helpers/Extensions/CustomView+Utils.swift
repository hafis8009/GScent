//
//  CustomView+Utils.swift
//  GScent
//
//  Created by AdibUser on 06/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import UIKit

protocol CustomViewProtocol {
    var contentView: UIView! { get }
    
    func commomInit(for customViewName: String)
}

extension CustomViewProtocol where Self: UIView {
    
    func commomInit(for customViewName: String) {
        Bundle.main.loadNibNamed(customViewName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
