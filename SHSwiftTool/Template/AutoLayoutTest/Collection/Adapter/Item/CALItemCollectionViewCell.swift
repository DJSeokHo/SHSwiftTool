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
    func onButton(_ bean: CALItemBean)
}

class CALItemCollectionViewCell: UICollectionViewCell {

    public static let TAG = "CALItemCollectionViewCell"
    
    @IBOutlet var label: UILabel!
    
    public var delegate: CALItemCollectionViewCellDelegate?
    
    @IBOutlet var viewContent: UIView!
    @IBOutlet var button: UIButton!
    @IBOutlet var stackView: UIStackView!
    
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
        
//        viewContent.viewSetOnClickListener(self, action: #selector(onItemClick))
        
        button.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
            
    }
    @objc private func onItemClick() {
        delegate?.onClick(bean)
    }
    @objc private func onButtonClick() {
        createView()
        delegate?.onButton(bean)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func createView() {
           
        let view = UIView()
        view.frame.size = CGSize(width: DisplayUtil.getFullScreenSize().width, height: 40)
        
        if bean.list.count % 2 == 0 {
               view.backgroundColor = UIColor.blue
        }
        else {
           view.backgroundColor = UIColor.black
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
       
        bean.list.append(view)
      
        
        bean.viewHeight += 40
        bean.stackViewHeight += 40
//       stackView.frame.size = CGSize(width: stackView.frame.width, height: CGFloat(20 * i))
//       viewContent.frame.size = CGSize(width: viewContent.frame.width, height: viewContent.frame.height + 20)
//       i += 1
    }
    
    public func updateView() {
//        ILog.debug(tag: #file, content: "update View \(40 + 40 * viewList.count)")
        label.text = bean.content
        ILog.debug(tag: #file, content: "??? stack height \(bean.stackViewHeight)")
        
        stackView.frame = CGRect(x: 10, y: 52, width:  DisplayUtil.getFullScreenSize().width - 20, height: bean.stackViewHeight)
        
        ILog.debug(tag: #file, content: "!!! \(stackView.frame.width) \(stackView.frame.height)")
        
       
        for i in 0..<bean.list.count {
            stackView.addArrangedSubview(bean.list[i])
        }
//        let labelHeight = bean.content.height(withConstrainedWidth: DisplayUtil.getFullScreenSize().width - 40, font: UIFont.systemFont(ofSize: 15))
//        ILog.debug(tag: #file, content: "labelHeight \(labelHeight)")
//        
//        viewContent.frame.size = bean.isImage ? CGSize(width: DisplayUtil.getFullScreenSize().width, height: 225 + labelHeight) : CGSize(width: DisplayUtil.getFullScreenSize().width, height: 60)
//        label.frame.size = bean.isImage ? CGSize(width: DisplayUtil.getFullScreenSize().width - 20, height: labelHeight) : CGSize(width: DisplayUtil.getFullScreenSize().width - 20, height: 20)
//        
//        imageView.frame.origin = bean.isImage ? CGPoint(x: 10, y: 60 + labelHeight) : CGPoint(x: 10, y: 60)
        
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
