//
//  TextCollectionViewCell.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {
    @IBOutlet var label: UILabel!
}

extension TextCollectionViewCell: CollectionViewCellCustomizable {
    func customize(with columnItem: ColumnItemModel, indexPath: IndexPath) {
        guard let textModel = columnItem as? TextColumnItemModel else { return }
        label.text = textModel.content
        label.textColor = textModel.textColor
        label.textAlignment = textModel.textAlign
        label.font = textModel.font ?? UIFont.systemFont(ofSize: CGFloat(textModel.fontSize))
        if let bg = textModel.background, let bgColor = bg.color {
            contentView.backgroundColor = bgColor
        }
    }
}
