//
//  NewPlaceViewController.swift
//  Travel-App
//
//  Created by Enoch Ko on 3/11/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit
import CoreData

class NewPlaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var placeDescriptionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        let photoPicker = UIImagePickerController ()
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
        // display image selection view
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        picker .dismiss(animated: true, completion: nil)
        selectedImage.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let place = NSEntityDescription.insertNewObject(forEntityName: "Places", into: managedContext) as! PlacesMO
        place.setValue(placeNameTextField.text!, forKeyPath: "name")
        place.setValue(placeDescriptionTextField.text!, forKeyPath: "small_description")
        place.setValue(UIImagePNGRepresentation(selectedImage.image!), forKeyPath: "picture")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }


        
        print(place)
    }


}
