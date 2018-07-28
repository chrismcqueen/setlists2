//
//  ViewController.swift
//  setlists2
//
//  Created by Chris McQueen on 7/26/18.
//  Copyright © 2018 Chris McQueen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var setlist: Setlist?

    
    @IBOutlet weak var songKeyTextField: UITextField!
    @IBOutlet weak var setlistNameTextField: UITextField!
    @IBOutlet weak var saveSetlistButton: UIBarButtonItem!
    
    @IBAction func nextKeyPressed(_ sender: Any) {
        self.songKeyTextField.becomeFirstResponder()
    }
    
    //////// not working yet, eventually should work same as SAVE button
    @IBAction func doneKeyPressed(_ sender: Any) {
    }
    /////////////
    
    
    @IBAction func cancelSetlist(_ sender: Any) {
        let isInAddMode = presentingViewController is UINavigationController
        
        if isInAddMode {
        dismiss(animated: true, completion: nil)
        }
        else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setlistNameTextField.becomeFirstResponder()
        
        if let setlist = setlist {
            setlistNameTextField.text = setlist.name
            songKeyTextField.text = setlist.key
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as AnyObject? === saveSetlistButton {
            let name = setlistNameTextField.text ?? ""
            let key = songKeyTextField.text ?? ""
            setlist = Setlist(name: name, key: key)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

