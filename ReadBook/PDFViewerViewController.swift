//
//  PDFViewerViewController.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 14/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import UIKit

class PDFViewerViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var model: Book? {
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        if let book = model,
            data = book.book{
                if let webView = webView{
                    webView.loadData(data, MIMEType: "application/pdf", textEncodingName: "utf-8", baseURL: NSURL())
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
