//
//  CategoryViewController.swift
//  ListUp
//
//  Created by apple on 10/05/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    // For Encoding and Decoding our data to this pre-specified FilePath
    let dataFilePath = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // shared singleton object of our Coredata context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(dataFilePath!)
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        //loadItems(with: request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    }
}
