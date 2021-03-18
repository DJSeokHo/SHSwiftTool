//
//  CALItemCollectionViewCell.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2021/03/18.
//  Copyright © 2021 SWein. All rights reserved.
//

import UIKit

protocol CALItemCollectionViewCellDelegate {
    func onClick(_ bean: CALItemBean)
}

class CALItemCollectionViewCell: UICollectionViewCell {

    public static let TAG = "CALItemCollectionViewCell"
    
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    public var delegate: CALItemCollectionViewCellDelegate?
    
    @IBOutlet var viewContent: UIView!
    
    public var bean: CALItemBean!
    
    private var contentLC: NSLayoutConstraint!
    private var labelLC: NSLayoutConstraint!
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentLC = AutoLayoutManager.instance.createLayoutConstraintHeight(view: viewContent)
        labelLC = AutoLayoutManager.instance.createLayoutConstraintHeight(view: label)
        
        viewContent.viewSetOnClickListener(self, action: #selector(onButtonClick))
        
    }
    @objc private func onButtonClick() {
        
        bean.isImage = !bean.isImage
        
        delegate?.onClick(bean)
    }

    public func updateView() {
        label.text = bean.content
        
        let labelHeight = bean.content.height(withConstrainedWidth: DisplayUtil.getFullScreenSize().width - 40, font: UIFont.systemFont(ofSize: 15))
        ILog.debug(tag: #file, content: "labelHeight \(labelHeight)")
        
        viewContent.frame.size = bean.isImage ? CGSize(width: DisplayUtil.getFullScreenSize().width, height: 225 + labelHeight) : CGSize(width: DisplayUtil.getFullScreenSize().width, height: 60)
        label.frame.size = bean.isImage ? CGSize(width: DisplayUtil.getFullScreenSize().width - 20, height: labelHeight) : CGSize(width: DisplayUtil.getFullScreenSize().width - 20, height: 20)
        
        imageView.frame.origin = bean.isImage ? CGPoint(x: 10, y: 60 + labelHeight) : CGPoint(x: 10, y: 60)
        
//        AutoLayoutManager.instance.toggleLayoutConstraintHeight(layoutConstraintHeight: contentLC, operation: bean.isImage, andValueWhenTrueIs: 225 + labelHeight, andValueWhenFalseIs: 60)
//
//        AutoLayoutManager.instance.toggleLayoutConstraintHeight(layoutConstraintHeight: labelLC, operation: bean.isImage, andValueWhenTrueIs: labelHeight, andValueWhenFalseIs: 20)
        
//        AutoLayoutManager.instance.startToggleAnimation(view: contentView, withDuration: 0.3, completion: nil)
//        label.layoutIfNeeded()
//        viewContent.layoutIfNeeded()
//        contentView.layoutIfNeeded()
//        scrollView.setContentOffset(CGPoint.zero, animated: false)
//        scrollView.isScrollEnabled = false
        
    }
    
}
