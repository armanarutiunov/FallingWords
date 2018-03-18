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
        viewModel.attachView(viewIO: self).disposed(by: disposeBag)
    }

}

extension GameViewController: GameViewIO {
    
}

extension GameViewController {
    
    private func setupView() {
        
    }
    
}
