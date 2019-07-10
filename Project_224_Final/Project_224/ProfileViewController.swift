//
//  ViewController.swift
//  Project_224
//
//  Copyright © 2019 Gary Walsh. All rights reserved.
//

import UIKit
import os

/// Profile view controller class
class ProfileViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    //MARK: properties
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var resultField: UILabel!
    @IBOutlet weak var resultText: UILabel!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var profile: Profile?

    // Cancel function
    @IBAction func cancel(_ sender: Any) {
        if presentingViewController is UINavigationController{
            //Add
            dismiss(animated: true, completion:nil)
        }
        else if let owningNavigationController = navigationController{
            // Edit
            owningNavigationController.popViewController(animated:true)
        }
    }
    
    /// function to enable user getting a picture from the picture library.
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    /// To enable user change their profile picture from the photo library.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            os_log("Missing image in %@", log: OSLog.default, type: .debug, info)
            return
        }
        
        profileImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Do any additional setup after loading the view.
        if let profile = profile {
            /// only entered if item was set by the table view controller on edit
            self.profileImage.image = profile.image
            self.nameField.delegate = profile.name as? UITextFieldDelegate
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        /// Configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("the save button for kilo was not pressed, canceling", log: OSLog.default, type: .debug)
            return
        }
        profile = Profile(image: profileImage.image ?? #imageLiteral (resourceName: "defaultImage"), name: nameField.text!)
    }
    
    /// To check the result function
    func checkResult(result: Double)->String {
        
        var returnString = ""
        
        if (result <= 18.5){
            returnString = ("are underweight!")
        } else if (result <= 24.9) {
            returnString = ("have a normal weight!")
        } else if (result <= 29.9){
            returnString = ("are overweight!")
        } else if (result > 29.9){
            returnString = ("are obese!")
        } else {
            returnString = ("did something wrong.")
        }
        return(returnString)
    }
    
    /// Convert button function
    @IBAction func convertButton(_ sender: Any) {
        let h = Double(heightField.text!)
        let w = Double(weightField.text!)
        let Vbmi = Bmi(height:h!,weight:w!)
        resultField.text=String(Vbmi.bmi())
        resultText.text=String(checkResult(result: Vbmi.bmi()))
        /// resultPoundsText.text=String(bmi())
    }
}