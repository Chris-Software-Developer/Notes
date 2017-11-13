//
//  AddNote.swift
//  Notes
//
//  Created by Christopher Smith on 11/12/17.
//  Copyright © 2017 Christopher Smith. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var newNoteTextView: UITextView!
    
    // MARK: - IBActions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard
            let note = self.newNoteTextView.text else {
                print("Missing details.")
                return
        }
        
        let newNote = Note(context: CoreData.context)
        
        newNote.details = note
        
        self.saveContext()
        
    self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Note"
    }
    
    // MARK: - Convenience Methods
    
    private func saveContext() {
        
        do {
            try CoreData.context.save()
        } catch let error {
            print("Error while saving new note: \(error.localizedDescription)")
        }
    }
}
