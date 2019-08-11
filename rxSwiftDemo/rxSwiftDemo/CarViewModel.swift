//
//  CarViewModel.swift
//  rxSwiftDemo
//
//  Created by Lio on 8/10/19.
//  Copyright © 2019 thinhngo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CarViewModel {
    let disposeBag = DisposeBag()
    
    var modelText: BehaviorSubject<String>
    var makeText: BehaviorSubject<String>
    var horsepowerText: BehaviorSubject<String>
    var kilowattText: BehaviorSubject<String>
    var titleText: BehaviorSubject<String>
}
