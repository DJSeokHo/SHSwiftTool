//
//  BasicTableViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2019/11/03.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class BasicTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBAction func onButtonCloseClick(_ sender: UIButton) {
        ViewControllerUtil.finishSelf(view: self)
    }
    
    private var info = [
        ["红烧肉","红烧带鱼"],
        ["干锅鸡","麻婆豆腐","炖鸡火锅","牛油火锅"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let fullScreenSize = DisplayUtil.getFullScreenSize()
        
        // 建立一个 table view
        let tableView = UITableView(
            frame: CGRect(x: 0, y: 20, width: fullScreenSize.width, height: fullScreenSize.height - 20),
            style: UITableView.Style.grouped
        )
        
        // 注册 cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // 设置委托
        tableView.delegate = self
        tableView.dataSource = self
        
        // 设置分割线样式
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        
        // 设置分割线和四周的距离
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        // 是否可以选择 cell
        tableView.allowsSelection = true
        
        // 是否可以多选 cell
        tableView.allowsMultipleSelection = false
        
        self.view.addSubview(tableView)
    }

    // 委托方法，每一组有几个 cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    // 委托方法，每个 cell 要显示的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
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
