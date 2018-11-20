//
//  EditViewController.swift
//  Notes App
//
//  Created by Julia Molian Li on 11/16/18.
//  Copyright © 2018 Julia Molian Li. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    var listEdit : String?
    var oldNote: Bool = false
    var note: NewNote?
    @IBOutlet var editTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (oldNote) {
            editTextView.text = note?.text
        }
        self.view.backgroundColor = MyColors.lightColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (oldNote) {
            note?.text = editTextView.text
            note?.edit()
        }
        else {
            let newNote = NewNote(text: editTextView.text)
            newNote.saveNew()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
