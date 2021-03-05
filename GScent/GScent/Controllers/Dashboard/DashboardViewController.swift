//
//  DashboardViewController.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import UIKit

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
                self.dashboardDataSource = sectionItems
                self.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { (sectionNum, env)
                -> NSCollectionLayoutSection? in
                    return sectionItems[sectionNum].createCollectionLayoutSection()
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

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
