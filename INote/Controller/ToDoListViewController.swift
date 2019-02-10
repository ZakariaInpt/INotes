//
//  ViewController.swift
//  INote
//
//  Created by User on 15/01/2019.
//  Copyright © 2019 Zakaria. All rights reserved.
//

import UIKit
import RealmSwift


class ToDoListViewController: UITableViewController {
    
    //let defaults=UserDefaults.standard // we do not need this userDefault singelton and we will replace it with our own plist file.
    var cellArray=["IOS Business", "GYM", "Research Lab"]
    var todoItem:Results<Item>? //Define an array of object of type Item
    let realm=try! Realm()
    //This variable is gonna include the category reference selected from the previous VC
    var selectedCategory : Category? {
        
        didSet{//This is gonna be evoked only when the selectedCategory variable is set with a value
            loadItems()
        }
    }
    
    //Create context from the  AppDelegate class.
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //define a Path variable
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
        
        //loadItems()
        
        //tableView.reloadData()
        
        //        if let items=defaults.array(forKey: "INoteApp") as? [String] {
        //
        //            cellArray=items
        //
        //        }
        
        
        
    }
    
    //MARK - Tabelview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItem?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //define a variable that gonna replace the long variable indexPath.row
      
            //define a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
            //cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
          if  let item = todoItem?[indexPath.row] {
            cell.textLabel?.text = item.title
            //tenary condition
            cell.accessoryType = item.done ? .checkmark : .none
            
            //        if item.itemChecked == true {
            //            cell.accessoryType = .checkmark
            //        }else {
            //            cell.accessoryType = .none
            //        }

        }else {
            
            cell.textLabel?.text="No Item Added"
        }

      
        return cell
    }
//
    //Mark: Table view delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item=todoItem?[indexPath.row] {
        do {
            try self.realm.write{
                //realm.delete(item)
                item.done = !item.done
            }
        }catch {
            print("Error saving the new item")
        }
    }
        tableView.reloadData()
        
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        //itemArray[indexPath.row].itemChecked = !itemArray[indexPath.row].itemChecked
        
//        saveItems()
        
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



            
            if let currentCategory=self.selectedCategory {
                do {
                    try self.realm.write{
                        //create a new object of type ToDoItem
                        let newItem = Item()
                        newItem.title=text.text!
                        newItem.done=false
                        newItem.dateCreated=Date()
                        currentCategory.items.append(newItem)
                        
                    }
                }catch {
                    print("Error saving the new item")
                    
                }
            }
            
            self.tableView.reloadData()
            

            //self.itemArray.append(newItem)
            //self.defaults.set(self.itemArray, forKey: "INoteApp") // this when the app crashes using the previous singelton

            //self.saveItems()


        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder="Create the new item"
            text = alertTextfield

        }

        alert.addAction(action)
        present(alert,animated: true, completion: nil)
        
        
    }
    
//    func saveItems(){
//
//        do{
//
//            try context.save()
//
//        }catch {
//            print("Error in the context \(error)")
//        }
//        tableView.reloadData()
//    }
    
    
    //this function is to decode the stored data in the plist file (This was used with the encode/decode concept)
    func loadItems(){
            //this is for loading the items related to the selected category and sort the results in an ascending way
            todoItem=selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        
            // Load the data from Context
            //let request : NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.categoryName MATCHES %@", selectedCategory!.categoryName!)
//
//        //Create a compound predict to combine two requests into one
//        if let additionalPredicate=predicate {// it there is addtional predicate then compunt the two predicates
//              request.predicate=NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        }else {// otherwise, send only one predicate
//            request.predicate = categoryPredicate
//        }
//
//            do{
//                //
//                itemArray = try context.fetch(request)
//            }catch{
//                print (error)
//            }
        
            tableView.reloadData()
        }
    
}

//MARK - Search bar methods

extension ToDoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        
          todoItem = todoItem?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        
    }

//        let request : NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
//        let predicate = NSPredicate(format: "itemTitle CONTAINS[cd] %@", searchBar.text!)
//
//
//        // Sort the obtained resutls
//        request.sortDescriptors = [NSSortDescriptor(key: "itemTitle", ascending: true)]

        //fetch the retrieved data
//        do{
//            //
//            itemArray = try context.fetch(request)
//        }catch{
//            print (error)
//        }
//        tableView.reloadData()
//       loadItems(with: request, predicate: predicate)
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}

