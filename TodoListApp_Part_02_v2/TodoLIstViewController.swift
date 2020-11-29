//
//  TodoListViewController.swift
//  TodoListApp_Part_02
//
//  Created by Raj Kumar Shahu on 2020-11-21.
//  StudentID: 300783746
//  @Desc: This is the second part of a three-part Todo List Assignment. This part consists of creation of tthe logic that powers the User Interface (UI) for the Todo App
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
        
    }
    
    // Anytime view is about to appear this function gets called. This is where we access coredata
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataToDoData = try? context.fetch(TodoData.fetchRequest()) as? [TodoData] {
                todos = coreDataToDoData
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    
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


