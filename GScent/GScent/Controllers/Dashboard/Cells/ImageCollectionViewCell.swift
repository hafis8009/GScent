//
//  ImageCollectionViewCell.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: AutoLoadImageView!
}

extension ImageCollectionViewCell: CollectionViewCellCustomizable {
    func customize(with columnItem: ColumnItemModel, indexPath: IndexPath) {
        guard let imageModel = columnItem as? ImageColumnItemModel else { return }
        imageView.loadImage(fromUrl: imageModel.imageUrl!.absoluteString, cache: imageCache)
    }
}
