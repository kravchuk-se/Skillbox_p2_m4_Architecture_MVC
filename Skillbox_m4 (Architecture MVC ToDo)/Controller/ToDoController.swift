//
//  ToDoController.swift
//  Skillbox_m4 (Architecture MVC ToDo)
//
//  Created by Kravchuk Sergey on 17.01.2020.
//  Copyright © 2020 Kravchuk Sergey. All rights reserved.
//

import Foundation
import RealmSwift

protocol ToDoControllerDelegate: class {
    func didUpdateData(_ controller: ToDoController)
}

class ToDoController {
    
    private var realm = try! Realm()
    private var todoItems: Results<ToDoRealm>!
    
    weak var delegate: ToDoControllerDelegate?
    
    init() {
        todoItems = realm.objects(ToDoRealm.self)
    }
    
    var numberOfItems: Int {
        todoItems.count
    }
    
    func item(at index: Int) -> ToDo {
        todoItems[index].presentation
    }
    
    func append(item: ToDo) {
        
        try! realm.write {
            let newItem = ToDoRealm()
            newItem.text = item.text
            realm.add(newItem)
        }
        
        delegate?.didUpdateData(self)
    }
    
    func remove(at index: Int) {
        
        try! realm.write {
            realm.delete(todoItems[index])
        }
        
        delegate?.didUpdateData(self)
    }
    
}

extension ToDoRealm {
    var presentation: ToDo {
        return ToDo(text: self.text)
    }
}
