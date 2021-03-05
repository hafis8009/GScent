//
//  DashboardSectionModel.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

class DashboardSectionModel: Decodable {
    let leftMargin: Double
    let rightMargin: Double
    let bottomMargin: Double
    private(set) var height: Double
    var columns: [ColumnItemModel]?
    
    var rowType: ColumnItemType? {
        guard let c = columns, let firstItem = c.first else { return nil }
        return firstItem.type
    }
    
    var columnType: ColumnItemType? {
        guard let c = columns, let firstItem = c.first else { return nil }
        var type = firstItem.type
        if type == .customSlider, let firstSlide = (firstItem as? SliderColumnItemModel)?.slides?.first {
            type = firstSlide.type
        }
        return type
    }
    
    var columnCount: Int {
        guard let rowType = rowType else { return 0 }
        switch rowType {
        case .customSlider:
            guard let columns = columns, let firstItem = columns.first as? SliderColumnItemModel, let slides = firstItem.slides else { return 0 }
            return slides.count
        default:
            return columns?.count ?? 0
        }
    }
    
    private enum DecodingKeys: String, CodingKey {
        case leftMargin = "row-margin-left"
        case rightMargin = "row-margin-right"
        case bottomMargin = "row-margin-bottom"
        case height
        case columns
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        leftMargin = (try? container.decode(String.self, forKey: .leftMargin))?.pixelValue ?? 0.0
        rightMargin = (try? container.decode(String.self, forKey: .rightMargin))?.pixelValue ?? 0.0
        bottomMargin = (try? container.decode(String.self, forKey: .bottomMargin))?.pixelValue ?? 0.0
        height = (try? container.decode(String.self, forKey: .height))?.pixelValue ?? 0.0
        
        if let tempColumns = try? container.decode([ColumnItemModel].self, forKey: .columns), tempColumns.count > 0, let firstItem = tempColumns.first {
            switch firstItem.type {
            case .image:
                columns = try? container.decode([ImageColumnItemModel].self, forKey: .columns)
            case .text:
                columns = try? container.decode([TextColumnItemModel].self, forKey: .columns)
            case .customSlider:
                columns = try? container.decode([SliderColumnItemModel].self, forKey: .columns)
            }
            
            if height == 0.0 {
                height = firstItem.type.defaultHeight
            }
        }
    }
    
    func columnModel(for indexPath: IndexPath) -> ColumnItemModel? {
        guard let rowType = rowType else { return nil }
        let index = indexPath.row
        switch rowType {
        case .image, .text:
            return columns?[index]
        case .customSlider:
            return (columns?.first as? SliderColumnItemModel)?.slides?[index]
        }
    }
}

extension ColumnItemType {
    var defaultHeight: Double {
        switch self {
        case .image:
            return 100.0
        case .text:
            return 60.0
        case .customSlider:
            return 100.0
        }
    }
}
