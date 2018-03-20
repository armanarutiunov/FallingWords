//
//  GameViewIO.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 15/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxCocoa

protocol GameViewIO: ViewIO {
    
    /// Right buttom pressed
    var rightPressed: Action { get }
    
    /// Wrong button pressed
    var wrongPressed: Action { get }
    
    /// User did not hit any button while word was falling
    var didNotHit: Action { get }
    
    /// Update score in Game object and word for next round when score animations are finished
    var updateData: Driver<Int> { get }
    
    /// Start a new game
    var newGame: Action { get }
    
    /// Show new word
    func showWord(_ word: Word, duration: CFTimeInterval)
    
    /// Update user's score
    func updateScore(isAdding: Bool, previousScore: Int)
    
    /// Show alert of ending game
    func endGame(_ didWin: Bool)
    
    /// Show error
    func showError(_ error: DomainError)
}
