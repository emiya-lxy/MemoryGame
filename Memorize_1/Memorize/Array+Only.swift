//
//  Array+Only.swift
//  Memorize
//
//  Created by 刘昕奕 on 2020/7/29.
//  Copyright © 2020 emiya_lxy. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
