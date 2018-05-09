//
//  ViewController.swift
//  ListUp
//
//  Created by apple on 06/05/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    // Item objects
    var itemArray = [Item]()
    
    /** An interface to User defaults Database
        let defaults = UserDefaults.standard
    **/
    
    // For Encode and Decode our data to this pre-specified FilePath
    let dataFilePath = FileManager.default.urls(for: .documentDirectory,
                            in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // shared singleton object of our Coredata context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(dataFilePath!)
        
        loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // add and remove checkmark
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if itemArray[indexPath.row].done == true {
            itemArray[indexPath.row].done = false
        } else {
            itemArray[indexPath.row].done = true
        }
        saveItems()
        
        // reload our tableView after any changes
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // Adding Items through add button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To-do item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // on pressing add item button
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            
            // when adding a new item save encoded data to items.plist
            self.saveItems()
        }
        
        alert.addTextField {
            (alertTextField) in
            
            alertTextField.placeholder = "Create New To-Do"
            print("+ Pressed")
            
            textField = alertTextField
            print(alertTextField.text!)
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // CoreData
    
    // Save to CoreData
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving the message. \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    // Fetch from CoreData
    func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
           itemArray = try! context.fetch(request)
        
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
//    // Encode the data
//    func saveItems() {
//        // encoder object
//        let encoder = PropertyListEncoder()
//
//        do {
//            let data = try! encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
//
//        } catch {
//            print("Error encoding the data, \(error)")
//        }
//
//        self.tableView.reloadData()
//    }
//
//    // Decode the data
//    func loadItems() {
//
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            // decoder object
//            let decoder = PropertyListDecoder()
//
//            do {
//                itemArray = try! decoder.decode([Item].self, from: data)
//            } catch {
//
//                print("Error decoding the data, \(error)")
//            }
//        }
//    }
//
}

