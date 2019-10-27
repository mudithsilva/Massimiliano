//
//  ArrayExtension.swift
//  EventApp
//
//  Created by Mudith Chathuranga on 10/10/18.
//  Copyright © 2018 Webnatics. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

/*
/// Usage :-

    self.projectionList[safe: row] != nil

    guard self.projectionList[safe: row] != nil else {
        return
    }
*/
