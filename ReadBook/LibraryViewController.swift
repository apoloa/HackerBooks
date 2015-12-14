//
//  LibraryViewController.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 11/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import UIKit

class LibraryViewController: UITableViewController {

    //MARK: - Constants
    let bookCell:   String    = "BookCell"
    let headerCell: String    = "HeaderCell"
    
    //MARK: - Atributes
    var indicatorView : UIActivityIndicatorView?
    let library : Library = loadAsyncLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        library.delegate = self
        indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        if(library.loadingLibrary){
            if let indicator = indicatorView{
                indicator.hidesWhenStopped = true
                indicator.startAnimating()
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
            }
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "update:", name: NotificationKeys.firstBook, object: nil)
    }
    
    func update(notification: NSNotification){
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return library.countTags
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return library.countBooks(tag: section)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath)

        let book = library[indexPath.row, tag:indexPath.section]
        
        if let bookCell = cell as? BookViewCell {
            bookCell.title.text = book?.title
            bookCell.imageBook.image = book?.image
            bookCell.authors.text = book?.authorsString
        }
        return cell
    }

    /*
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  library[tag:section]
    }
*/

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showBook" {
            if let navController = segue.destinationViewController as? UINavigationController,
                topController = navController.topViewController,
                bookController = topController as? BookViewController,
                indexPath = self.tableView.indexPathForSelectedRow {
                    bookController.book = library[indexPath.row, tag:indexPath.section]
                    bookController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                    bookController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

extension LibraryViewController {
    // MARK: - Table Customizations
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        /*let view = UIView(frame: CGRectMake(0,0, tableView.frame.size.width, 66))
        
            view.backgroundColor = UIColor.redColor()
            
        return view
        */
        
        let headerView = tableView.dequeueReusableCellWithIdentifier(self.headerCell)
        if let header = headerView,
            headerVC = header as? HeaderViewCell{
                let tag = library[tag:section]
                headerVC.titleHeaderModel = tag
        }
        return headerView
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        print(view.frame.height)
    }
}


extension LibraryViewController : LibraryDelegate {
    // MARK: - Delegate
    
    func addNewBook(){
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            self.tableView.reloadData()
        }
    }
    func completeLoadBooks(){
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            if let indicator = self.indicatorView{
                indicator.hidden = true
            }
        }
        
    }
}
