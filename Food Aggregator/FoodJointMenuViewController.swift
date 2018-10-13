//
//  FoodJointMenuViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import ExpandableCell

class FoodJointMenuViewController: UIViewController {
    
    var tableView: ExpandableTableView!
    
//    var cell: UITableViewCell {
//        return tableView.dequeueReusableCell(withIdentifier: "ExpandedCell.ID")!
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Food Joint Name"
        
        self.view.backgroundColor = .white
        
        tableView = ExpandableTableView()
        tableView.expandableDelegate = self
//        tableView.dataSource = self
        tableView.animation = .automatic
        tableView.register(ExpandedCell.self, forCellReuseIdentifier: "ExpandedCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExpandableCell")
        
        self.view.addSubview(tableView)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: tableView)
    }

}

class ExpandedCell: BaseTableViewCell {
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: titleLabel)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
}

extension FoodJointMenuViewController: ExpandableDelegate {
    
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        switch indexPath.row {
        case 0...:
            var cells: [ExpandedCell] = []
            for i in 0...indexPath.row {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "ExpandedCell") as! ExpandedCell
                cell.titleLabel.text = "Some text #\(i)"
                cells.append(cell)
            }
            return cells
        default:
            return nil
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        switch indexPath.row {
        case 0...:
            let numberOfCells = indexPath.row
            var cellHeights: [CGFloat] = []
            for _ in 0...numberOfCells {
                cellHeights.append(44)
            }
            return cellHeights
            
        default:
            break
        }
        return nil
        
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        //        print("didSelectRow:\(indexPath)")
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectExpandedRowAt indexPath: IndexPath) {
        //        print("didSelectExpandedRowAt:\(indexPath)")
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
        if let cell = expandedCell as? ExpandedCell {
            print("\(cell.titleLabel.text ?? "")")
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandableTableView.dequeueReusableCell(withIdentifier: "ExpandableCell", for: indexPath)
        cell.textLabel?.text = "Some header #\(indexPath.row)"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        return cell
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
//    func expandableTableView(_ expandableTableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
//        let cell = expandableTableView.cellForRow(at: indexPath)
//        cell?.contentView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
//        cell?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
//    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
