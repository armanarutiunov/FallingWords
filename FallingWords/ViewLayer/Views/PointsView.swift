//
//  PointsView.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 18/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit

class PointsView: UIView {

    @IBOutlet weak var translationLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        translationLabel.text = ""
    }
    
    func newFall(with word: String, duration: CFTimeInterval) {
        translationLabel.text = word
        let animation = CABasicAnimation()
        animation.keyPath = "position"
        animation.fromValue = translationLabel.layer.value(forKey: "position")
        let finishPoint = CGPoint(x: translationLabel.frame.origin.x,
                                  y: frame.size.height)
        animation.toValue = NSValue(cgPoint: finishPoint)
        animation.duration = duration
        animation.repeatCount = 1
        animation.autoreverses = false
        translationLabel.layer.add(animation, forKey: animation.keyPath!)
    }
    
    func stopFalling() -> Int {
        let y = translationLabel.frame.origin.y
        translationLabel.layer.removeAllAnimations()
        let zoneHeight = frame.size.height / 5
        if y > zoneHeight * 4 { return 10 }
        else if y > zoneHeight * 3 { return 30 }
        else if y > zoneHeight * 2 { return 50 }
        else if y > zoneHeight { return 70 }
        else { return 100 }
    }

}
