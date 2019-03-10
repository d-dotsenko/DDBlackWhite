//
//  DDBlackWhiteViewController.swift
//  DDBlackWhiteExample
//
//  Created by Dmitriy Dotsenko on 10/03/2019.
//  Copyright © 2019 Dmitriy Dotsenko. All rights reserved.
//

import UIKit
import DDBlackWhite

class DDBlackWhiteViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var valueLabel: UILabel!
    
    public var inputImage:UIImage?
    public var completionClosure: ((UIImage?)->Void)?
    
    private let blackWhite = DDBlackWhite()
    private var previousSliderValue:Float = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        blackWhite.inputImage = inputImage?.fixOrientation()
        blackWhite.brightness = CGFloat(slider.value)
        blackWhite.getFilteredImage { [weak weakSelf = self] (image) in
            weakSelf?.updateImage(image: image)
        }
    }
    
    @objc private func sliderValueChanged() {
        let newValue = roundf(slider.value*10) / 10.0
        slider.value = newValue
        valueLabel.text = String(format: "%.1f", newValue)
        if abs(newValue - previousSliderValue) < 0.1 {
            return
        }
        previousSliderValue = newValue
        blackWhite.brightness = CGFloat(newValue)
        blackWhite.getFilteredImage { [weak weakSelf = self] (image) in
            weakSelf?.updateImage(image: image)
        }
    }
    
    private func updateImage(image: UIImage?) {
        DispatchQueue.main.async { [weak weakSelf = self] in
            weakSelf?.imageView.image = image
            if let closure = weakSelf?.completionClosure {
                closure(image)
            }
        }
    }
}

extension UIImage {
    func fixOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        return self
    }
}
