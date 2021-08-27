//
//  TimelineTableViewController.swift
//  PoPtutorial
//
//  Created by sangheon on 2021/08/27.
//

import UIKit
let timelineTitle = "Timeline"

class TimelineTableViewController:UITableViewController,ContainContents {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = timelineTitle
    }
    
    //MARK: TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfContents
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content:Content = contents[indexPath.row]
        let cell:TimelineTableViewCell
        let cellIdentifier = "reuseIdentifier"
        if let reuseCell:TimelineTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TimelineTableViewCell {
            cell = reuseCell
            //cell.contents
        } else { //혹시라도 cell 없을떄 채워주기
            cell = TimelineTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellIdentifier, content: content)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
