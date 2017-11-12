//
//  NoteDetailViewController.swift
//  Notes
//
//  Created by Christopher Smith on 11/12/17.
//  Copyright © 2017 Christopher Smith. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController, UITextViewDelegate {
    
    var note: Note?
    
    @IBOutlet weak var noteDetailTextView: UITextView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBAction func editButtonPushed(_ sender: Any) {
        self.noteDetailTextView.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
      guard let note = note else {
            print("Error: No Note Available")
            return
        }

        self.noteDetailTextView.text = note.details
    }
    
    override func setEditing (_ editing:Bool, animated:Bool)
    {
        super.setEditing(editing,animated:animated)
        if(self.isEditing)
        {
            self.editButtonItem.title = "Cancel"
        }else
        {
            self.editButtonItem.title = "Change"
        }
    }
    
   // func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
   // }
}
