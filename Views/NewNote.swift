//
//  NewNote.swift
//  Notes App
//
//  Created by Julia Molian Li on 11/19/18.
//  Copyright © 2018 Julia Molian Li. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class NewNote {
    var text: String = ""
    var date: String = ""
    var summary: String = ""
    let ref: DatabaseReference!
    
    init(text: String) {
        self.text = text
        self.date = "11/20/18"
        self.summary = ""
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference().child("\(uid!)").childByAutoId()
    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        if let value = snapshot.value as? [String:String] {
            self.text = value["text"] as! String
            self.date = value["date"] as! String
            self.summary = value["summary"] as! String
        }
        
    }
    
    func saveNew() {
        ref.setValue(toDict())
    }
    
    func edit() {
        ref.child("text").setValue(text)
        var subStr = ""
        if text.endIndex.encodedOffset > 40 {
            let index = text.index(text.startIndex, offsetBy: 40)
            subStr = "\(String(text[..<index]))..."
        }
        else {
            subStr = text
        }
        ref.child("summary").setValue(subStr)
    }
    
    func removeNote() {
        ref.removeValue()
    }
    
    func toDict() -> [String:Any] {
        var subStr = ""
        print(text.count)
        if text.count > 24 {
            let index = text.index(text.startIndex, offsetBy: 24)
            subStr = "\(String(text[..<index]))..."
        }
        else {
            subStr = text
        }
        return ["text": self.text, "date": self.date, "summary": subStr]
    }
    
}
