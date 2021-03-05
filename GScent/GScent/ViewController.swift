//
//  ViewController.swift
//  GScent
//
//  Created by AdibUser on 04/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let client = NetworkClient(endpoint: Endpoints.getDashboardItems)
        let dashboardAdapter = DashboardNetworkAdapter(networkClient: client)
        dashboardAdapter.getDashboardItems() { sections, error in
            print(sections)
        }
    }
}

