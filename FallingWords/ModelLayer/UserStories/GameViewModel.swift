//
//  GameViewModel.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 13/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift

class GameViewModel<V: GameViewIO>: ViewModel<V> {
    
    private let gameService: GameService = LocalGameService()
    private let words = Variable<[Word]>([])
    
    override func setup() {
        
    }
    
    override func viewAttached() -> Disposable {
        guard let viewIO = viewIO else { return Disposables.create() }
        
        let words = gameService.getWords().asDriver(onErrorDriveWith: .never())
        
        return disposable(
            words.drive(onNext:{ [weak self] jsonWords in
                guard let `self` = self else { return }
                let words = self.mapWords(jsonWords)
                self.words.value = words
            }),
            viewIO.rightPressed.drive(onNext: { _ in
                
            }),
            viewIO.wrongPressed.drive(onNext: { _ in
                
            })
        )
    }
    
    private func mapWords(_ jsonWords: [JSONWord]) -> [Word] {
        let words = [Word]()
        return words
    }
}
