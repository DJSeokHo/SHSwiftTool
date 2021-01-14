//
//  KAPictureResultViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/06.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class KAPictureResultViewController: UIViewController {

    public var capturedImage: UIImage?
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        if capturedImage == nil {
            NavigationUtil.navigationToPrev(from: self, animated: true)
        }
        
        imageView.image = capturedImage!
        
    }

    /// white status bar text color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    @IBAction func onButtonBackClick(_ sender: Any) {
        NavigationUtil.navigationToPrev(from: self, animated: true)
    }
    
    @IBAction func onButtonConfirmClick(_ sender: Any) {
        
        var userInfo = Dictionary<AnyHashable, Any>()
        userInfo["image"] = capturedImage!
           
        NotificationUtil.post(name: KANotificationConstants.REQUEST_CONFRIM_IMAGE, userInfo: userInfo)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
