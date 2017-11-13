//
//  NoteDetailViewController.swift
//  Notes
//
//  Created by Christopher Smith on 11/12/17.
//  Copyright © 2017 Christopher Smith. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController, UITextViewDelegate {
    
    // MARK: Properties
    
    var note: Note?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var noteDetailTextView: UITextView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // MARK: IBActionss
    
    @IBAction func doneButtonPushed(_ sender: UIBarButtonItem) {
        
        if sender.title == "Edit" {
            sender.title = "Done"
            self.noteDetailTextView.isEditable = true
            self.noteDetailTextView.becomeFirstResponder()
            return
        }
        
        guard let note = self.noteDetailTextView.text else {
                print("Missing details.")
                return
        }
        
        self.note?.details = note
        
        self.saveContext()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.doneButton.title = "Edit"
        self.noteDetailTextView.isEditable = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.view.backgroundColor = .green
        
        guard let note = note else {
            print("Error: No Note Available")
            return
        }
        self.noteDetailTextView.text = note.details
        self.noteDetailTextView.backgroundColor = .green
    }
    
    // MARK: - Convenience Methods
    
    private func saveContext() {
        
        do {
            try CoreData.context.save()
        } catch let error {
            print("Error while saving new note: \(error.localizedDescription)")
        }
    }
    
    // func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
    // }
}
