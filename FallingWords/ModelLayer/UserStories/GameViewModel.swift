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
    private let game = Variable<Game>(Game(words: [Word]()))
    
    override func setup() {
        updateWords()
    }
    
    override func viewAttached() -> Disposable {
        guard let viewIO = viewIO else { return Disposables.create() }
        
        return disposable(
            viewIO.rightPressed.drive(onNext: { [weak self] _ in
                self?.checkResult(userChoice: true)
            }),
            viewIO.wrongPressed.drive(onNext: { [weak self] _ in
                self?.checkResult(userChoice: false)
            })
        )
    }
    
    private func checkResult(userChoice: Bool) {
        
    }
    
    private func updateWords() {
        gameService.getWords()
            .subscribe(
                onNext:{ [weak self] jsonWords in
                    guard let `self` = self else { return }
                    let words = self.shuffleWords(jsonWords)
                    self.game.value = Game(words: words)
                    let word = self.game.value.updateCurrentWord()
                    self.viewIO?.showWord(word, duration: self.game.value.fallDuration)
            },
                onError: { [weak self] in
                    if let error = $0 as? DomainError {
                        self?.viewIO?.showError(error)
                    }
            })
            .disposed(by: disposeBag)
    }
    
    private func shuffleWords(_ jsonWords: [JSONWord]) -> [Word] {
        var words = [Word]()
        
        jsonWords.forEach {
            var translations = [Translation]()
            var rightTranslation = Translation(title: $0.translation, isRight: true)
            for word in jsonWords {
                if word.translation == $0.translation{
                    rightTranslation = Translation(title: word.translation, isRight: true)
                }
                else {
                    translations.append(Translation(title: word.translation, isRight: false))
                }
            }
            var shuffledTranslations = translations.shuffled()
            shuffledTranslations.insert(rightTranslation, at: Int(arc4random_uniform(4)))
            let word = Word(original: $0.original, translations: shuffledTranslations)
            words.append(word)
        }
        return words.shuffled()
    }
    
}
