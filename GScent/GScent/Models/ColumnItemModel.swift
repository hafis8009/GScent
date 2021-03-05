//
//  ColumnItemModel.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation
import UIKit

enum ColumnItemType: String, Decodable {
    case image
    case text
    case customSlider
}

class ColumnItemModel: Decodable {
    var type: ColumnItemType
    
    private enum DecodingKeys: String, CodingKey {
        case type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        type = try container.decode(ColumnItemType.self, forKey: .type)
    }
}

class ImageColumnItemModel: ColumnItemModel {
    var imageUrl: URL?
    
    private enum DecodingKeys: String, CodingKey {
        case type
        case imageUrl = "src"
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        imageUrl = (try? container.decode(String.self, forKey: .imageUrl))?.asURL
    }
}

class TextColumnItemModel: ColumnItemModel {
    
}

class SliderColumnItemModel: ColumnItemModel {
    
}
