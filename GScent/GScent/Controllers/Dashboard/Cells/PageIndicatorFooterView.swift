//
//  PageIndicatorFooterView.swift
//  GScent
//
//  Created by AdibUser on 06/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import UIKit

class PageIndicatorFooterView: UICollectionReusableView, CustomViewProtocol {
    @IBOutlet var contentView: UIView!
    @IBOutlet var pageControl: UIPageControl!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit(for: PageIndicatorFooterView.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit(for: PageIndicatorFooterView.identifier)
    }
}
