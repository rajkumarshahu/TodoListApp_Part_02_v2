//
//  TodoListViewController.swift
//  TodoListApp_Part_01
//
//  Created by Raj Kumar Shahu on 2020-11-05.
//  StudentID: 300783746
//  @Desc: This is the first part of a three-part Todo List Assignment. In this part, consists of planning and creation of the User Interface (UI) for the App. Minimal Functional logic is implemented.
//  Copyright © 2020 Centennial College. All rights reserved.

import UIKit

// TodoTableViewCell class declaration for the cell
class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoListItemLabel: UILabel!
    @IBOutlet weak var todoDateLabel: UILabel!
    @IBOutlet weak var todoDoneSwitch: UISwitch!
    
    var todo : TodoData? = nil
    
    @IBAction func onChangeSwitch(_ sender: UISwitch) {
        
        if ((UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) != nil{
      
            let strikeThrough: NSMutableAttributedString =  NSMutableAttributedString(string: todoListItemLabel.text!)
            strikeThrough.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, strikeThrough.length))
            
            let clearStrikeThrough: NSMutableAttributedString =  NSMutableAttributedString(string: todoListItemLabel.text!)
            clearStrikeThrough.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0, range: NSMakeRange(0, strikeThrough.length))
            
            
            if sender.isOn{
                todoListItemLabel.textColor = UIColor.gray
                todoListItemLabel.attributedText = strikeThrough;
                print(todoListItemLabel.text!)
            }
            else {
                todoListItemLabel.textColor = UIColor.black
                todoListItemLabel.attributedText = clearStrikeThrough;
            }
            
            todo?.isComplete = todoDoneSwitch.isOn
            
            print(TodoListTableViewController.self)
    
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
}

var cellIndex = 0

class TodoListTableViewController: UITableViewController {
    
    
    
    // Array of todos
    var todos : [TodoData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Some sample todos
        
        //        let toDo1 = Todo()
        //        toDo1.todoItem = "Web Tech M4"
        //        toDo1.todoDate = "Wednesday November 25, 2020 11:59 pm"
        //        toDo1.detail = "Integration of at least half of the screens (use cases) with the web service."
        //        toDo1.iscomplete = false;
        //
        //        let toDo2 = Todo()
        //        toDo2.todoItem = "Enterprise Tech M3"
        //        toDo2.todoDate = "Thursday November 12, 2020 11:00 pm"
        //        toDo2.detail = "Web Server with Implementation of all of use-cases. Integration with Mobile App (at least one use case – e.g. List All. Demonstration of functionality (e.g. using Postman)"
        //        toDo2.iscomplete = false;
        //
        //        let toDo3 = Todo()
        //        toDo3.todoItem = "iOS Todo List App"
        //        toDo3.todoDate = "Friday November 13, 2020 11:59 pm"
        //        toDo3.detail = "The app interface will allow the user to enter a list of Todos (or tasks) on the main screen. Include a second screen that displays the Todo Details."
        //        toDo3.iscomplete = false;
        //
        //        let toDo4 = Todo()
        //        toDo4.todoItem = "Android google map"
        //        toDo4.todoDate = "Sunday November 8, 2020 11:59 pm"
        //        toDo4.detail = "Develop an Android app that allows customers to find the location and address of the pizza restaurants. "
        //        toDo4.iscomplete = false
        //
        //        let toDo5 = Todo()
        //        toDo5.todoItem = "UI/UX Milestone 3"
        //        toDo5.todoDate = "Sunday November 15, 2020 11:59 pm"
        //        toDo5.detail = "Create a usability testing plan for your proposed design. Run user testing sessions and summarize your findings "
        //        toDo5.iscomplete = false;
        
        //todos = [toDo1,toDo2, toDo3, toDo4, toDo5]
        
//        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
//            if let coreDataToDoItems = try? context.fetch(TodoData.fetchRequest()) as? [TodoData] {
//                todos = coreDataToDoItems
//                tableView.reloadData()
//            }
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataToDoItems = try? context.fetch(TodoData.fetchRequest()) as? [TodoData] {
                todos = coreDataToDoItems
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        // Making a new table view cell from TodoTableViewCell class
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! TodoTableViewCell
//
//        // Pulling out todo from the array according to index and set to todoList
//        let todoList =  todos[indexPath.row]
//        let today = Date();
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEEE MMMM d, yyyy hh:mm a"
//        let formattedTodoDate = dateFormatter.date(from: todoList.todoDate ?? "Sunday November 29, 2020 11:59 pm")
//
//        cell.todoListItemLabel?.text = todoList.todoItem
//        cell.todoDateLabel?.text = todoList.todoDate
//        cell.todoDoneSwitch?.isOn = todoList.isComplete
//
//        if (formattedTodoDate! < today){
//            cell.todoDateLabel?.text = "Overdue";
//            cell.todoListItemLabel?.textColor = UIColor.red;
//            cell.todoDateLabel?.textColor = UIColor.red;
//        } else {
//            cell.todoListItemLabel?.textColor = UIColor.black;
//            cell.todoDateLabel?.textColor = UIColor.black;
//        }
//
//        cell.todoDateLabel?.isHidden = false;
//        if(todoList.hasDueDate == false) {
//            cell.todoDateLabel?.isHidden = true;
//        }
//
//        return cell
//    }
//

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Making a new table view cell from TodoTableViewCell class
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! TodoTableViewCell
        
        // Pulling out todo from the array according to index and set to todoList
        let todoList =  todos[indexPath.row]
        let today = Date();
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMMM d, yyyy hh:mm a"
        let formattedTodoDate = dateFormatter.date(from: todoList.todoDate ?? "Sunday November 29, 2020 11:59 pm")
        
        
        cell.todoListItemLabel?.text = todoList.todoItem
        cell.todoDateLabel?.text = todoList.todoDate
        cell.todoDoneSwitch?.isOn = todoList.isComplete
        
        cell.todoDateLabel?.isHidden = false;
        if(todoList.hasDueDate == false) {
            cell.todoDateLabel?.isHidden = true;
        }
        
        
        let strikeThrough: NSMutableAttributedString =  NSMutableAttributedString(string: cell.todoListItemLabel.text!)
        strikeThrough.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, strikeThrough.length))
        
        let clearStrikeThrough: NSMutableAttributedString =  NSMutableAttributedString(string: cell.todoListItemLabel.text!)
        clearStrikeThrough.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0, range: NSMakeRange(0, strikeThrough.length))
        
        
        cell.todoListItemLabel.textColor = UIColor.black
        cell.todoListItemLabel.attributedText = clearStrikeThrough;
        cell.todoDateLabel?.textColor = UIColor.black;
        
        if (formattedTodoDate! < today){
            cell.todoDateLabel?.text = "Overdue";
            cell.todoListItemLabel?.textColor = UIColor.red;
            cell.todoDateLabel?.textColor = UIColor.red;
        }
        
        if (todoList.isComplete == true) {
            cell.todoListItemLabel.textColor = UIColor.gray
            cell.todoListItemLabel.attributedText = strikeThrough;
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellIndex = indexPath.row
        
        let selectedTodo = todos[indexPath.row]
        
        performSegue(withIdentifier: "TodoDetail", sender: selectedTodo)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let todoDetailViewController = segue.destination as? TodoDetailViewController {
            if let toDo = sender as? TodoData {
                todoDetailViewController.todo = toDo
            }
        }
    }
}


