//
//  ViewController.swift
//  BullsEye
//
//  Created by Biao on 9/29/17.
//  Copyright © 2017 Biao. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        //let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        /*
        let alert = UIAlertController(title: "Hello World", message: "This is my first app!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: nil);
        
        alert.addAction(action);
        
        present(alert, animated: true, completion: nil);
         */
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        
        if (difference == 0) {
            title = "Perfect!"
            points += 100
        } else if (difference < 5) {
            title = "You almost had it!"
            if (difference == 1) {
                points += 50
            }
        } else if (difference < 10) {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        score += points
        /*
        let message = "The value of the slider is: \(currentValue)" +
                      "\nThe target value is: \(targetValue)"
        */
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert);
        
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: {
                                        action in self.startNewRound()
                                });
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
        //print("Slider value \(currentValue)")
    }
    
    @IBAction func startOver() {
        startNewGame()
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()

        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}
