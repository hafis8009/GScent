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

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: layoutGroupFractionalWidth, heightDimension: layoutGroupFractionalHeight), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = layoutInsets
        
        section.orthogonalScrollingBehavior = scrollingBehaviour
        
        // need to move this code
        section.boundarySupplementaryItems = supplementaryFooterItems()
        
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
            return .fractionalWidth(1.0)
        }
    }
    
    private var layoutGroupFractionalHeight: NSCollectionLayoutDimension {
        return .estimated(CGFloat(height))
    }
    
    private var scrollingBehaviour: UICollectionLayoutSectionOrthogonalScrollingBehavior {
        guard let rowType = rowType else { return .none }
        switch rowType {
        case .customSlider:
            return .paging
        default:
            return .none
        }
    }
    
    private var layoutInsets: NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: 0.0, leading: CGFloat(leftMargin), bottom: CGFloat(bottomMargin), trailing: CGFloat(rightMargin))
    }
    
    private var layoutEdgeSpacing: NSCollectionLayoutEdgeSpacing {
        return NSCollectionLayoutEdgeSpacing(leading: .fixed(10), top: .fixed(0), trailing: .fixed(10), bottom: .fixed(0))
    }
    
    private func supplementaryFooterItems() -> [NSCollectionLayoutBoundarySupplementaryItem] {
        guard let rowType = rowType, rowType == .customSlider else {
            return []
        }
        
        return [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                              heightDimension: .absolute(30)),
                                                            elementKind: UICollectionView.elementKindSectionFooter,
                                                            alignment: .bottomLeading)]
    }
}
