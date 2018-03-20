//
//  GameViewController.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 13/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GameViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBar: ProgressBarView!
    @IBOutlet weak var originalWordLabel: UILabel!
    @IBOutlet weak var pointsView: PointsView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var wrongButton: UIButton!
    @IBOutlet weak var plusScoreLabel: UILabel!
    @IBOutlet weak var minusScoreLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private let viewModel = GameViewModel<GameViewController>()
    private let updateDataSignal = PublishSubject<Int>()
    private let newGameSignal = PublishSubject<Void>()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.attachView(viewIO: self).disposed(by: disposeBag)
        progressBar.greenWidth.constant = progressBar.frame.width / 2
    }

}

extension GameViewController: GameViewIO {
    var rightPressed: Action {
        return rightButton.rx.tap.asAction()
    }
    
    var wrongPressed: Action {
        return wrongButton.rx.tap.asAction()
    }
    
    var didNotHit: Action {
        return pointsView.didNotHitSignal.asDriver(onErrorDriveWith: .never())
    }
    
    var updateData: Driver<Int> {
        return updateDataSignal.asDriver(onErrorDriveWith: .never())
    }
    
    var newGame: Action {
        return newGameSignal.asDriver(onErrorDriveWith: .never())
    }
    
    func showWord(_ word: Word, duration: CFTimeInterval) {
        originalWordLabel.text = word.original
        pointsView.newFall(with: word.translation, duration: duration)
    }
    
    func updateScore(isAdding: Bool, previousScore: Int) {
        let plusScore = pointsView.stopFalling()
        isAdding ?
            addPoints(newScore: previousScore + plusScore,
                      pointsAdding: plusScore) :
            subtractPoints(previousScore - 100)
    }
    
    func endGame(_ didWin: Bool) {
        let title = didWin ? "You win!" : " You lose :("
        let alert = UIAlertController(title: title, message: "Want to try again?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Sure!", style: .default, handler: { [weak self] action in
            guard let `self` = self else { return }
            self.newGameSignal.onNext(())
            self.progressBar.greenWidth.constant = self.progressBar.frame.width / 2
            self.scoreLabel.text = "Your score: 0"
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showError(_ error: DomainError) {
        let alert = UIAlertController(title: "Error", message: error.string, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Helper methods

extension GameViewController {
    
    private func addPoints(newScore: Int, pointsAdding: Int) {
        plusScoreLabel.text = "+\(pointsAdding)"
        animateScoreUpdate(plusScoreLabel, score: newScore)
    }
    
    private func subtractPoints(_ points: Int) {
        animateScoreUpdate(minusScoreLabel, score: points)
    }
    
    private func animateScoreUpdate(_ label: UILabel, score: Int) {
        UIView.animate(withDuration: 0.5, animations: {
            label.alpha = 1
        }, completion: { [weak self] _ in
            self?.progressBar.updateScore(score)
            self?.scoreLabel.text = "Your score: \(score)"
            UIView.animate(withDuration: 0.3, animations: {
                label.alpha = 0
            }, completion: { [weak self] _ in
                self?.updateDataSignal.onNext(score)
            })
        })
    }
}

