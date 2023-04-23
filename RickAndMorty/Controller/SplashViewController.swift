//
//  SplashViewController.swift
//  RickAndMorty
//
//  Created by Mac on 21.04.2023.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var splashLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the initial alpha value of the image view to 0
        imageView.alpha = 0
        
        // Do any additional setup after loading the view.
        splashLabel.text = ""
        var titleText = ""
        if UserDefaults.standard.bool(forKey: "HasLaunchedBefore") {
            titleText = "Hello"
        } else {
            titleText = "Welcome"
            UserDefaults.standard.set(true, forKey: "HasLaunchedBefore")
        }
        var charIndex = 0.0
        
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { timer in
                self.splashLabel.text?.append(letter)
            }
            charIndex += 1
        }
        
        // Animate the image view alpha to 1
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseInOut, animations: {
            self.imageView.alpha = 1
        }, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! UINavigationController
            
            mainVC.modalPresentationStyle = .fullScreen
            mainVC.modalTransitionStyle = .flipHorizontal
            self.present(mainVC, animated: true) {
                UIView.animate(withDuration: 1.0, delay: 0.5, options: .autoreverse) {
                    self.view.alpha = 0
                }
            }
        }
    }
}

