//
//  GameViewIO.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 15/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

protocol GameViewIO: ViewIO {
    
    /// Right buttom pressed
    var rightPressed: Action { get }
    
    /// Wrong button pressed
    var wrongPressed: Action { get }
    
    /// Show new word
    func showWord(_ word: Word)
}
