//
//  GameViewModel.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 13/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift
import RxCocoa

class GameViewModel<V: GameViewIO>: ViewModel<V> {
    
    private let gameService: GameService = LocalGameService()
    public let game = BehaviorRelay<Game>(value: Game(words: [Word]()))
    
    override func setup() {
        updateWords()
    }
    
    override func viewAttached() -> Disposable {
        guard let viewIO = viewIO else { return Disposables.create() }
        
        return disposable(
            viewIO.rightPressed.drive(onNext: { [weak self] _ in
                self?.finishRound(userChoice: true)
            }),
            viewIO.wrongPressed.drive(onNext: { [weak self] _ in
                self?.finishRound(userChoice: false)
            }),
            viewIO.updateData.drive(onNext: { [weak self] newScore in
                guard let `self` = self else { return }
                self.game.value.score = newScore
                if newScore >= 1000 || newScore <= -1000 {
                    viewIO.endGame(newScore >= 1000)
                    return
                }
                viewIO.showWord(self.game.value.currentWord,
                                duration: self.game.value.fallDuration)
            }),
            viewIO.didNotHit.drive(onNext: { [weak self] in
                guard let `self` = self else { return }
                let isRight = self.game.value.currentWord.translations.first!.isRight
                self.finishRound(userChoice: !isRight)
            }),
            viewIO.newGame.drive(onNext: { [weak self] in
                self?.updateWords()
            })
        )
    }
    
    private func finishRound(userChoice: Bool) {
        let userIsRight = userChoice == game.value.currentWord.translations.first!.isRight
        let _ = userChoice && !userIsRight ?
            game.value.updateCurrentWord() :
            game.value.updateTranslation()
        viewIO?.updateScore(isAdding: userIsRight,
                            previousScore: game.value.score)
    }
    
    private func updateWords() {
        gameService.getWords()
            .subscribe(
                onNext:{ [weak self] jsonWords in
                    guard let `self` = self else { return }
                    let words = self.shuffleWords(jsonWords)
                    self.game.accept(Game(words: words))
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
    
    /// Shuffles original JSON array. Method is public only for unit testing.
    ///
    /// - Parameter jsonWords: Original array of words from JSON
    /// - Returns: Shuffled array of words in presentable way
    public func shuffleWords(_ jsonWords: [JSONWord]) -> [Word] {
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
            shuffledTranslations.insert(rightTranslation, at: Int(arc4random_uniform(3)))
            let word = Word(original: $0.original, translations: shuffledTranslations)
            words.append(word)
        }
        return words.shuffled()
    }
    
}
