//
//  BackgroundAnim.swift
//  Stupid
//
//  Created by Chandan Karmakar on 12/02/18.
//  Copyright © 2018 Kreative Machinez. All rights reserved.
//

import UIKit

class Shapes {
    static func addPulseAnim(view: UIView) {
        let circle1 = CAShapeLayer()
        circle1.fillColor = UIColor.lightGray.cgColor
        circle1.bounds = view.frame
        circle1.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        circle1.path = UIBezierPath(ovalIn: view.frame).cgPath
        
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 0.1
        scale.toValue = 1.0
        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 0.7
        fade.toValue = 0.0
        
        let anim = CAAnimationGroup()
        anim.animations = [scale, fade]
        anim.duration = 2.0
        anim.repeatCount = HUGE
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        circle1.add(anim, forKey: nil)
        view.layer.sublayers?.forEach({ each in
            each.removeFromSuperlayer()
        })
        view.layer.addSublayer(circle1)
    }
    
    static func createDotedShape(view: UIView, rect: CGRect, duration: Double, dash: [Int], scale: CGFloat, lineWidth: CGFloat = 1.0, color: UIColor) {
        let circle1 = CAShapeLayer()
        circle1.lineWidth = lineWidth
        circle1.strokeColor = color.cgColor
        circle1.fillColor = UIColor.clear.cgColor
        circle1.lineDashPattern = dash as [NSNumber]
        
        let startShape = UIBezierPath(ovalIn: rect).cgPath
        circle1.path = startShape
        circle1.bounds = rect
        
        circle1.position = CGPoint(x: view.frame.width / 2, y: view.frame.height)
        
        circle1.transform = CATransform3DMakeScale(scale, scale, 1)
        
        let start = CABasicAnimation(keyPath: "transform.rotation.z")
        start.toValue = 2 * CGFloat.pi
        start.duration = duration
        start.repeatCount = HUGE
        start.fillMode = CAMediaTimingFillMode.forwards
        start.isRemovedOnCompletion = false
        circle1.add(start, forKey: nil)
        
        view.layer.addSublayer(circle1)
    }
    
    static func createRandTriangleAndAnim(view: UIView, bounds: CGRect) {
        let tri = Shapes.triangle(size: 20)
        tri.position = Rand.randPoint(rect: bounds)
        Anim.roteteSelf(shape: tri)
        var didEndMoving: (() -> Void)!
        didEndMoving = {
            Anim.pop(shape: tri, flag: false) {
                Anim.moveRandom(shape: tri, bounds: bounds, didEndMoving)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    Anim.pop(shape: tri, flag: true)
                })
            }
        }
        Anim.moveRandom(shape: tri, bounds: bounds, didEndMoving)
        view.layer.addSublayer(tri)
    }
    
    static func createRandCircleAndAnim(view: UIView, bounds: CGRect) {
        let tri = Shapes.circle(size: 10)
        tri.position = Rand.randPoint(rect: bounds)
        Anim.roteteSelf(shape: tri)
        var didEndMoving: (() -> Void)!
        didEndMoving = {
            Anim.pop(shape: tri, flag: false) {
                Anim.moveRandom(shape: tri, bounds: bounds, didEndMoving)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    Anim.pop(shape: tri, flag: true)
                })
            }
        }
        Anim.moveRandom(shape: tri, bounds: bounds, didEndMoving)
        view.layer.addSublayer(tri)
    }
    
    static func createRandRectAndAnim(view: UIView, bounds: CGRect) {
        let tri = Shapes.rect(size: 10)
        tri.position = Rand.randPoint(rect: bounds)
        Anim.roteteSelf(shape: tri)
        var didEndMoving: (() -> Void)!
        didEndMoving = {
            Anim.pop(shape: tri, flag: false) {
                Anim.moveRandom(shape: tri, bounds: bounds, didEndMoving)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    Anim.pop(shape: tri, flag: true)
                })
            }
        }
        Anim.moveRandom(shape: tri, bounds: bounds, didEndMoving)
        view.layer.addSublayer(tri)
    }
    
    private static func triangle(size: CGFloat, lineWidth: CGFloat = 6, strokeColor: CGColor = Rand.randomColor()) -> CAShapeLayer {
        let tri = CAShapeLayer()
        let bounds = CGRect(x: 0, y: 0, width: size, height: size)
        tri.bounds = bounds
        tri.lineWidth = lineWidth
        tri.lineJoin = CAShapeLayerLineJoin.round
        tri.strokeColor = strokeColor
        tri.fillColor = UIColor.clear.cgColor
        let radius = size / 2
        let path = UIBezierPath()
        let a = size * 3 / 4
        path.move(to: CGPoint(x: radius, y: 0))
        path.addLine(to: CGPoint(x: size, y: a))
        path.addLine(to: CGPoint(x: 0, y: a))
        path.close()
        tri.path = path.cgPath
        return tri
    }
    
    private static func circle(size: CGFloat, lineWidth: CGFloat = 5, strokeColor: CGColor = Rand.randomColor()) -> CAShapeLayer {
        let circle = CAShapeLayer()
        let bounds = CGRect(x: 0, y: 0, width: size, height: size)
        circle.bounds = bounds
        circle.lineWidth = lineWidth
        circle.lineJoin = CAShapeLayerLineJoin.round
        circle.strokeColor = strokeColor
        circle.fillColor = UIColor.clear.cgColor
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size, height: size))
        circle.path = path.cgPath
        return circle
    }
    
    private static func rect(size: CGFloat, lineWidth: CGFloat = 5, strokeColor: CGColor = Rand.randomColor()) -> CAShapeLayer {
        let circle = CAShapeLayer()
        let bounds = CGRect(x: 0, y: 0, width: size, height: size)
        circle.bounds = bounds
        circle.lineWidth = lineWidth
        circle.lineJoin = CAShapeLayerLineJoin.round
        circle.strokeColor = strokeColor
        circle.fillColor = UIColor.clear.cgColor
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: size, height: size))
        circle.path = path.cgPath
        return circle
    }
}

