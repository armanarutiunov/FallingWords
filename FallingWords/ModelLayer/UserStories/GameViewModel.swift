//
//  GameViewModel.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 13/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift

class GameViewModel<V: GameViewIO>: ViewModel<V> {
    
    private let gameService = LocalGameService()
    
    override func setup() {
        
    }
    
    override func viewAttached() -> Disposable {
        guard let viewIO = viewIO else { return Disposables.create() }
        return disposable(
            
        )
    }
}
