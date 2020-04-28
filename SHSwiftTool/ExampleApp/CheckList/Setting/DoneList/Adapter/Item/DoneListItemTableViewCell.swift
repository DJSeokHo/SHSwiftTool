//
//  DoneListItemTableViewCell.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/29.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class DoneListItemTableViewCell: UITableViewCell {
    
    public static let TAG = "DoneListItemTableViewCell"

    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    
    public var checkInfoBean: CheckInfoBean!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setListener()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setListener() {
        
        button.addTarget(self, action: #selector(onButtonCheckClick), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc private func onButtonCheckClick(_ sender: UIButton) {
        
        if checkInfoBean == nil {
            
            return
        }
       
        var userInfo = Dictionary<AnyHashable, Any>()
        userInfo["checkInfoBean"] = checkInfoBean
        
        NotificationUtil.post(name: CLNotificationConstants.REQUEST_UN_FINISH_LIST_ITEM, object: self, userInfo: userInfo)
        
        ILog.debug(tag: DoneListItemTableViewCell.TAG, content: checkInfoBean.toString()!)
    }
    
    public func updateView() {
        label.text = checkInfoBean.content
        
        if checkInfoBean.done == "Y" {
            button.setImage(UIImage(named: "icon_check.png"), for: UIControl.State.normal)
        }
        else {
            button.setImage(UIImage(named: "icon_un_check.png"), for: UIControl.State.normal)
        }
    }
    
}
