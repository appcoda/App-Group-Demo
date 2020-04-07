//
//  ViewController.swift
//  FirstApp
//
//  Created by Andrew Jaffee on 3/30/20.
//
/*
 
 Copyright (c) 2020 Andrew L. Jaffee, microIT Infrastructure, LLC, and iosbrain.com.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
*/

import Cocoa

// our app group's identifier
let appGroupID = "group.YOUR_TEAM_ID.com.domain.MyAppSuite"

class ViewController: NSViewController {
    
    // MARK: - Outlets from user-facing components
    
    @IBOutlet weak var checkPlistTextField: NSTextField!
    @IBOutlet weak var backgroundColorTextField: NSComboBox!
    
    // MARK: - ViewController delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.checkPlistTextField.stringValue = "status unknown"
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // MARK: - Handle user actions
    
    /** 1)  Write a user preference to the app group's shared container.
    Once a value for a particular key is saved, that key/value
    pair is then available to ALL apps in the app group.
     */
    @IBAction func setSharedValueButtonPressed(_ sender: Any) {
        
        // 2) Make sure that the user picks one of the
        // possible view background colors (theme?)...
        if let backgroundColor = self.backgroundColorTextField.objectValueOfSelectedItem as? String {
            
            // 3) Write the user preference for view
            // "BackgroundColor" to the shared container.
            // See 3a below...
            self.setPreferenceValue(backgroundColor, forKey: "BackgroundColor", in: appGroupID)
            print("User selected \(backgroundColor) color.")
            
        }
        
    } // end func setSharedValueButtonPressed
    
    /** 4) If you want to share resources amongst all
    your apps in your app group, make sure your shared
    container exists before manipulating files/folder in it.
    See 4a below...
    */
    @IBAction func checkForPlistButtonPushed(_ sender: Any) {
        
        if self.sharedPreferencesPlistExists() {
            self.checkPlistTextField.stringValue = ".plist exists"
            print("Shared plist created.")
        }
        else {
            self.checkPlistTextField.stringValue = ".plist missing"
            print("Shared plist NOT created.")
        }
        
    } // end func checkForPlistButtonPushed
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        NSApplication.shared.terminate(sender)
    }
    
    // MARK: - App group utilities
    
    /** 3a) Write user preference to shared container. */
    func setPreferenceValue(_ value: Any?, forKey key: String, in appGroup: String) {
        
        // 3b) If we can access preferences to our app group...
        if let groupUserDefaults = UserDefaults(suiteName: appGroup) {
            
            // 3c) Write the value for the given key
            // to our shared container.
            groupUserDefaults.set(value, forKey: key)
            print("Wrote to shared user defaults.")
            
        }
        
    } // end func setPreferenceValue
    
    /** 4a) If you're going to manage and access common resources
     or assets in the shared container, remember that "It’s far better to
     attempt an operation (such as loading a file or creating a directory),
     check for errors, and handle those errors gracefully than it is to try
     to figure out ahead of time whether the operation will succeed."
        
     - returns: True if plist exists; false if it doesn't exist
    */
    func sharedPreferencesPlistExists() -> Bool {
        
        var containerExists = false
        
        let sharedFileManager = FileManager.default
        
        /* 4b) "In macOS, a URL of the expected form is always returned, even if the app group is invalid, so be sure to test that you can access the underlying directory before attempting to use it." */
        let sharedContainerFolderURL = sharedFileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroupID)
        // 4c) Now we build a standard path ("Library/Preferences/")
        // to the preferences data store file (plist). Note
        // the format of the plist's name.
        let sharedContainerPrefsPlistURL = (sharedContainerFolderURL?.appendingPathComponent("Library/Preferences/group.YOUR_TEAM_ID.com.domain.MyAppSuite.plist"))!
        // 4d) Try to read data from the preferences
        // plist file.
        let sharedContainerPrefsPlistData = NSData(contentsOf: sharedContainerPrefsPlistURL)
        // 4e) If the file exists...
        if let fileData = sharedContainerPrefsPlistData {
            
            // 4f) if the plist file has contents (bytes)...
            if fileData.length > 0 {
                
                // 4g) We know that the plist is valid.
                print(".plist file size: \(fileData.length)")
                containerExists = true
                
            }
            
        }
        
        return containerExists
        
    } // func sharedContainerExists()
        
} // class ViewController

