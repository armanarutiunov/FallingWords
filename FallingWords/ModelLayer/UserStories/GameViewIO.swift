//
//  GameViewIO.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 15/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxCocoa

public protocol GameViewIO: ViewIO {
    
    /// Right button pressed
    var rightPressed: Driver<Int> { get }
    
    /// Wrong button pressed
    var wrongPressed: Driver<Int> { get }
    
    /// User did not hit any button while word was falling
    var didNotHit: Action { get }
    
    /// Update score in Game object and word for next round when score animations are finished
    var updateData: Driver<Int> { get }
    
    /// Start a new game
    var newGame: Action { get }
    
    /// Show new word
    func showWord(_ word: Word, duration: CFTimeInterval)
    
    /// Update user's score
    func updateScore(isAdding: Bool, newScore: Int)
    
    /// Show alert of ending game
    func endGame(_ didWin: Bool)
    
    /// Show error
    func showError(_ error: DomainError)
}
