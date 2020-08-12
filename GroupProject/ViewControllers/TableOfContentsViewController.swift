//
//  TableOfContentsViewController.swift
//  GroupProject
//
//  Created by Oreoluwa Omomofe on 7/24/20.
//  Copyright © 2020 One Summer Chicago. All rights reserved.
//

import UIKit

class TableOfContentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableOfContentsTableView: UITableView!
    
    // table of contents options
    var contents = ["Home", "My Textbooks", "Audio Text", "Search", "Help", "Log Out", "Request a book"]
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contents.count

           }
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
               cell.textLabel?.text = contents[indexPath.row]
               return cell
           
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
       }
}

