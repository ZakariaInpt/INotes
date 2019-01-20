//
//  ViewController.swift
//  INote
//
//  Created by User on 15/01/2019.
//  Copyright © 2019 Zakaria. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    //let defaults=UserDefaults.standard // we do not need this userDefault singelton and we will replace it with our own plist file.
    var cellArray=["IOS Business", "GYM", "Research Lab"]
    var itemArray = [ToDoItem]()//Define an array of object of type toDoItem
    
    //define a Path variable
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print (dataFilePath)
        
        //define some object of type ToDoItem
        // 1st Object
//        let newItem = ToDoItem()
//        newItem.title="Milk"
//        itemArray.append(newItem)
//
//        // 2nd Object
//        let newItem2 = ToDoItem()
//        newItem2.title="Bread"
//        itemArray.append(newItem2)
//
//        // 3rd Object
//        let newItem3 = ToDoItem()
//        newItem3.title="Advocado"
//        itemArray.append(newItem3)
        
        // Here, we have to load the data from the plist file instead of populate the table manually.
        
        loadItems()
        
        //tableView.reloadData()
        
        //        if let items=defaults.array(forKey: "INoteApp") as? [String] {
        //
        //            cellArray=items
        //
        //        }
    }
    
    //MARK - Tabelview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //define a variable that gonna replace the long variable indexPath.row
        let item = itemArray[indexPath.row]
        
        //define a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        cell.textLabel?.text = item.title
        
        
        //tenary condition
        cell.accessoryType = item.itemChecked ? .checkmark : .none
        
        //        if item.itemChecked == true {
        //            cell.accessoryType = .checkmark
        //        }else {
        //            cell.accessoryType = .none
        //        }
        
        return cell
    }
    
    //Mark: Table view delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].itemChecked = !itemArray[indexPath.row].itemChecked
        
        saveItems()
        
        //        if itemArray[indexPath.row].itemChecked == false {
        //            itemArray[indexPath.row].itemChecked = true
        //        }else {
        //            itemArray[indexPath.row].itemChecked = false
        //        }
        
        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //        }else {
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - ADD a new items
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        
        
        var text = UITextField()
        
        let alert = UIAlertController (title: "Add New Item", message: "Would you like to add new item?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //create a new object of type ToDoItem
            let newItem = ToDoItem()
            newItem.title=text.text!
            
            self.itemArray.append(newItem)
            //self.defaults.set(self.itemArray, forKey: "INoteApp") // this when the app crashes using the previous singelton
            
            self.saveItems()
            
            
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder="Create the new item"
            text = alertTextfield
            
        }
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
        
        
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        }catch {
            print("Error encoding item array \(error)")
        }
        tableView.reloadData()
    }
    
    
    //this function is to decode the stored data in the plist file.
    func loadItems(){
        
        //check first if the created plist has some contentes
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            
            do{
                itemArray = try decoder.decode([ToDoItem].self, from: data)
                
            }catch{
                
            }
        }
        
    }
    
}

