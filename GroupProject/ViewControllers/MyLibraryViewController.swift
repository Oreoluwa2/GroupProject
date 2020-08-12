//
//  MyLibraryViewController.swift
//  GroupProject
//
//  Created by Oreoluwa Omomofe on 7/29/20.
//  Copyright © 2020 One Summer Chicago. All rights reserved.
//

import UIKit

class MyLibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var libaryBooksOutlet: UITableView!
    // Library book options
    var books = ["Napoleon", "Purple Hibiscus", "And There Were None", "Great Expectations", "Dr Suess", "Bleak House", "Search for more"]
       
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return books.count

              }
             func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                  let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2")!
                  cell2.textLabel?.text = books[indexPath.row]
                  return cell2
              
       }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
