//
//  BasicTableViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2019/11/03.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class BasicTableViewController: UIViewController {//}, UITableViewDelegate, UITableViewDataSource {
   
    @IBAction func onButtonCloseClick(_ sender: UIButton) {
        ViewControllerUtil.finishSelf(view: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       <#code#>
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
