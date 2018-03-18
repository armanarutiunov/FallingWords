//
//  ProgressBarView.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 17/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit

class ProgressBarView: UIView {

    @IBOutlet weak var greenWidth: NSLayoutConstraint!
    
    private let maxScore = 1000
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        updateScore(0)
        
    }
    
    func updateScore(_ score: Int) {
        let physicalMax = maxScore * 2
        let physicalScore = score + maxScore
        let percentage = CGFloat(physicalScore / physicalMax)
        greenWidth.constant = frame.size.width * percentage
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }

}
