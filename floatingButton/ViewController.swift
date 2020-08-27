//
//  ViewController.swift
//  floatingButton
//
//  Created by jangmi on 2020/08/27.
//  Copyright © 2020 jangmi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FloatingButtonDelegate {

    @IBOutlet weak var floatingButton: FloatingButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.floatingButton.delegate = self;
        self.floatingButton.setMenuButonImages(images: ["police", "ice", "kuma"])
//        self.floatingButton.layer.cornerRadius = 0.5 * self.floatingButton.frame.size.width
    }
    
    func clikcedFloatingButtonIndex(index: Int) {
        
    }
}

