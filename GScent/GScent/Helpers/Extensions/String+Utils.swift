//
//  String+Utils.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

import UIKit

extension String {
    var asURL: URL? {
        return URL(string: self)
    }
}
