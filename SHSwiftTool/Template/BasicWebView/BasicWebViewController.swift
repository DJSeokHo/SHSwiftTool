//
//  BasicWebViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2019/11/01.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class BasicWebViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate {

    @IBAction func onButtonCloseClick(_ sender: UIButton) {
        ViewControllerUtil.finishSelf(view: self)
    }

    @IBAction func onButtonPrevClick(_ sender: UIButton) {
        
        if(webView.canGoBack) {
            webView.goBack()
        }
    }
    
    @IBAction func onButtonNextClick(_ sender: Any) {
        
        if(webView.canGoForward) {
            webView.goForward()
        }
    }
    
    @IBAction func onButtonRefreshClick(_ sender: Any) {
        
        webView.reload()
    }
    
    @IBAction func onButtonStopClick(_ sender: Any) {
        
        webView.stopLoading()
        activityIndicator.stopAnimating()
    }
    
    @IBAction func onButtonGoClick(_ sender: Any) {
       go()
    }
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var textField: UITextField!
    
    
    private var activityIndicator:UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        let fullScreenSize = DisplayUtil.getFullScreenSize()
        
        activityIndicator = UIActivityIndicatorView(style:.gray)
        
        activityIndicator.center = CGPoint(x: fullScreenSize.width * 0.5, y: fullScreenSize.height * 0.5)
        self.view.addSubview(activityIndicator);
        
        textField.delegate = self
        webView.delegate = self
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        go()
        return true
    }
    
    private func go() {
        self.view.endEditing(true)
               
        let url = URL(string: textField.text!)
        let urlRequest = URLRequest(url: url!)
        webView.loadRequest(urlRequest)
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    /*
     如果网页有跳转，把跳转后的网址重新设置在输入窗里
     */
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
        
        let currentURL = webView.request?.url?.absoluteString
        textField.text = currentURL
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
