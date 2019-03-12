//
//  ViewController.swift
//  StretchyHeader
//
//  Created by Myunggu Kim on 11/02/2019.
//  Copyright © 2019 Shinvee Inc. All rights reserved.
//


/*
 References :
 
 
 https://mobikul.com/table-view-stretch-header-parallax-animation-in-swift/
 
 http://blog.matthewcheok.com/design-teardown-stretchy-headers/
 
 */


import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var tableItems = (1...100).map { "\($0)" }
    var headerView: UIView!
    var tableHeaderHeight: CGFloat! = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        DispatchQueue.main.async {
            let ratio = self.tableView.bounds.width / self.headerView.bounds.width
            self.tableHeaderHeight = self.headerView.bounds.height * ratio
            self.tableView.contentInset = UIEdgeInsets(top: self.tableHeaderHeight, left: 0, bottom: 0, right: 0)
            self.tableView.contentOffset = CGPoint(x: 0, y: -self.tableHeaderHeight)
            
            self.updateHeaderView()
        }
    }
    
    func updateHeaderView() {
        
        // 화면비율에 맞게 사이즈 조정
        var headerRect = CGRect(x: 0, y: -tableHeaderHeight, width: tableView.bounds.width, height: tableHeaderHeight)
        
        // 헤더의 y 위치를 tableview의 시작점에 맞추고, 높이를 증가 시킴
        if tableView.contentOffset.y < -tableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = abs(tableView.contentOffset.y)
        }
        
        headerView.frame = headerRect
    }


}

extension ViewController: UITableViewDataSource {
    
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

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        updateHeaderView()
    }
    
}
