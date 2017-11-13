//
//  ViewController.swift
//  Notes
//
//  Created by Christopher Smith on 11/12/17.
//  Copyright © 2017 Christopher Smith. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var noteForSegue: Note?
    
    var notes = [Note]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - IBActions
    
    @IBAction func addButtonPushed(_ sender: Any) {
        self.performSegue(withIdentifier: "addNoteSegue", sender: nil)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchNotes()
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "noteDetailSegue" {
            
            guard let note = self.noteForSegue else {
                print("Could not get note.")
                return
            }
            
            let controller = segue.destination as! NoteDetailViewController
            controller.note = note
        }
    }
    
    // MARK: - Convenience Methods
    
    private func fetchNotes() {
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            let notes = try CoreData.context.fetch(fetchRequest)
            self.notes = notes
            
        } catch let error {
            print("There was an error: \(error.localizedDescription)")
        }
    }
}

    // MARK: - UITableView

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let note = self.notes[indexPath.row]
        
        cell.textLabel?.text = note.details
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = self.notes[indexPath.row]
        self.noteForSegue = note
        
        self.performSegue(withIdentifier: "noteDetailSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let note = self.notes[indexPath.row]
            CoreData.context.delete(note)
            try? CoreData.context.save()
            self.notes.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}
