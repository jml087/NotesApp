//
//  ListViewController.swift
//  Notes App
//
//  Created by Julia Molian Li on 11/16/18.
//  Copyright © 2018 Julia Molian Li. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ListViewController: UIViewController {

    @IBOutlet var notesTableView: UITableView!
    var notes: [NewNote] = []
    var editVC : EditViewController?
    var ref : DatabaseReference!
    var noteToEdit: NewNote?
    var oldNote: Bool = false
    @IBOutlet var logo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.delegate = self;
        notesTableView.dataSource = self;
        updateList()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        logo.center.x = self.view.center.x
        self.view.backgroundColor = MyColors.lightColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? EditViewController
        
        if (oldNote) {
            controller?.note = noteToEdit
            controller?.oldNote = true
        }
    }
    
}

// MARK: - IBActions
extension ListViewController {

    @IBAction func backToList(_ sender: UIStoryboardSegue) {
        updateList()
    }
    
    @IBAction func newList(_ sender: Any) {
        oldNote = false
        performSegue(withIdentifier: "toEditVC", sender: Any?.self)
    }
}
//Handlers
extension ListViewController {
    func updateList() {
        let uid = Auth.auth().currentUser?.uid
        
        ref = Database.database().reference().child("\(uid!)")
        ref.observe(DataEventType.value, with: { (snapshot) in
            self.notes.removeAll()
            print("children count!: \(snapshot.childrenCount)")
            for child in snapshot.children {
                let note = (child as! DataSnapshot)
                let newNote = NewNote(snapshot: note)
                print(newNote)
                self.notes.insert(newNote, at: 0)
                print(self.notes.count)
            }
            self.notesTableView.reloadData()
        })
        
        
    }
    
}
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("notes.count: \(notes.count)")
        return notes.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        cell.note = notes[indexPath.row]
        cell.textLabel?.text = notes[indexPath.row].summary
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes[indexPath.row].removeNote()
            self.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noteToEdit = notes[indexPath.row]
        oldNote = true
        
        performSegue(withIdentifier: "toEditVC", sender: Any?.self)
    }
    
}
