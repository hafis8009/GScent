//
//  CollectionViewCellCustomizable.swift
//  GScent
//
//  Created by AdibUser on 06/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

protocol CollectionViewCellCustomizable {
    func customize(with columnItem: ColumnItemModel, indexPath: IndexPath)
}
