//
//  ViewController.swift
//  YashTodo project
//
//  Created by Felix IT on 17/11/22.
//  Copyright © 2022 Felix IT. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var todoArr: [Todo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTodos()
    }

    func fetchTodos() {
        do {
         todoArr = try context.fetch(Todo.fetchRequest())
            todoTableView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    @IBAction func AddTodo(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddTodoViewController")as! AddTodoViewController
        
    navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = todoArr[indexPath.row].title
        return cell!
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = todoArr[indexPath.row]
        
        let ac = UIAlertController(title: "Operation", message: nil, preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "Update", style: .default) { (act) in
            self.editTodoAction(obj: obj)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (act) in
            self.deleteTodo(obj: obj)
        }
        let cancleAction = UIAlertAction(title: "Cancle", style: .cancel) { (act) in
            
        }
        
        ac.addAction(editAction)
        ac.addAction(deleteAction)
        ac.addAction(cancleAction)
        
        present(ac, animated: true, completion: nil)
    }
    func editTodoAction(obj: Todo) {
        let ac = UIAlertController(title: "Edit Todo", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.textFields?.first?.text = obj.title
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (act) in
            self.saveEditedcontent(obj: obj, newValue: (ac.textFields?.first?.text)!)
        }
        let cancleAction = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        
        ac.addAction(saveAction)
        ac.addAction(cancleAction)
        
        present(ac, animated: true, completion: nil)
    }

    
    func saveEditedcontent(obj: Todo, newValue: String) {
        obj.title = newValue
        do {
            try context.save()
            fetchTodos()
        }catch let error {
            print(error.localizedDescription)
        }
    }
    func deleteTodo(obj: Todo) {
        do {
            context.delete(obj)
            try context .save()
            fetchTodos()
        }catch let error {
            print(error.localizedDescription)
        }
    }
}

