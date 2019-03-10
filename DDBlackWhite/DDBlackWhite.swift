/*
 The MIT License (MIT)
 
 Copyright (c) 2019 Dmitriy Dotsenko
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

open class DDBlackWhite: NSObject {
    
    /// MARK: - Public VARs
    
    /*
     The filter image
     */
    open var inputImage: UIImage? {
        didSet {
            guard let image = inputImage else {
                return
            }
            ciImage = CIImage(image: image)
            setupFilter()
            reset()
        }
    }
    
    /*
     The filtered image
     */
    open private(set) var outputImage: UIImage?
    
    /*
     The filter brightness value (0.0 ... 1.0)
     Default is 0.5
     */
    open var brightness: CGFloat = 0.5 {
        didSet {
            reset()
        }
    }
    
    /// MARK: - Private VARs
    
    private var filter: CIFilter?
    private var ciImage: CIImage?
    
    /// MARK: - Public
    
    open func getFilteredImage(closure: @escaping (UIImage?)->Void) {
        DispatchQueue.global(qos: .background).async { [weak weakSelf = self] in
            guard let strongSelf = weakSelf else {
                return
            }
            if let outputImageCI = strongSelf.filter?.outputImage {
                if let outputImageCG = CIContext(options: nil).createCGImage(outputImageCI, from: outputImageCI.extent) {
                    strongSelf.outputImage = UIImage(cgImage: outputImageCG)
                    guard let image = strongSelf.outputImage else {
                        closure(nil)
                        return
                    }
                    closure(image)
                }
            }
        }
    }
    
    /// MARK: - Private
    
    private func setupFilter() {
        filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(1.0, forKey: "inputIntensity")
    }
    
    private func reset() {
        filter?.setValue(CIColor(red: brightness, green: brightness, blue: brightness), forKey: "inputColor")
    }
}
