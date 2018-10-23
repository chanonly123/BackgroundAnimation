//
//  ViewController.swift
//  Background Animation
//
//  Created by Chandan on 23/10/18.
//  Copyright © 2018 Chandan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let gray = UIColor(hex: "DEDDDD")
    let onePixelPoint = 1.0 / UIScreen.main.scale
    
    var animCont: UIView!
    var animContHalf: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnims()
    }


    func startAnims() {
        stopAnims()
        animContHalf = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2))
        animContHalf.clipsToBounds = true
        view.addSubview(animContHalf)
        animCont = UIView(frame: view.bounds)
        view.addSubview(animCont)
        
        view.sendSubviewToBack(animCont)
        view.sendSubviewToBack(animContHalf)
        
        let rect = CGRect(x: 0, y: 0, width: animCont.frame.width, height: animCont.frame.width)
        Shapes.createDotedShape(view: animContHalf, rect: rect, duration: 60 * 3, dash: [1, 5], scale: 1.1, color: gray)
        Shapes.createDotedShape(view: animContHalf, rect: rect, duration: 60 * 1, dash: [1, 10], scale: 1.2, color: UIColor.darkGray)
        Shapes.createDotedShape(view: animContHalf, rect: rect, duration: 60 * 1, dash: [60, 60], scale: 1.55, lineWidth: onePixelPoint, color: UIColor.darkGray)
        let bounds = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        for _ in 1...4 {
            Shapes.createRandTriangleAndAnim(view: animCont, bounds: bounds)
            Shapes.createRandCircleAndAnim(view: animCont, bounds: bounds)
            Shapes.createRandRectAndAnim(view: animCont, bounds: bounds)
        }
    }
    
    func stopAnims() {
        animContHalf?.removeFromSuperview()
        animCont?.removeFromSuperview()
    }
}

