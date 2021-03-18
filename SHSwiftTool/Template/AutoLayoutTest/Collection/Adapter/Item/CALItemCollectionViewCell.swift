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
    
    @IBOutlet var button: UIButton!
    
    public var delegate: CALItemCollectionViewCellDelegate?
    
    @IBOutlet var viewContent: UIView!
    
    public var bean: CALItemBean!
    
    private var contentLC: NSLayoutConstraint!
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentLC = AutoLayoutManager.instance.createLayoutConstraintHeight(view: viewContent)
        
        button.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
        
        scrollView.isScrollEnabled = false
        
    }
    @objc private func onButtonClick() {
        delegate?.onClick(bean)
    }

    public func updateView() {
        label.text = bean.content
        
        AutoLayoutManager.instance.toggleLayoutConstraintHeight(layoutConstraintHeight: contentLC, plusWillBeTrueAndMinusWillBeFalse: bean.isImage, andValueWhenTrueIs: 225, andValueWhenFalseIs: 60)
        
        AutoLayoutManager.instance.startToggleAnimation(view: viewContent, withDuration: 0.3, completion: nil)
        
        scrollView.isScrollEnabled = bean.isImage ? true : false
        
    }
    
}
