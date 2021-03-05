//
//  DashboardSectionModel+UICollectionView.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation
import UIKit

extension DashboardSectionModel {
    func createCollectionLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.trailing = 0
        item.contentInsets.bottom = 20
        item.contentInsets.leading = 0

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
