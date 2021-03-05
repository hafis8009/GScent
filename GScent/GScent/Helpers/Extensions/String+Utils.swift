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
    
    var pixelValue: Double {
        let intVal = replacingOccurrences(of: "px", with: "")
        return Double(intVal) ?? 0.0
    }
    
    var asTextAlignment: NSTextAlignment? {
        switch self {
        case "left":
            return .left
            case "right":
            return .right
            case "center":
            return .center
        default:
            return nil
        }
    }
    
    var asColor: UIColor? {
        return .black
    }
}
