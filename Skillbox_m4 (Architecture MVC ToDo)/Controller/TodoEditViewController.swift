//
//  TodoEditViewController.swift
//  Skillbox_m4 (Architecture MVC ToDo)
//
//  Created by Kravchuk Sergey on 17.01.2020.
//  Copyright © 2020 Kravchuk Sergey. All rights reserved.
//

import UIKit

protocol TodoEditViewControllerDelegate: class {
    func save(item: ToDo)
}

class TodoEditViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: TodoEditViewControllerDelegate?
    var todoItem: ToDo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        if todoItem == nil {
            todoItem = ToDo(text: "New todo")
        }
        
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    func updateUI() {
        textField.text = todoItem.text
    }
    @IBAction func cancelTap(_ sender: UIBarButtonItem) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
        navigationController?.popViewController(animated: true)
    }
    
}

extension TodoEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text ?? "" == "" {
            return false
        }
        todoItem = ToDo(text: textField.text!)
        textField.resignFirstResponder()
        delegate?.save(item: todoItem)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        navigationController?.popViewController(animated: true)
    }
}


