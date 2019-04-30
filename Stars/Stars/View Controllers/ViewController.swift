//
//  ViewController.swift
//  Stars
//
//  Created by Nelson Gonzalez on 4/30/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    let starController = StarController() //Initialize it


    override func viewDidLoad() {
        super.viewDidLoad()
       
       listStars()
        
    }
    
    //List all of the stars we're tracking
    func listStars() {
    
        //1. create a string
        var output = ""
        
        //2. append text about each star
        for star in starController.stars {
            output += "\(star.name) is \(star.distance) light years away.\n"
        }
        //3. display it in the textView
        textView.text = output
    }
    
    private func clearTextFields() {
        nameTextField.text = nil
        distanceTextField.text = nil
    }

    
    @IBAction func addStarButtonPressed(_ sender: UIButton) {
        
        print("Add Star")
        
        //name (String), distance (Double)
        
        guard let name = nameTextField.text, !name.isEmpty, let distanceString = distanceTextField.text, !distanceString.isEmpty, let distance = Double(distanceString) else {
            print("Invalid Input")
            return
        }
        
        starController.addStar(named: name, withDistance: distance)

        listStars()
        
        clearTextFields()
        
    }

}

