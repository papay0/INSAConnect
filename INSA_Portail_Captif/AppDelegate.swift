//
//  AppDelegate.swift
//  INSA_Portail_Captif
//
//  Created by Arthur Papailhau on 20/01/16.
//  Copyright © 2016 Arthur Papailhau. All rights reserved.
//

import Cocoa
import Alamofire

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!
    
    @IBOutlet weak var connectionResidenceItem: NSMenuItem!
    @IBOutlet weak var connectionWifiINSAItem: NSMenuItem!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let popover = NSPopover()
    
    let network = Network()

    func applicationDidFinishLaunching(aNotification: NSNotification) {

        //cleanNSUserDefaults()
        
        let icon = NSImage(named: "statusIcon")
        icon?.template = true
        
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        popover.contentViewController = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        popover.behavior = NSPopoverBehavior.Transient

        statusMenu.autoenablesItems = false
        connectionResidenceItem.enabled = false
        connectionWifiINSAItem.enabled = false
        
        updateItemMenuEnabled()
    }
    
    func updateItemMenuEnabled() {
        if NSUserDefaults.standardUserDefaults().boolForKey(Information.saved) {
            connectionResidenceItem.enabled = true
            connectionWifiINSAItem.enabled = true
        }
    }
    
    func cleanNSUserDefaults() {
        let appDomain = NSBundle.mainBundle().bundleIdentifier!
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
    }

    @IBAction func connectionResidenceButtonClicked(sender: NSMenuItem) {
        let pseudo = NSUserDefaults.standardUserDefaults().stringForKey(Information.pseudo)!
        let password = NSUserDefaults.standardUserDefaults().stringForKey(Information.password)!
        let URL = "https://portail-promologis-lan.insa-toulouse.fr:8003"
        network.requestServerForAConnection(URL, pseudo: pseudo, password: password)
    }
    
    @IBAction func settingsButtonClicked(sender: NSMenuItem) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    @IBAction func connectionWifiINSAButtonClicked(sender: NSMenuItem) {
        let pseudo = NSUserDefaults.standardUserDefaults().stringForKey(Information.pseudo)!
        let password = NSUserDefaults.standardUserDefaults().stringForKey(Information.password)!
        let URL = "https://portail-invites-lan.insa-toulouse.fr:8003"
        network.requestServerForAConnection(URL, pseudo: pseudo, password: password)

    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
    }
    
    @IBAction func quitButtonClicked(sender: NSMenuItem) {
         NSApplication.sharedApplication().terminate(self)
    }
    
}

