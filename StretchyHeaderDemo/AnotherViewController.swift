//
//  AnotherViewController.swift
//  StretchyHeader
//
//  Created by Myunggu Kim on 11/02/2019.
//  Copyright © 2019 Shinvee Inc. All rights reserved.
//


/*
 Reference :
 
 https://github.com/abhimuralidharan/StretchableTableViewHeader-Swift
 
 */

import UIKit

class AnotherViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageViewHeight: NSLayoutConstraint!
    var maxHeaderHeight: CGFloat! = 0
    var minHeaderHeight: CGFloat! = 100
    var tableItems = (1...100).map { "\($0)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.maxHeaderHeight = self.imageViewHeight.constant
            self.tableView.contentInset = UIEdgeInsets(top: self.maxHeaderHeight, left: 0, bottom: 0, right: 0)
            self.tableView.scrollIndicatorInsets = self.tableView.contentInset
            self.tableView.contentOffset = CGPoint(x: 0, y: -self.maxHeaderHeight)
            
            self.updateHeaderView()
        }
    }
    
    func updateHeaderView() {
        imageViewHeight.constant = abs(min(-minHeaderHeight, tableView.contentOffset.y))
    }
}

extension AnotherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        let item = tableItems[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
}

extension AnotherViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if maxHeaderHeight > 0 {
            updateHeaderView()
        }
    }
    
}
