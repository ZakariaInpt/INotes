//
//  ViewController.swift
//  INote
//
//  Created by User on 15/01/2019.
//  Copyright © 2019 Zakaria. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let cellArray=["IOS Business", "GYM", "Research Lab"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK - Tabelview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //define a reusable cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        cell.textLabel?.text = cellArray[indexPath.row]
        return cell
    }
    
    //Mark: Table view delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    

}

