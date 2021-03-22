//
//  MainViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 21/06/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private static let TAG = "MainViewController"
    
    private var navigationBarViewHolder: NavigationBarViewHolder?
    
    public var width: CGFloat?
    
    @IBOutlet var buttonBasicUIViewController: UIButton!
    @IBOutlet var buttonBasicNavigationController: UIButton!
    @IBOutlet var buttonLogin: UIButton!
    @IBOutlet var buttonCamera: UIButton!
    @IBOutlet var buttonBasicLabel: UIButton!
    @IBOutlet var buttonBasicTextField: UIButton!
    @IBOutlet var buttonBasicTextView: UIButton!
    @IBOutlet var buttonBasicButton: UIButton!
    @IBOutlet var buttonBasicAlert: UIButton!
    @IBOutlet var buttonBasicImage: UIButton!
    @IBOutlet var buttonBasicDatePicker: UIButton!
    @IBOutlet var buttonBasicPicker: UIButton!
    @IBOutlet var buttonBasicPickerDemo: UIButton!
    @IBOutlet var buttonBasicSwitch: UIButton!
    @IBOutlet var buttonSegment: UIButton!
    @IBOutlet var buttonProgress: UIButton!
    @IBOutlet var buttonBasicSlider: UIButton!
    @IBOutlet var buttonStepper: UIButton!
    @IBOutlet var buttonBasicWebView: UIButton!
    @IBOutlet var buttonBasicTableView: UIButton!
    @IBOutlet var buttonBasicGroupTableView: UIButton!
    @IBOutlet var buttonBasicScrollView: UIButton!
    @IBOutlet var buttonClose: UIButton!
    @IBOutlet var buttonBaseicConsoleTest: UIButton!
    @IBOutlet var buttonBasicCollectionView: UIButton!
    @IBOutlet var buttonBasicSearchView: UIButton!
    @IBOutlet var buttonBasicScrollBigView: UIButton!
    @IBOutlet var buttonBasicPage: UIButton!
    @IBOutlet var buttonSimpleAnimation: UIButton!
    @IBOutlet var buttonSQLite: UIButton!
    @IBOutlet var buttonKeepAccount: UIButton!
    @IBOutlet var buttonBasicPageController: UIButton!
    @IBOutlet var buttonBasicCustomCamera: UIButton!
    @IBOutlet var buttonBasicAlumbPicker: UIButton!
    @IBOutlet var buttonIG: UIButton!
    @IBOutlet var buttonAuto: UIButton!
    @IBOutlet var buttonAutoScroll: UIButton!
    
    @IBAction func onButtonTestClick(_ sender: UIButton) {
      
        let testWebViewController: TestWebViewController = TestWebViewController()
        ViewControllerUtil.startNewFullScreenViewController(from: self, target: testWebViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        ILog.debug(tag: MainViewController.TAG, content: "viewDidLoad")
        
        setListener()

        var resultMapParent = [String: Any]()
        
        var resultMap = [String: Any]()
        resultMap["keyA"] = "valueA"
        resultMap["keyB"] = "valueB"
        resultMap["keyC"] = "valueC"
        resultMap["keyD"] = "valueD"
        
        resultMapParent["resultMap"] = resultMap
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: resultMapParent,
            options: []) {
                let theJSONText = String(data: theJSONData, encoding: .ascii)
                print("JSON string = \(theJSONText!)")
        }
        
        ThreadUtil.startThread {
            ThreadUtil.startUIThread(runnable: {
                
//                let autoLayoutScrollViewController = AutoLayoutScrollViewController()
//                ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: autoLayoutScrollViewController)
                
                
//                let viewController = AutoLayoutScrollWithoutStackViewController()
//                ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: viewController)
//                
//                let viewController = AutoLayoutTestViewController()
//                ViewControllerUtil.startNewFullScreenViewController(from: self, target: viewController)
                
                let viewController = StackViewTestViewController()
                ViewControllerUtil.startNewFullScreenViewController(from: self, target: viewController)
//                let viewController = CollectionAutoLayoutViewController()
//                ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: viewController)
                
//                let viewController = DynamicStackViewViewController()
//                ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: viewController)
                
            }, afterSeconds: 1)
        }
    
    }
    
    
    private func setListener() {
        buttonBasicUIViewController.addTarget(self, action: #selector(self.onButtonBasicUIViewControllerClick(_:)), for: UIControl.Event.touchUpInside)

        buttonBasicNavigationController.addTarget(self, action: #selector(self.onButtonBasicNavigationControllerClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonLogin.addTarget(self, action: #selector(self.onButtonLoginClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonCamera.addTarget(self, action: #selector(self.onButtonCameraClick(_:)), for: UIControl.Event.touchUpInside)
    
        buttonBasicLabel.addTarget(self, action: #selector(self.onButtonBasicLabelClick(_:)), for: UIControl.Event.touchUpInside)
    
        buttonBasicTextField.addTarget(self, action: #selector(self.onButtonBasicTextFieldClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicTextView.addTarget(self, action: #selector(self.onButtonBasicTextViewClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicButton.addTarget(self, action: #selector(self.onButtonBasicButtonClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicAlert.addTarget(self, action: #selector(self.onButtonBasicAlertClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicImage.addTarget(self, action: #selector(self.onButtonBasicViewClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicDatePicker.addTarget(self, action: #selector(self.onButtonBasicDatePickerClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicPicker.addTarget(self, action: #selector(self.onButtonBasicPickerClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicPickerDemo.addTarget(self, action: #selector(self.onButtonBasicPickerDemoClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicSwitch.addTarget(self, action: #selector(self.onButtonBasicSwitchClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonSegment.addTarget(self, action: #selector(self.onButtonSegmentClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonProgress.addTarget(self, action: #selector(self.onButtonProgressClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicSlider.addTarget(self, action: #selector(self.onButtonBasicSliderClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonStepper.addTarget(self, action: #selector(self.onButtonStepper(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicWebView.addTarget(self, action: #selector(self.onButtonBasicWebView(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicTableView.addTarget(self, action: #selector(self.onButtonTableViewClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicGroupTableView.addTarget(self, action: #selector(self.onButtonGroupTableViewClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicScrollView.addTarget(self, action: #selector(self.onButtonBasicScrollClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonClose.addTarget(self , action: #selector(self.onButtonCloseClick), for: UIControl.Event.touchUpInside)
        
        buttonBaseicConsoleTest.addTarget(self , action: #selector(self.onButtonBaseicConsoleTest), for: UIControl.Event.touchUpInside)
        
        buttonBasicCollectionView.addTarget(self, action: #selector(self.onButtonBasicCollectionView), for: UIControl.Event.touchUpInside)
        
        buttonBasicSearchView.addTarget(self, action: #selector(self.onButtonBasicSearchView), for: UIControl.Event.touchUpInside)
        
        buttonBasicScrollBigView.addTarget(self, action: #selector(self.onButtonBasicScrollBigView), for: UIControl.Event.touchUpInside)
        
        buttonBasicPage.addTarget(self, action: #selector(self.onButtonBasicPage), for: UIControl.Event.touchUpInside)
        
        buttonSimpleAnimation.addTarget(self, action: #selector(onButtonSimpleAnimation), for: UIControl.Event.touchUpInside)
        
        buttonSQLite.addTarget(self, action: #selector(onButtonSQLite), for: UIControl.Event.touchUpInside)
        
        buttonKeepAccount.addTarget(self, action: #selector(onButtonKeepAccount), for: UIControl.Event.touchUpInside)
        
        buttonBasicPageController.addTarget(self, action: #selector(onButtonBasicPageController), for: UIControl.Event.touchUpInside)
        
        buttonBasicCustomCamera.addTarget(self, action: #selector(onButtonBasicCustomCamera), for: UIControl.Event.touchUpInside)
        
        buttonBasicAlumbPicker.addTarget(self, action: #selector(onButtonBasicAlumbPicker), for: UIControl.Event.touchUpInside)
        
        buttonIG.addTarget(self, action: #selector(onButtonIG), for: UIControl.Event.touchUpInside)
        
        buttonAuto.addTarget(self, action: #selector(onButtonAuto), for: UIControl.Event.touchUpInside)
        
        buttonAutoScroll.addTarget(self, action: #selector(onButtonAutoScroll), for: .touchUpInside)
    }
    
    @objc private func onButtonAutoScroll(_ sender: UIButton) {
   
        let autoLayoutScrollViewController = AutoLayoutScrollViewController()
        ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: autoLayoutScrollViewController)
    }
    
    @objc private func onButtonAuto(_ sender: UIButton) {
        
//        let autoLayoutTestViewController: AutoLayoutTestViewController = AutoLayoutTestViewController()
        let autoStackViewController: AutoStackViewController = AutoStackViewController()
        
        ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: autoStackViewController)
    }
    
    @objc private func onButtonIG(_ sender: UIButton) {
        let igLikeCollectionView: IGLikeCollectionView = IGLikeCollectionView()
        ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: igLikeCollectionView)
    }
    
    @objc private func onButtonBasicAlumbPicker(_ sender: UIButton) {
        let basicAlumbImagePickerViewController: BasicAlumbImagePickerViewController = BasicAlumbImagePickerViewController()
        ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: basicAlumbImagePickerViewController)
    }
    
    @objc private func onButtonBasicCustomCamera(_ sender: UIButton) {
        let basicCustomCameraViewController: BasicCustomCameraViewController = BasicCustomCameraViewController()
        ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: basicCustomCameraViewController)
    }
    
    @objc private func onButtonBasicPageController(_ sender: UIButton) {
        let basicPage: BasicPageDemoViewController = BasicPageDemoViewController()
        ViewControllerUtil.startNewFullScreenViewController(from: self, target: basicPage)
    }
    
    @objc private func onButtonKeepAccount(_ sender: UIButton) {
        let keepAccountMainViewController: KeepAccountMainViewController = KeepAccountMainViewController()
        ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: keepAccountMainViewController)
    }
 
    @objc private func onButtonSQLite(_ sender: UIButton) {
        let sqliteDemoView = SQLiteDemoViewController()
        ViewControllerUtil.startNewViewController(from: self, target: sqliteDemoView)
    }
    
    @objc private func onButtonSimpleAnimation(_ sender: UIButton) {
        let simpleAnimation = SimpleAnimationViewController()
        ViewControllerUtil.startNewViewController(from: self, target: simpleAnimation)
    }
    
    @objc private func onButtonBasicPage(_ sender: UIButton) {
        let basicPageViewController = BasicPageViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicPageViewController)
    }
    
    @objc private func onButtonBasicScrollBigView(_ sender: UIButton) {
        let basicScrollBigViewController = BasicScrollBigViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicScrollBigViewController)
    }
    
    
    @objc private func onButtonBasicSearchView(_ sender: UIButton) {
        let basicSearchViewController = BasicSearchViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicSearchViewController)
    }
    
    @objc private func onButtonBasicCollectionView(_ sender: UIButton) {
        let basicCollectionViewController = BasicCollectionViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicCollectionViewController)
    }
    
    @objc private func onButtonBaseicConsoleTest(_ sender: UIButton) {
       basicConsoleTest()
    }
    
    @objc private func onButtonCloseClick(_ sender: UIButton) {
        ViewControllerUtil.finishSelf(view: self)
    }
    
    /*
     go to basic ui view controller template
     */
    @objc private func onButtonBasicUIViewControllerClick(_ sender: UIButton) {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonBasicUIViewControllerClick")
        
        let basicUIViewController = BasicUIViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicUIViewController)
    }
    
    /*
     go to basic navigation controller template
     */
    @objc private func onButtonBasicNavigationControllerClick(_ sender: UIButton) {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonBasicNavigationControllerClick")
        
        let navigationRootViewController = NavigationRootViewController()
        ViewControllerUtil.startNewViewControllerWithNavigation(from: self, target: navigationRootViewController)
    }
    
    @objc private func onButtonLoginClick(_ sender: UIButton) {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonLoginClick")
        
        let loginHomeViewController = LoginHomeViewController()
        loginHomeViewController.fromWhere = "From \(MainViewController.TAG)"
        
        ViewControllerUtil.startNewViewControllerWithNavigation(from: self, target: loginHomeViewController)
    }
    
    @objc private func onButtonCameraClick(_ sender: UIButton) {
        let cameraViewController = CameraViewController()
        cameraViewController.width = self.view.frame.width
        ViewControllerUtil.startNewViewController(from: self, target: cameraViewController)
    }
    
    @objc private func onButtonBasicLabelClick(_ sender: UIButton) {
        let basicLabelViewController = BasicLabelViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicLabelViewController)
    }
    
    @objc private func onButtonBasicTextFieldClick(_ sender: UIButton) {
        let basicTextFieldViewController = BasicTextFieldViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicTextFieldViewController)
    }
    
    @objc private func onButtonBasicTextViewClick(_ send: UIButton) {
        let basicTextViewViewController = BasicTextViewViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicTextViewViewController)
    }
    
    @objc private func onButtonBasicButtonClick(_ send: UIButton) {
        let basicButtonViewController = BasicButtonViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicButtonViewController)
    }
    
    @objc private func onButtonBasicAlertClick(_ send: UIButton) {
        let basicAlertViewController = BasicAlertViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicAlertViewController)
    }
    
    @objc private func onButtonBasicViewClick(_ send: UIButton) {
        let basicBasicImageViewController = BasicImageViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicBasicImageViewController)
    }
    
    @objc private func onButtonBasicDatePickerClick(_ send: UIButton) {
        let basicDatePickerViewController = BasicDatePickerViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicDatePickerViewController)
    }
    
    @objc private func onButtonBasicPickerClick(_ send: UIButton) {
        let basicPickerViewController = BasicPickerViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicPickerViewController)
    }
    
    @objc private func onButtonBasicPickerDemoClick(_ send: UIButton) {
        let basicPickerViewDemoViewController = BasicPickerViewDemoViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicPickerViewDemoViewController)
    }
    
    @objc private func onButtonBasicSwitchClick(_ send: UIButton) {
        let basicSwitchViewController = BasicSwitchViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicSwitchViewController)
    }
    
    @objc private func onButtonSegmentClick(_ send: UIButton) {
        let basicSegmentViewController = BasicSegmentViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicSegmentViewController)
    }
    
    @objc private func onButtonProgressClick(_ send: UIButton) {
        let basicProgressViewController = BasicProgressViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicProgressViewController)
    }
    
    @objc private func onButtonBasicSliderClick(_ send: UIButton) {
        let basicSliderViewController = BasicSliderViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicSliderViewController)
    }
    
    @objc private func onButtonStepper(_ send: UIButton) {
        let basicStepperViewController = BasicStepperViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicStepperViewController)
    }
    
    @objc private func onButtonBasicWebView(_ send: UIButton) {
        let basicWebViewController = BasicWebViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicWebViewController)
    }
    
    @objc private func onButtonTableViewClick(_ send: UIButton) {
        let basicTableViewController = BasicTableViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicTableViewController)
    }
    
    @objc private func onButtonGroupTableViewClick(_ send: UIButton) {
        let basicGroupTableViewController = BasicGroupTableViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicGroupTableViewController)
    }
    
    @objc private func onButtonBasicScrollClick(_ send: UIButton) {
        let basicScrollViewController = BasicScrollViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicScrollViewController)
    }
    
    private func basicConsoleTest() {
        showPaths()

        let basicConsoleTest = BasicConsoleTest()
        basicConsoleTest.basicGrammarTest()
        basicConsoleTest.basicStringTest()
        basicConsoleTest.basicCollectionTest()
        basicConsoleTest.basicControlFlowTest()
        basicConsoleTest.basicFunctionTest()
        basicConsoleTest.basicClassAndStruct()
//        basicConsoleTest.basicInherit()
        basicConsoleTest.basicFoundation()
    }
   
    private func showPaths() {
        StorageUtil.getAppSandBoxDirectory()
        StorageUtil.getDocumentDirectory()
        StorageUtil.getTempDirectory()
        StorageUtil.getLibraryDirectory()
        StorageUtil.getLibraryCachesDirectory()
    }
   
    deinit {
        ILog.debug(tag: MainViewController.TAG, content: "deinit")
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
