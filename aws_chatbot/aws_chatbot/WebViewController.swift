//
//  WebViewController.swift
//  aws_chatbot
//
//  Created by 黃威愷 on 2020/6/2.
//  Copyright © 2020 iOSClub. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController,WKNavigationDelegate,UIWebViewDelegate {
    @IBOutlet weak var webview:WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.navigationDelegate = self
        webview.load(URLRequest(url: URL(string: "http://140.134.79.128:3000")!))
        // Do any additional setup after loading the view.
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
