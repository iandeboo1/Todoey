//
//  ViewController.swift
//  Todoey
//
//  Created by Ian DeBoo on 4/10/19.
//  Copyright © 2019 Ian DeBoo. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Buy Groceries", "Eat Raw Eggs", "Suffer the Consequences"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

//////////////////////////////////////////////////////////////////////////////////
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //this line creates the cell item and names it "cell", links to the protype cell with the name "ToDo..."; also make sure that the i in index path is lowercase
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
//////////////////////////////////////////////////////////////////////////////////
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
}

