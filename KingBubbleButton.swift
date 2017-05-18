//
//  KingBubbleButton.swift
//
//  Created by Purkylin King on 2017/5/17.
//  Copyright © 2017年 hujiang.com. All rights reserved.
//

import UIKit

extension UIImage {
    func bubbleResize(sz: CGSize) -> UIImage {
        if sz.width < self.size.width {
            return self
        }
        
        if sz.height < self.size.height / 2 {
            return self;
        }
        
        // 设置左拉伸
        let leftImage = self.stretchableImage(withLeftCapWidth: Int(self.size.width * 0.4), topCapHeight: Int(self.size.height * 0.5))
        // 设置右拉伸
        let rightImage = self.stretchableImage(withLeftCapWidth: Int(self.size.width * 0.6), topCapHeight: Int(self.size.height * 0.5))
        // 单侧拉伸宽度
        let stretchWidth = (sz.width - self.size.width) / 2.0
        
        // 叠加
        UIGraphicsBeginImageContextWithOptions(sz, false, self.scale)
        leftImage.draw(in: CGRect(x: 0, y: 0, width: self.size.width + stretchWidth, height: sz.height))
        rightImage.draw(in: CGRect(x: sz.width - self.size.width - stretchWidth, y: 0, width: self.size.width + stretchWidth, height: sz.height))
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result!
    }
}

class KingBubbleButton: UIButton {

    private var originImage: UIImage?
    
    override var bounds: CGRect {
        didSet {
            if let image = self.originImage {
                if image.size.width < bounds.size.width {
                    self.setBackgroundImage(self.originImage?.bubbleResize(sz: bounds.size), for: .normal)
                }
            }
        }
    }
    
    override func setBackgroundImage(_ image: UIImage?, for state: UIControlState) {
        if (state == .normal) {
            if (self.backgroundImage(for: .normal) == nil) {
                self.originImage = image
            }
        }
        super.setBackgroundImage(image, for: .normal)
    }
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        if (state == .normal) {
            self.setBackgroundImage(originImage, for: .normal)
        }
        
        super.setTitle(title, for: .normal)
    }
}
