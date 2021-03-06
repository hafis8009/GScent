//
//  DashboardViewController.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import UIKit
// swiftlint:disable force_cast
class DashboardViewController: UICollectionViewController {
    
    private var dashboardDataSource: [DashboardSectionModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clearsSelectionOnViewWillAppear = false
        collectionView.backgroundColor = .white

        let client = NetworkClient(endpoint: Endpoints.getDashboardItems)
        let dashboardAdapter = DashboardNetworkAdapter(networkClient: client)
        dashboardAdapter.getDashboardItems() { sections, error in
            if let error = error {
                // Show error alert
                return
            }
            
            if let sectionItems = sections {
                self.collectionView.register(PageIndicatorFooterView.self,
                                             forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                             withReuseIdentifier: PageIndicatorFooterView.identifier)

                self.dashboardDataSource = sectionItems
                self.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { (sectionNum, env)
                -> NSCollectionLayoutSection? in
                    let collectionLayoutSection = sectionItems[sectionNum].createCollectionLayoutSection()
                    collectionLayoutSection.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
                        guard let self = self,
                            let lastItem = items.last,
                            let footerView = self.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter,
                                                                                   at: IndexPath(row: 0, section: lastItem.indexPath.section)) as? PageIndicatorFooterView else { return }
                                footerView.pageControl.currentPage = lastItem.indexPath.row
                        print(footerView)
                            }
                    return collectionLayoutSection
                }
            }
        }
    }

}

// MARK: UICollectionViewDataSource
extension DashboardViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dashboardDataSource?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = dashboardDataSource?[section] else {
            return 0
        }
        
        return section.columnCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionModel = dashboardDataSource![indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sectionModel.cellID, for: indexPath)
        
        if let columnModel = sectionModel.columnModel(for: indexPath), let cellCustomizable = cell as? CollectionViewCellCustomizable {
            cellCustomizable.customize(with: columnModel, indexPath: indexPath)
        }
        
        return cell
    }
        
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView: PageIndicatorFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PageIndicatorFooterView.identifier,
                                                                                                  for: indexPath) as! PageIndicatorFooterView
        footerView.pageControl.numberOfPages = dashboardDataSource?[indexPath.section].columnCount ?? 1
        return footerView
    }
}

// MARK: UICollectionViewDelegate
extension DashboardViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = UIStoryboard.Name.main.instance.getViewController(DashboardViewController.identifier)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

private extension DashboardSectionModel {
    var cellID: String {
        guard let type = columnType else { return "" }
        switch type {
        case .image:
            return ImageCollectionViewCell.identifier
        case .text:
            return TextCollectionViewCell.identifier
        default:
            return ImageCollectionViewCell.identifier
        }
    }
}