class Anim {
    static func roteteSelf(shape: CAShapeLayer) {
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        let sign: CGFloat = (Rand.randInt() % 2) == 0 ? -1 : +1
        rotate.toValue = 2 * CGFloat.pi * sign
        rotate.duration = Double(Rand.random(from: 50, to: 100))
        rotate.repeatCount = HUGE
        rotate.fillMode = CAMediaTimingFillMode.forwards
        rotate.isRemovedOnCompletion = true
        shape.add(rotate, forKey: nil)
    }
    
    static func moveRandom(shape: CAShapeLayer, bounds: CGRect, _ animationDidStop: (() -> Void)? = nil) {
        let to = Rand.randPoint(rect: bounds)
        let from = Rand.randPoint(rect: bounds)
        
        let move = CABasicAnimation(keyPath: "position")
        // move.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        move.fromValue = from
        move.toValue = to
        let dur = (dist(to, from) * 0.1)
        move.duration = dur // == 0 ? 1.0 : dur
        move.fillMode = CAMediaTimingFillMode.forwards
        move.isRemovedOnCompletion = false
        
        move.delegate = AnimDel(animationDidStop)
        
        shape.add(move, forKey: nil)
    }
    
    static func pop(shape: CAShapeLayer, flag: Bool, _ animationDidStop: (() -> Void)? = nil) {
        let pop = CASpringAnimation(keyPath: "transform.scale")
        pop.fromValue = flag ? 0 : 1
        pop.toValue = flag ? 1 : 0
        pop.duration = 1.2
        pop.fillMode = CAMediaTimingFillMode.forwards
        pop.isRemovedOnCompletion = false
        pop.delegate = AnimDel(animationDidStop)
        shape.add(pop, forKey: nil)
    }
    
    static func dist(_ a: CGPoint, _ b: CGPoint) -> Double {
        let y = (b.y - a.y) * (b.y - a.y)
        let x = (b.x - a.x) * (b.x - a.x)
        return Double(sqrt(x + y))
    }
}

class Rand {
    static func randPoint(rect: CGRect) -> CGPoint {
        return CGPoint(x: random(from: Int(rect.origin.x), to: Int(rect.width + rect.origin.x)), y: random(from: Int(rect.origin.y), to: Int(rect.origin.y + rect.height)))
    }
    
    static func randomColor() -> CGColor {
        return colors[randInt() % colors.count].cgColor
    }
    
    static func random(from: Int, to: Int) -> Int {
        return (randInt() % (abs(to - from))) + from
    }
    
    static let colors: [UIColor] = [UIColor(hex: "1abc9c"),
                                    UIColor(hex: "3498db"),
                                    UIColor(hex: "9b59b6"),
                                    UIColor(hex: "f1c40f"),
                                    UIColor(hex: "e74c3c"),
                                    UIColor(hex: "2c3e50")]
    
    static func randInt() -> Int {
        return Int(arc4random_uniform(UInt32(10000)))
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: origin.x + width / 2, y: origin.y + height / 2)
    }
}

class AnimDel: NSObject, CAAnimationDelegate {
    convenience init(_ animationDidStop: (() -> Void)?) {
        self.init()
        self.animationDidStop = animationDidStop
    }
    
    var animationDidStop: (() -> Void)?
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            animationDidStop?()
        }
    }
}

extension UIColor {
    /* convenience init(hex: String) {
     self.init(hex: hex, alpha: 1)
     } */
    
    convenience init(hex: String, alpha: CGFloat = 1) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = hex.substring(from: hex.characters.index(hex.startIndex, offsetBy: 1))
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt: UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r: UInt32!, g: UInt32!, b: UInt32!
        switch hexWithoutSymbol.count {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break
        default:
            // TODO: ERROR
            break
        }
        
        self.init(
            red: (CGFloat(r) / 255),
            green: (CGFloat(g) / 255),
            blue: (CGFloat(b) / 255),
            alpha: alpha
        )
    }
}
