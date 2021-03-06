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
    var content: String
    var textAlign: NSTextAlignment
    var textColor: UIColor
    var fontSize: Float
    var fontName: String
    var background: BackgroundProperty?
    
    var font: UIFont? {
        return UIFont(name: fontName, size: CGFloat(fontSize))
    }

    private enum DecodingKeys: String, CodingKey {
        case type
        case content
        case textAlign = "text-align"
        case textColor = "font-color"
        case fontSize = "font-size"
        case fontName = "font"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        content = try container.decode(String.self, forKey: .content)
        textAlign = (try? container.decode(String.self, forKey: .textAlign))?.asTextAlignment ?? .center
        textColor = (try? container.decode(String.self, forKey: .textColor))?.asColor ?? .black
        fontSize = try container.decode(Float.self, forKey: .fontSize)
        fontName = try container.decode(String.self, forKey: .fontName)
        
        try super.init(from: decoder)
    }
}

class SliderColumnItemModel: ColumnItemModel {
    var slides: [ColumnItemModel]?

    private enum DecodingKeys: String, CodingKey {
        case type
        case slides
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        if let tempSlides = try? container.decode([ColumnItemModel].self, forKey: .slides), let firstSlide = tempSlides.first {
            if firstSlide.type == .image {
                slides = try? container.decode([ImageColumnItemModel].self, forKey: .slides)
            } else if firstSlide.type == .text {
                slides = try? container.decode([TextColumnItemModel].self, forKey: .slides)
            }
        }
        
        try super.init(from: decoder)
    }
}

class BackgroundProperty {
    var color: UIColor?
    
    private enum DecodingKeys: String, CodingKey {
        case color
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        color = (try? container.decode(String.self, forKey: .color))?.asColor ?? .white
    }
}
