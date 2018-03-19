//
//  ControlEvent+Extras.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 19/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift
import RxCocoa

extension ControlEvent {
    func asAction(_ sideEffectHandler: @escaping () -> Void = {}) -> Driver<Void> {
        return map { _ in }
            .do(onNext: { _ in sideEffectHandler() })
            .asDriver(onErrorDriveWith: .never())
    }
}

