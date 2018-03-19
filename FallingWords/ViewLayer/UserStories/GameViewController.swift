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
    
    private let viewModel = GameViewModel<GameViewController>()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
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
    
    func showWord(_ word: Word, duration: CFTimeInterval) {
        originalWordLabel.text = word.original
        pointsView.newFall(with: word.translation, duration: duration)
    }
    
    func showError(_ error: DomainError) {
        let alert = UIAlertController(title: "Error", message: error.string, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension GameViewController {
    
    private func setupView() {
        
    }
    
}
