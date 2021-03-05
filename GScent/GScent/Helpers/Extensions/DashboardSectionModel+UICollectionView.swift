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
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: layoutItemFractionalWidth, heightDimension: layoutItemFractionalHeight))
        item.contentInsets = layoutInsets

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: layoutGroupFractionalWidth, heightDimension: layoutGroupFractionalHeight), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = scrollingBehaviour
        
        return section
    }
    
    private var layoutItemFractionalWidth: NSCollectionLayoutDimension {
        guard let rowType = rowType else { return .fractionalWidth(1.0) }
        switch rowType {
        case .image, .text:
            var columnCount = columns?.count ?? 1
            if columnCount > 3 {
                columnCount = 3
            }
            return .fractionalWidth(1/(CGFloat(columnCount)))
        case .customSlider:
            return .fractionalWidth(1.0)
        }
    }
    
    private var layoutItemFractionalHeight: NSCollectionLayoutDimension {
        return .fractionalHeight(1)
    }
    
    private var layoutGroupFractionalWidth: NSCollectionLayoutDimension {
        guard let rowType = rowType else { return .fractionalWidth(1.0) }
        switch rowType {
        case .image, .text:
            return .fractionalWidth(1.0)
        case .customSlider:
            return .fractionalWidth(0.8)
        }
    }
    
    private var layoutGroupFractionalHeight: NSCollectionLayoutDimension {
        return .estimated(CGFloat(height))
    }
    
    private var scrollingBehaviour: UICollectionLayoutSectionOrthogonalScrollingBehavior {
        guard let rowType = rowType else { return .none }
        switch rowType {
        case .customSlider:
            return .continuous
        default:
            return .none
        }
    }
    
    private var layoutInsets: NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: 0.0, leading: CGFloat(leftMargin), bottom: CGFloat(bottomMargin), trailing: CGFloat(rightMargin))
    }
}
