//
//  Constants.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

// TODO : Localise all below constant texts
struct UIStrings {
    static let genericErrorMessage = "Some error occured. Please try again later"
    static let genericErrorTitle = "Error"
    static let badURLErrorMessage = "Something went bad. Please talk to the admin"
}

struct Endpoints {
    static let getDashboardItems = NetworkEndpointModel(baseUrl: "http://goldenscent.com", path: "getDashboardItems", offlineFileName: "dashboardItems")
}
