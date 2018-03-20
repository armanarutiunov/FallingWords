//
//  GameViewModelTests.swift
//  FallingWordsTests
//
//  Created by Arman Arutyunov on 20/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import XCTest
import RxSwift

@testable import FallingWords

class GameViewModelTests: XCTestCase {
    
    var gameService: MockGameService!
    var sut: GameViewModel<MockGameViewIO>!
    var viewIO: MockGameViewIO!
    
    override func setUp() {
        super.setUp()
        gameService = MockGameService()
        sut = GameViewModel()
        viewIO = MockGameViewIO()
    }
    
    
}
