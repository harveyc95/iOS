//
//  ViewController.swift
//  Moon
//
//  Created by Harvey Chen on 2017-11-25.
//  Copyright © 2017 Harvey Chen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var darkBlueBG: UIImageView!
    @IBOutlet weak var powerBtn: UIButton!
    @IBOutlet weak var cloudHolder: UIView!
    @IBOutlet weak var rocket: UIImageView!
    @IBOutlet weak var moonLabel: UILabel!
    
    var player: AVAudioPlayer!
    var timer = Timer()
    let delay = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "Rocket Launch Sound Effect", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        
        print(rocket.frame.origin)
        rocket.frame.origin.y = view.frame.height - 200
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    @IBAction func powerBtnPressed(_ sender: Any) {
        cloudHolder.isHidden = false
        darkBlueBG.isHidden = true
        powerBtn.isHidden = true
        
        player.play()
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(animate), userInfo: nil, repeats: false)
    }
    
    @objc func animate() {
        let animationFunc: () -> () = { self.rocket.frame.origin.y = -self.rocket.frame.height/2 }
        let completeFunc: (Bool)->() = { _ in self.moonLabel.isHidden = false }
        UIView.animate(withDuration: 3, animations: animationFunc, completion: completeFunc)
    }
    
}

