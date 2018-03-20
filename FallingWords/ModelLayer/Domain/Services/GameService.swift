//
//  GameService.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 15/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift

public protocol GameService {
    
    func getWords() -> Observable<[JSONWord]>
    
}
