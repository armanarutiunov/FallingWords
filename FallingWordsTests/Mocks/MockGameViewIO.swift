//
//  MockGameViewIO.swift
//  FallingWordsTests
//
//  Created by Arman Arutyunov on 20/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import FallingWords
import RxSwift
import RxCocoa

class MockGameViewIO: GameViewIO {
    
    var _rightPressed = PublishSubject<Void>()
    var rightPressed: Action { return _rightPressed.asDriver(onErrorDriveWith: .never()) }
    
    var _wrongPressed = PublishSubject<Void>()
    var wrongPressed: Action { return _wrongPressed.asDriver(onErrorDriveWith: .never()) }
    
    var _didNotHit = PublishSubject<Void>()
    var didNotHit: Action { return _didNotHit.asDriver(onErrorDriveWith: .never()) }
    
    var _updateData = PublishSubject<Int>()
    var updateData: Driver<Int> { return _updateData.asDriver(onErrorDriveWith: .never()) }
    
    var _newGame = PublishSubject<Void>()
    var newGame: Action { return _newGame.asDriver(onErrorDriveWith: .never()) }
    
    var _showWord: (Word, CFTimeInterval) -> Void = { _,_ in }
    func showWord(_ word: Word, duration: CFTimeInterval) { _showWord(word, duration) }
    
    var _updateScore: (Bool, Int) -> Void = { _,_ in }
    func updateScore(isAdding: Bool, previousScore: Int) { _updateScore(isAdding, previousScore) }
    
    var _endGame: (Bool) -> Void = { _ in }
    func endGame(_ didWin: Bool) { _endGame(didWin) }
    
    var _showError: (DomainError) -> Void = { _ in }
    func showError(_ error: DomainError) { _showError(error) }
}
