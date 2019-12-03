//
//  CustomImageTitleButton.swift
//
//  自定义图片和文字的位置,默认所有文字和图片都是居中
//
//  Created by 王萌 on 2019/7/29.
//  Copyright © 2019年 WANGMENG. All rights reserved.
//

import UIKit

enum imageTitleType: Int {
    case topImageBottomTitle = 0    //图片在上文字在下
    case topTitleBottomImage    //文字在上图片在下
    case leftTitleRightImage    //文字在左图片在右
    case leftImageRightTitle    //图片在左文字在右(默认情况)
}

class CustomImageTitleButton: UIButton {
 
    /// 只需要修改type而不需要修改space时, 可直接set此属性, 会默认把space置为0
    var type: imageTitleType = .leftImageRightTitle {
        didSet {
            resetEdgeInsets(type: type)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
        assert(self.imageView != nil, "没设置self.imageView")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        resetEdgeInsets(type: type)
        
        super.updateConstraints()
    }
    
    /// 重置edgeinsets
    ///
    /// - Parameters:
    ///   - type: 图片文字位置类型
    ///   - space: 图片文字间距
    func resetEdgeInsets(type: imageTitleType, space: CGFloat = 0.0) {
        
        let imageWidth = self.imageView!.frame.width
        let imageHeight = self.imageView!.frame.height
        
        var labelWidth = self.titleLabel!.frame.width
        var labelHeight = self.titleLabel!.frame.height
        
//        assert((imageWidth + labelWidth) > self.frame.width && (imageHeight + labelHeight) > self.frame.height, "button frame过小")
        
        if #available(iOS 8.0, *) {
            //高于 iOS 8.0
            labelWidth = self.titleLabel!.intrinsicContentSize.width
            labelHeight = self.titleLabel!.intrinsicContentSize.height
        }
        
        var titleTop, titleLeft, titleBottom, titleRight: CGFloat
        var imageTop, imageLeft, imageBottom, imageRight: CGFloat
        switch type {
        case .leftImageRightTitle:
            imageTop = 0
            imageBottom = 0
            imageLeft = -space / 2.0
            imageRight = -imageLeft
            
            titleTop = 0
            titleBottom = 0
            titleLeft = space / 2.0
            titleRight = titleLeft
            
        case .leftTitleRightImage:
            imageTop = 0
            imageBottom = 0
            imageLeft = labelWidth + space / 2.0
            imageRight = -imageLeft
            
            titleTop = 0
            titleBottom = 0
            titleLeft = -(imageWidth + space / 2.0)
            titleRight = -titleLeft
            
        case .topTitleBottomImage:
            imageTop = labelHeight / 2.0 + space / 2.0
            imageBottom = -imageTop
            imageLeft = (imageWidth + labelWidth) / 2.0 - imageWidth / 2.0
            imageRight = -imageLeft
            
            titleTop = -(imageHeight / 2.0 + space / 2.0)
            titleBottom = -titleTop
            //titleLeft偏移量 = imageWidth + labelWidth / 2.0 - (imageWidth + labelWidth) / 2.0, 计算之后为 imageWidth / 2.0
            titleLeft = -imageWidth / 2.0
            titleRight = -titleLeft
            
        case .topImageBottomTitle:
            imageTop = -(labelHeight / 2.0 + space / 2.0)
            imageBottom = -imageTop
            imageLeft = (imageWidth + labelWidth) / 2.0 - imageWidth / 2.0
            imageRight = -imageLeft
            
            titleTop = imageHeight / 2.0 + space / 2.0
            titleBottom = -titleTop
            //titleLeft偏移量 = imageWidth + labelWidth / 2.0 - (imageWidth + labelWidth) / 2.0, 计算之后为 imageWidth / 2.0
            titleLeft = -imageWidth / 2.0
            titleRight = -titleLeft
        }
        self.imageEdgeInsets = UIEdgeInsets(top: imageTop, left: imageLeft, bottom: imageBottom, right: imageRight)
        self.titleEdgeInsets = UIEdgeInsets(top: titleTop, left: titleLeft, bottom: titleBottom, right: titleRight)
    }
}
