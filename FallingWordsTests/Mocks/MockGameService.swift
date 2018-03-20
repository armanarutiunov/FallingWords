//
//  MockGameService.swift
//  FallingWordsTests
//
//  Created by Arman Arutyunov on 20/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import FallingWords
import RxSwift

class MockGameService: GameService {
    
    var _gerWords: Observable<[JSONWord]>!
    func getWords() -> Observable<[JSONWord]> { return _gerWords }
    
}
