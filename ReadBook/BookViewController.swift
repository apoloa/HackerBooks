//
//  BookViewController.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 13/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    // MARK: - Attributes
    
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var progressBarDownload: UIProgressView!
    @IBOutlet weak var authors: UILabel!
    @IBOutlet weak var titleBook: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var btnBook: UIButton!
    
    @IBAction func bookActions(sender: AnyObject){
        if let book = self.book,
            _ = book.book where book.downloadTask == nil{
                self.performSegueWithIdentifier("showPDF", sender: self)
        }else{
            disableButton()
            if let progressBarDownload = progressBarDownload{
                progressBarDownload.opaque = false
                progressBarDownload.setProgress(0, animated: false)
                if let book = book{
                    book.downloadBook()
                }
            }
        }
        
        
    }
    @IBAction func FavoriteAction(sender: AnyObject) {
        if let book = book{
            if book.favorite {
                book.favorite = false
            }else{
                book.favorite = true
            }
        }
    }
    var book : Book?{
        didSet{
            updateUI();
            book?.delegate = self
        }
    }
    
    func disableButton(){
        
        if let btnBook = btnBook{
            btnBook.enabled = false
            btnBook.setTitle("Downloading", forState: .Disabled)
        }
        
    }
    
    func setColorUI(color:UIColor){
        self.view.backgroundColor = color
        if let image = imageBook{
            image.backgroundColor = color
        }
        if color.darkColor(){
            if let titleBook = titleBook{
                titleBook.textColor = UIColor.whiteColor()
            }
            if let authors = authors{
                authors.textColor = UIColor.whiteColor()
            }
            if let tags = tags{
                tags.textColor = UIColor.whiteColor()
            }
        }
        
        
    }
    
    func updateUI(){
        if let book = book {
            if let image = book.image{
                if let imageBook = imageBook {
                    setColorUI(image.averageColor())
                    imageBook.image = image
                }
            }
            if let titleBook = titleBook{
                titleBook.text = book.title
            }
            if let authors = authors{
                authors.text = book.authorsString
            }
            if let tags = tags{
                tags.text = book.tagsString
            }
            
            if let _ = book.downloadTask{
                if let progressBarDownload = progressBarDownload{
                    progressBarDownload.hidden = false
                }
                if let btnBook = btnBook{
                    btnBook.setTitle("Downloading", forState: .Disabled)
                    btnBook.enabled = false
                }
                
            }else{
                if let progressBarDownload = progressBarDownload{
                    progressBarDownload.opaque = true
                }
                if book.book != nil{
                    if let btnBook = btnBook{
                        btnBook.enabled = true
                        btnBook.setTitle("Read", forState: .Normal)
                    }
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPDF" {
            if let destVC = segue.destinationViewController as? PDFViewerViewController{
                destVC.model = self.book
            }
        }
    }
    
    
}

extension BookViewController{
    
    func waitForBook (){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateBookFromNotification:", name: NotificationKeys.firstBook, object: nil)
    }
    
    func updateBookFromNotification(notification: NSNotification){
        let dictionary = notification.userInfo
        let data = dictionary!["Book"] as! Book
        self.book = data
        self.updateUI()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension BookViewController: BookDownloadDelegate{
    func update(process:Float){
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            if let progressBar = self.progressBarDownload{
                progressBar.setProgress(process, animated: true)
            }
        }
    }
    func finish(){
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            self.updateUI()
        }
    }
}
