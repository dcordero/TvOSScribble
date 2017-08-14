//
//  TvOSScribbleGestureRecognizer.swift
//  tvOSScribble
//
//  Created by David Cordero on 15.05.17.
//  Copyright © 2017 David Cordero. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

private let trackpadSize = CGSize(width: 1920, height: 1080)

public class TvOSScribbleGestureRecognizer: UIGestureRecognizer {

    private(set) public var result: String?
    private(set) public var image: UIImage?
    
    private let model = ScribbleModel()

    private var path = [CGPoint]()
    
    private var minX: CGFloat = 0
    private var maxX: CGFloat = 0
    private var minY: CGFloat = 0
    private var maxY: CGFloat = 0
    
    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        allowedTouchTypes = [NSNumber(value: UITouchType.indirect.rawValue)]
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetPath()
        trackTouch(touch: touches.first)
        state = .began
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        path.removeAll()
        state = .cancelled
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        trackTouch(touch: touches.first)
        state = .changed
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        trackTouch(touch: touches.first)
        let horizontalPadding = (trackpadSize.width - gestureBounds.width) / 2
        let verticalPadding = (trackpadSize.width - gestureBounds.height) / 2
        let boundedPath = path.map { CGPoint(x: $0.x - gestureBounds.minX + horizontalPadding, y: $0.y - gestureBounds.minY + verticalPadding) }
        result = recognize(path: boundedPath)
        state = result != nil ? .ended : .failed
    }
    
    // MARK: Private
    
    private func recognize(path: [CGPoint]) -> String? {
        let gestureView = GestureView(frame: CGRect(x: 0, y: 0, width: trackpadSize.width, height: trackpadSize.width))
        gestureView.points = path
        let context = gestureView.context
        if let inputImage = context?.makeImage() {
            let gestureImage = UIImage(cgImage: inputImage)
            image = gestureImage
            let pixelBuffer = gestureImage.pixelBuffer()
            return try? model.prediction(image: pixelBuffer!).classLabel
        }
        return nil
    }
    
    private func trackTouch(touch: UITouch?) {
        guard let touchLocation = touch?.location(in: view) else { return }
        let absoluteLocation = CGPoint(x: touchLocation.x - trackpadSize.width / 2,
                                       y: touchLocation.y - trackpadSize.height / 2)
        path.append(absoluteLocation)
        adjustGestureBounds(with: absoluteLocation)
    }
    
    private func adjustGestureBounds(with point: CGPoint) {
        minX = min(point.x, minX)
        minY = min(point.y, minY)
        maxX = max(point.x, maxX)
        maxY = max(point.y, maxY)
    }

    private var gestureBounds: CGRect {
        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
    
    private func resetPath() {
        path = []
        result = nil
        image = nil
        minX = 0
        maxX = 0
        minY = 0
        maxY = 0
    }
}
