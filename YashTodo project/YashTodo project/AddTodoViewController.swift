//
//  AddTodoViewController.swift
//  YashTodo project
//
//  Created by Felix IT on 17/11/22.
//  Copyright © 2022 Felix IT. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController {

    @IBOutlet weak var todotf: UITextField!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveTodo(_ sender: UIButton) {
        let todo = Todo(context: context)
        todo.title = todotf.text
        todo.createdAt = 1
        do {
         try context.save()
        }catch let error {
            print(error.localizedDescription)
        }
        navigationController?.popViewController(animated: true)
    }
    
    

}
