//
//  CategoryViewController.swift
//  ListUp
//
//  Created by apple on 10/05/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
    
    // For Encoding and Decoding our data to this pre-specified FilePath
    let dataFilePath = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask).first?.appendingPathComponent("Category.plist")
    
    // shared singleton object of our Coredata context = for CoreData database
    // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // print(dataFilePath!)
        
        loadCategories()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = categoryArray?[indexPath.row]
        
        cell.textLabel?.text = item?.name ?? "No Categories Added Yet."
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationViewController = segue.destination as! ToDoListViewController
    
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationViewController.selectedCategory = categoryArray?[indexPath.row]
        }
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // print("add button pressed")
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            //self.categoryArray.append(newCategory)
            self.saveCategory(category: newCategory)
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            
            textField = alertTextField
            alertTextField.placeholder = "Create New Category"
            
            print(alertTextField.text!)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategory(category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving the Category.")
        }
    }
    
    func loadCategories() {
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
}

//
//extension CategoryViewController : UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
//
//        request.predicate = predicate
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        request.sortDescriptors = [sortDescriptor]
//
//        loadCategories(with: request)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        if searchBar.text?.count == 0 {
//            print("no text in SearchBar")
//            loadCategories()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//
//}
//
//
