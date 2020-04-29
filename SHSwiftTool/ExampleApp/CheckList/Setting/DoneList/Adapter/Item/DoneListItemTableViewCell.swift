//
//  DoneListItemTableViewCell.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/29.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class DoneListItemTableViewCell: UITableViewCell, ICell {
    
    public static let TAG = "DoneListItemTableViewCell"

    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    
    public var iBean: IBean!
    
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
        
        if iBean == nil {
            
            return
        }
       
        var userInfo = Dictionary<AnyHashable, Any>()
        userInfo["iBean"] = iBean

        NotificationUtil.post(name: CLNotificationConstants.REQUEST_UN_FINISH_LIST_ITEM, object: self, userInfo: userInfo)

        ILog.debug(tag: DoneListItemTableViewCell.TAG, content: iBean.toString())
    }
    
    func setData(iBean: IBean) {
        self.iBean = iBean
    }
    
    func updateView() {
        
        let checkInfoBean: CheckInfoBean = iBean as! CheckInfoBean
        
        label.text = checkInfoBean.content
        
        if checkInfoBean.done == "Y" {
            button.setImage(UIImage(named: "icon_check.png"), for: UIControl.State.normal)
        }
        else {
            button.setImage(UIImage(named: "icon_un_check.png"), for: UIControl.State.normal)
        }
    }
    
}
