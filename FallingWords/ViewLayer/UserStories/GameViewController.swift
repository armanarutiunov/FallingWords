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
