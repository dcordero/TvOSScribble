//
//  GestureView.swift
//  tvOSScribble
//
//  Created by David Cordero on 13.08.17.
//  Copyright © 2017 David Cordero. All rights reserved.
//

import UIKit

private let lineWidth = CGFloat(100)
private let scaleSize = CGFloat(28)
private let bitsPerComponent = 8

final class GestureView: UIView {
    
    var points = [CGPoint]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard points.count > 1 else { return }
        
        backgroundColor = .white
        let drawPath = UIBezierPath()
        drawPath.move(to: points.first!)
        
        for point in points.dropFirst() {
            drawPath.addLine(to: point)
        }
        
        UIColor.white.setStroke()
        drawPath.lineWidth = lineWidth
        drawPath.stroke()
    }
    
    var context: CGContext? {
        let bitmapInfo = CGImageAlphaInfo.none.rawValue
        
        let context = CGContext(data: nil, width: Int(scaleSize), height: Int(scaleSize), bitsPerComponent: bitsPerComponent, bytesPerRow: Int(scaleSize), space: CGColorSpaceCreateDeviceGray(), bitmapInfo: bitmapInfo)
        
        context!.translateBy(x: 0 , y: scaleSize)
        context!.scaleBy(x: scaleSize/frame.size.width, y: -scaleSize/frame.size.height)
        
        self.layer.render(in: context!)
        
        return context
    }
}
