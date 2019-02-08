//
//  CategoryTableViewController.swift
//  INote
//
//  Created by User on 05/02/2019.
//  Copyright © 2019 Zakaria. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    //Define an array of object of type toDoItem
    var categoryArray = [Category]()
    
    //Create context from the  AppDelegate class.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var text = UITextField()
        
        //Pop up the add category window
        let alert = UIAlertController (title: "Add New Category", message: "Would you like to add new category?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            //create a new object of type ToDoItem
            let newCategory = Category(context: self.context)
            newCategory.categoryName=text.text!
            
            //Add the new category to the Category Array
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
            
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder="Create A New Category"
            text = alertTextfield
            
        }
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
        
    }
    
    
    //MARK: TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //define a variable that gonna replace the long variable indexPath.row
        let item = categoryArray[indexPath.row]
        
        //define a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        //cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        cell.textLabel?.text = item.categoryName
        
        
        return cell
    }
    
    //Set these two functions to send the selected category to the next UIview
    //This first function is gonna only send the user to the next VC without any specific action
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //deleteCategory(ip: indexPath)
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    //This second function is gonna be used to send the user to the next VC including the selected variable
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray [indexPath.row]
            
        }
    
    }
    
    //MARK: TableView Delegate Methods
    
    
    
    
    
    //MARK: Data Manipulation Methods (load and save data)
    
    func saveCategory(){
        
        do{
            
            try context.save()
            
        }catch {
            print("Error in the context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(with request:NSFetchRequest<Category>=Category.fetchRequest()){
        
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print (error)
        }
        tableView.reloadData()
    }
    
    //Delete method
//
//    func deleteCategory(ip:IndexPath){
//
//        let alert = UIAlertController(title: "Message", message: "Did you want to delete this category", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
//            self.context.delete(self.categoryArray[ip.row])
//            self.categoryArray.remove(at: ip.row)
//
//            self.saveCategory()
//
//
//        }))
//        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
//
//        self.present(alert, animated: true)
//        self.tableView.deselectRow(at: ip, animated: true)
//
//    }
    
    
}
