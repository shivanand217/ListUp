//  ViewController.swift
//  ListUp
//
//  Created by apple on 06/05/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

/** Rule1 = Whenever adding any delegate methods or class set it to self **/

class ToDoListViewController: UITableViewController {
    
    let realm = try! Realm()
    
    // Item objects
    var todoItems : Results<Item>?
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    /** An interface to User defaults Database
        let defaults = UserDefaults.standard
    **/
    
    // For Encoding and Decoding our data to this pre-specified FilePath
    let dataFilePath = FileManager.default.urls(for: .documentDirectory,
                            in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // shared singleton object of our Coredata context = for using CoreData Database
    // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //print(dataFilePath!)
        
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        //loadItems(with: request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = todoItems?[indexPath.row]
        
        cell.textLabel?.text = item?.title ?? "No Item Added Yet."
        
        // add and remove checkmark
        cell.accessoryType = item?.done == 1 ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // delete from context
        // context.delete(itemArray[indexPath.row])
        
        // delete from the array
        // itemArray.remove(at: indexPath.row)
        
        if todoItems![indexPath.row].done == 1 {
            todoItems![indexPath.row].done = 0
        } else {
            todoItems![indexPath.row].done = 1
        }
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Adding Items through add button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // print("Add button Pressed")
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New To-do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // on pressing add item button
//            let newItem = Item(context: self.context)
//
//            newItem.title = textField.text!
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
//
//            self.itemArray.append(newItem)
//
            self.saveItems()
        }
        
        alert.addAction(action)
        alert.addTextField {
            (alertTextField) in
            
            alertTextField.placeholder = "Create New To-Do"
           
            textField = alertTextField
            print(alertTextField.text!)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    // CoreData
    
    // Save to CoreData
//    func saveItems() {
//
//        do {
//            try context.save()
//        } catch {
//            print("Error saving the Item. \(error)")
//        }
//        tableView.reloadData()
//    }
//
    // Fetch from CoreData
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    

/** Saving Information Via NSCoder
     // Encode the data
    func saveItems() {
        // encoder object
        let encoder = PropertyListEncoder()

        do {
            let data = try! encoder.encode(itemArray)
            try data.write(to: dataFilePath!)

        } catch {
            print("Error encoding the data, \(error)")
        }

        self.tableView.reloadData()
    }

    // Decode the data
    func loadItems() {

        if let data = try? Data(contentsOf: dataFilePath!) {
            // decoder object
            let decoder = PropertyListDecoder()

            do {
                itemArray = try! decoder.decode([Item].self, from: data)
            } catch {

                print("Error decoding the data, \(error)")
            }
        }
    }
 **/
    
}


// extension of View class
//extension ToDoListViewController : UISearchBarDelegate {
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        print("cancel button clicked")
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        // print("search Bar clicked")
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.predicate = predicate
//
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//        request.sortDescriptors = [sortDescriptor]
//
//        loadItems(with: request, predicate: predicate)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            print("no text in SearchBar")
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//
//}




