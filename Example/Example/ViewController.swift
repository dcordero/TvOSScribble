//
//  ViewController.swift
//  Example
//
//  Created by David Cordero on 13.08.17.
//  Copyright © 2017 David Cordero. All rights reserved.
//
import UIKit
import TvOSScribble

class ViewController: UIViewController {
    
    @IBOutlet private weak var predictionLabel: UILabel!
    @IBOutlet private weak var gestureImage: UIImageView!
    
    override func viewDidLoad() {
        let gestureRecognizer = TvOSScribbleGestureRecognizer(target: self, action: #selector(ViewController.gestureDidRecognize))
        
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func gestureDidRecognize(recognizer: TvOSScribbleGestureRecognizer) {
        guard recognizer.state == .ended else { return }
        
        gestureImage.image = recognizer.image
        predictionLabel.text = recognizer.result
    }
}
