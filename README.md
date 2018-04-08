
# TvOSScribble

TvOSScribble, based on CoreML, mitigates the lack of a physical numpad area in Siri Remote implementing a handwriting gesture recognizer.

![](Preview.gif)

- Video: https://vimeo.com/229529023
- Post: [Building Scribble for tvOS](https://medium.com/@dcordero/tvosscribble-building-scribble-for-tvos-6f846db7f16d)

## Requirements

- tvOS 11.0+
- Xcode 9.0

## Installation

### CocoaPods

To integrate TvOSScribble into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :tvos, '11.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'TvOSScribble', '~> 0.0.1'
end
```

## Usage

All you need is to add TvOSScribbleGestureRecognizer to the view in which you want to scribble:


```swift
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
```

## Contribute

We would love for you to contribute to **TvOSScribble**, check the ``LICENSE`` file for more info. Feel free to submit any issues or PRs. ❤️

## Meta

Special thanks to [@r4ghu](https://github.com/r4ghu) for his fantastic article on [COMPUTER VISION IN IOS – COREML+KERAS+MNIST](https://sriraghu.com/2017/07/06/computer-vision-in-ios-coremlkerasmnist/).

David Cordero – [@dcordero](https://twitter.com/dcordero)

Distributed under the MIT license. See ``LICENSE`` for more information.

