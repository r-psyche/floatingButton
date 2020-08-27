//
//  File.swift
//  floatingButton
//
//  Created by jangmi on 2020/08/27.
//  Copyright © 2020 jangmi. All rights reserved.
//

import UIKit

protocol FloatingButtonDelegate {
    func clikcedFloatingButtonIndex(index: Int)
}

class FloatingButton: UIButton {

    public var delegate: FloatingButtonDelegate?
    private var menuButtonSpacing: CGFloat = 10.0
    private var menuButtonImages: Array<String> = []
    private var menuButtonCount = 0
    private var menuButtons: Array<UIButton> = []
    private var buttonOrigin: CGPoint!
    private var buttonSize: CGSize!
    private var dimmedView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.setupFloatingButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupFloatingButton()
    }
    
    private func setupFloatingButton() {
        self.addTarget(self, action: #selector(self.touchedFloatingButton), for: .touchUpInside)
        let tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.tintColor = tintColor
    }
    
    private func setupDimmedView() {
        self.dimmedView = UIView()
        self.dimmedView.frame = superview!.frame
        self.dimmedView.backgroundColor = UIColor.black
        self.dimmedView.alpha = 0.5
    }
    
    public func setMenuButonImages(images:Array<String>) {
        self.menuButtonImages = images;
        self.menuButtonCount = images.count
        self.buttonOrigin = self.frame.origin
        self.buttonSize = self.frame.size
    }
    
    @objc
    func touchedFloatingButton() {
        if menuButtonCount > 0, self.isSelected == false {
            drawButtons()
            self.isSelected = true
        } else {
            dismissButons()
            self.isSelected = false
        }
    }
    
    private func drawButtons() {
        self.setupDimmedView()
        superview!.insertSubview(self.dimmedView, at: 0)
        
        UIView.animate(withDuration: 0.1 * Double(self.menuButtonCount), delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .beginFromCurrentState], animations: {
            for buttonCount in 0..<self.menuButtonCount {
                let buttonX = self.buttonOrigin.x
                let buttonHeight = (self.buttonSize.height + self.menuButtonSpacing) * CGFloat(buttonCount + 1)
                let buttonY = self.buttonOrigin.y
                let buttonNewY = self.buttonOrigin.y - buttonHeight
                
                let menuButton = UIButton(frame: CGRect(x: buttonX,
                                                        y: buttonY,
                                                        width: self.buttonSize.width,
                                                        height: self.buttonSize.height))
                menuButton.setImage(UIImage(named: self.menuButtonImages[buttonCount]), for: .normal)
                menuButton.layer.cornerRadius = self.layer.cornerRadius
                menuButton.clipsToBounds = true;
                menuButton.addTarget(self, action: #selector(self.clikcedMenuButton), for: .touchUpInside)
                menuButton.tag = buttonCount + 10
        
                self.superview?.addSubview(menuButton)
                
                UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut, .beginFromCurrentState, .overrideInheritedCurve], animations: {
                    menuButton.alpha = 1
                    menuButton.layer.cornerRadius = self.layer.cornerRadius
                    menuButton.clipsToBounds = true;
                    menuButton.frame = CGRect(x: buttonX,
                                              y: buttonNewY,
                                              width: self.buttonSize.width,
                                              height: self.buttonSize.height)
                }, completion: nil)

            }
        }, completion: nil)
    }
    
    private func dismissButons() {
        UIView.animate(withDuration: 0.1 * Double(self.menuButtonCount), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .beginFromCurrentState], animations: {
            for buttonCount in 0..<self.menuButtonCount {
                let button:UIButton = (self.superview!.viewWithTag(buttonCount + 10) as? UIButton)!
                
                UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut, .beginFromCurrentState, .overrideInheritedCurve], animations: {
                    let buttonX = self.buttonOrigin.x
                    let buttonY = self.buttonOrigin.y
                    let buttonNewY = buttonY - (self.buttonSize.height / 2)
                    
                    button.alpha = 1
                    button.frame = CGRect(x: buttonX,
                                          y: buttonNewY,
                                          width: self.buttonSize.width,
                                          height: self.buttonSize.height)
                    button.alpha = 0.0
                }, completion: { finished in
                    button.removeFromSuperview()
                    self.dimmedView.removeFromSuperview()
                })

            }
        }, completion: nil)
        
    }
    
    @objc
    private func clikcedMenuButton() {
        
    }
}
