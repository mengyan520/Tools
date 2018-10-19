//
//  DCWKWebViewController.swift
//  SwiftDemo
//
//  Created by ma on 2018/10/18.
//  Copyright © 2018年 ma. All rights reserved.
//

import UIKit
import WebKit
class DCWKWebViewController: DCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView = WKWebView.init(frame:self.view.bounds)
        self.webView?.navigationDelegate = self
        self.view.addSubview(self.webView!)
        if (urlString != nil) {
            let url = URL.init(string: self.urlString!)
            let request = URLRequest.init(url: url!)
            self.webView?.load(request)
            self.indicatorView = UIActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            self.indicatorView?.center = self.webView!.center
            self.indicatorView?.style = UIActivityIndicatorView.Style.gray
            self.view.addSubview(self.indicatorView!)
            self.indicatorView?.startAnimating()
        }
        if (wkTitle == nil) {
            self.webView?.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
        }else {
            self.title = self.wkTitle
        }
    
    }
     //MARK: - KVO监听标题
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            if (object as AnyObject) === self.webView {
                self.title = self.webView?.title
            }else {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }
    }
    //MARK: - 私有属性
    private var webView:WKWebView?
    private var indicatorView:UIActivityIndicatorView?
    //MARK: - 公共属性
    var urlString:String?//{
//        didSet {
//            urlString = urlString?.addingPercentEncoding(withAllowedCharacters: CharacterSet.init())
//        }
   // }
    var wkTitle:String?
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {
        if self.wkTitle != nil {
            self.webView?.removeObserver(self, forKeyPath: "title")
        }
    }
}
extension DCWKWebViewController:WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.absoluteString == "about:blank" {
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        decisionHandler(WKNavigationActionPolicy.allow)
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicatorView?.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.indicatorView?.stopAnimating()
    }
}
