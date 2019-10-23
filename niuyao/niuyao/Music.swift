//
//  Music.swift
//  niuyao
//
//  Created by niuyao on 2019/10/22.
//  Copyright © 2019 joymates. All rights reserved.
//

import UIKit

struct Music {
    let name: String
    let singer: String
    
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

extension Music: CustomStringConvertible{
    var description: String{
        return "name: \(name) singer: \(singer)"
    }
    
}
