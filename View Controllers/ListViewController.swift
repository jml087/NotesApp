//
//  ListViewController.swift
//  Notes App
//
//  Created by Julia Molian Li on 11/16/18.
//  Copyright © 2018 Julia Molian Li. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet var notesTableView: UITableView!
    var notes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.delegate = self;
        notesTableView.dataSource = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - IBActions
extension ListViewController {
    @IBAction func logOut(_ segue: UIStoryboardSegue) {
    }
    
    
}
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "note", for: indexPath) as! NoteTableViewCell
        
        cell.textLabel?.text = cell.title
        
        return cell
    }
    
}
