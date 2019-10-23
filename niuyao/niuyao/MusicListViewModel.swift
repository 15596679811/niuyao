//
//  ViewModel.swift
//  niuyao
//
//  Created by niuyao on 2019/10/22.
//  Copyright © 2019 joymates. All rights reserved.
//

import Foundation
import RxSwift

struct MusicListViewModel {
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E")
    ])
}
