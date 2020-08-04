//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by 刘昕奕 on 2020/7/28.
//  Copyright © 2020 emiya_lxy. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
