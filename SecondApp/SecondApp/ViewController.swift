//
//  ViewController.swift
//  SecondApp
//
//  Created by Andrew Jaffee on 4/2/20.
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

    // MARK: - ViewController delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // MARK: - App group utilities
    
    func setViewBackgroundColor() {
        
        // 1) Get a reference to the shared user defaults for the
        // app group we created.
        if let groupUserDefaults = UserDefaults(suiteName: appGroupID) {
            
            // 2) Read the value for the "BackgroundColor" key stored
            // in our app group shared container's preferences
            // (user defaults).
            if let backgroundColor = (groupUserDefaults.object(forKey: "BackgroundColor")) as? String {
                
                // 3) Set the background color of our NSView to
                // the value we read from the our shared container's
                // preferences.
                self.view.wantsLayer = true
                
                self.view.needsDisplay = true
                
                if backgroundColor == "Red" {
                    self.view.layer?.backgroundColor = NSColor.red.cgColor
                }
                else if backgroundColor == "Green" {
                    self.view.layer?.backgroundColor = NSColor.green.cgColor
                }
                else if backgroundColor == "Blue" {
                    self.view.layer?.backgroundColor = NSColor.blue.cgColor
                }
                else {
                    self.view.layer?.backgroundColor = NSColor.gray.cgColor
                }
                
                print("Read background color, \(backgroundColor), from shared user defaults.")
                
            } // end if let backgroundColor =...
            
        } // end if let groupUserDefaults =...
        
    } // end func setViewBackgroundColor()
    
    // MARK: - Handle user actions
    
    @IBAction func updateViewColorButtonPushed(_ sender: Any) {
        
        self.setViewBackgroundColor()
        
    }
    
    @IBAction func closeButtonPushed(_ sender: Any) {
        NSApplication.shared.terminate(sender)
    }
    
} // end class ViewController

