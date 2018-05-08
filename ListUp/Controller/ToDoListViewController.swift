//
//  ViewController.swift
//  ListUp
//
//  Created by apple on 06/05/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    // Item objects
    var itemArray = [Item]()
    
    // An interface to User defaults Database
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory,
                            in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Buy Milk"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Play Match"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Bhangra Dance"
        itemArray.append(newItem3)
        
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
        // when toggle the checkmark save the encoded data to items.plist
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
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            // when adding a new item save encoded data to items.plist
            saveItems()
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
    
    // Encode the data
    func saveItems() {
        // encoder object
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
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
                itemArray = try? decoder.decode([Item].self, from: data)
            } catch {
                
                print("Error decoding the data, \(error)")
            }
        }
    }
    
}

