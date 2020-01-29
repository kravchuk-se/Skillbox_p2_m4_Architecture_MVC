//
//  ViewController.swift
//  Skillbox_m4 (Architecture MVC ToDo)
//
//  Created by Kravchuk Sergey on 17.01.2020.
//  Copyright © 2020 Kravchuk Sergey. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let todoController = ToDoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoController.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Edit segue" {
            let vc = segue.destination as! TodoEditViewController
            vc.delegate = self
        }
    }
    
}

extension TodoListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoController.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        cell.textLabel?.text = todoController.item(at: indexPath.row).text
        
        return cell
    }
    
}

extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.beginUpdates()
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        todoController.remove(at: indexPath.row)
        
        tableView.endUpdates()
        
    }
    
}

extension TodoListViewController: ToDoControllerDelegate {
    func didUpdateData(_ controller: ToDoController) {
        tableView.reloadData()
    }
}

extension TodoListViewController: TodoEditViewControllerDelegate {
    func save(item: ToDo) {
        todoController.append(item: item)
    }
}
