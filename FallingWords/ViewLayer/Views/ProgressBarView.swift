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
    
    func updateScore(_ score: Int) {
        let physicalMax = CGFloat(maxScore * 2)
        let physicalScore = CGFloat(score + maxScore)
        let percentage = physicalScore / physicalMax
        greenWidth.constant = frame.size.width * percentage
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }

}
