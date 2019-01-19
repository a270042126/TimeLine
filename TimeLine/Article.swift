//
//  CCModel.swift
//  TimeLine
//
//  Created by dd on 2019/1/19.
//  Copyright © 2019年 dd. All rights reserved.
//

import HandyJSON

struct Article: HandyJSON {
    var content: String = ""
    var publishTime: String = ""
    var bearNum: Int = 0
    var ID: Int = 0
    var title: String = ""
    var bullOrBear: Int = 0
    var bullNum: Int = 0
    var isFolding = false
}
