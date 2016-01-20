//
//  SettingsViewController.swift
//  INSA_Portail_Captif
//
//  Created by Arthur Papailhau on 20/01/16.
//  Copyright © 2016 Arthur Papailhau. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController, NSTextFieldDelegate {
    
    @IBOutlet weak var pseudoTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var saveAndCloseButton: NSButton!
    
    var pseudoChanged = false
    var passwordChanged = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if let pseudo =  NSUserDefaults.standardUserDefaults().stringForKey(Information.pseudo) {
            pseudoTextField.stringValue = pseudo
        }
        if let password = NSUserDefaults.standardUserDefaults().stringForKey(Information.password) {
            passwordTextField.stringValue = password
        }
        saveAndCloseButton.enabled = false
        pseudoTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        if (obj.object as? NSTextField == self.pseudoTextField) {
            if (pseudoTextField.stringValue.characters.count > 0) {
                pseudoChanged = true
            } else {
                pseudoChanged = false
            }
        }
        else if (obj.object as? NSTextField == self.passwordTextField) {
            if (passwordTextField.stringValue.characters.count > 0) {
                passwordChanged = true
            } else {
                passwordChanged = false
            }
        }
        updateUI()
    }
    
    func updateUI(){
        if (pseudoChanged && passwordChanged) {
            saveAndCloseButton.enabled = true
        } else {
            saveAndCloseButton.enabled = false
        }
    }
    
    @IBAction func saveAndCloseButton(sender: AnyObject) {
        let myDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        
        NSUserDefaults.standardUserDefaults().setObject(pseudoTextField.stringValue, forKey: Information.pseudo)
        NSUserDefaults.standardUserDefaults().setObject(passwordTextField.stringValue, forKey: Information.password)
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: Information.saved)
        NSUserDefaults.standardUserDefaults().synchronize()
    
        myDelegate.updateItemMenuEnabled()
        myDelegate.closePopover(sender)
    }

}