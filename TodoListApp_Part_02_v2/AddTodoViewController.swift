//
//  AddTodoViewController.swift
//  TodoListApp_Part_01
//
//  StudentID: 300783746
//  @Desc: This is the first part of a three-part Todo List Assignment. In this part, consists of planning and creation of the User Interface (UI) for the App. Minimal Functional logic is implemented.
//  Created by Raj Kumar Shahu on 2020-11-06.
//  Copyright © 2020 Centennial College. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController {
    
    @IBOutlet weak var todoNameTextField: UITextField!
    
    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addTodoTapped(_ sender: Any) {
 
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let today = Date()
            var dateComponent = DateComponents()
            dateComponent.day = 1
            let dueDate = Calendar.current.date(byAdding: dateComponent, to: today)
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE MMMM d, yyyy hh:mm a"
            
            // New todo object
            let todo = TodoData(context: context)
            
            // Creating todo item with todo name and date
            if let todoItem =  todoNameTextField.text {
                // Specify todo name and date
                todo.todoItem = todoItem
                todo.todoDate = formatter.string(from: dueDate!)
                todo.detail = detailTextView.text

                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                // Pop back to list screen
                navigationController?.popViewController(animated: true)
            }
        }
    }
}
