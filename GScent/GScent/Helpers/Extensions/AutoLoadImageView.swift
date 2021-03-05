//
//  AutoLoadImageView.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import UIKit

typealias ImageCache = NSCache<NSString, UIImage>

class AutoLoadImageView: UIImageView {
    var imageURLString: String?
    
    func loadImage(fromUrl urlString: String, cache: ImageCache?, clearOldImage: Bool = true, placeHolderImage: UIImage? = nil) {
        imageURLString = urlString
        
        if clearOldImage == true {
            image = nil
        }
        
        guard let url = URL(string: urlString) else { return }
        
        if let imageCache = cache, let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            image = imageFromCache
            return
        }
        
        if placeHolderImage != nil {
            image = placeHolderImage
        }
        
        let imageLoadTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Image loadig failed")
                return
            }
            
            DispatchQueue.main.async {
                guard let imageData = data, let imageToCache = UIImage(data: imageData) else {
                    print("Invalid image data")
                    return
                }
                
                if self.imageURLString == urlString {
                    self.image = imageToCache
                }
                cache?.setObject(imageToCache, forKey: urlString as NSString)
            }
        }
        imageLoadTask.resume()
    }
}
