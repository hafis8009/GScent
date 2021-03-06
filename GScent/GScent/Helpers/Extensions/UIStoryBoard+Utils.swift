//
//  UIStoryBoard+Utils.swift
//  GScent
//
//  Created by AdibUser on 06/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum Name: String {
        case main = "Main"
        
        var instance: UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: nil)
        }
    }
    
    func getViewController(_ storyboardID: String) -> UIViewController {
        return self.instantiateViewController(withIdentifier: storyboardID)
    }
}
