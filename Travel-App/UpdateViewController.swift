//
//  UpdateViewController.swift
//  Travel-App
//
//  Created by Enoch Ko on 3/11/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit
import CoreData

class UpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var editNameTextField: UITextField!
    @IBOutlet weak var editDescriptionTextField: UITextField!
    @IBOutlet weak var editImageView: UIImageView!
    
    var selectedIndex:Int = 0
    var places: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        editNameTextField.text = places[selectedIndex].value(forKey: "name") as? String
        editDescriptionTextField.text = places[selectedIndex].value(forKey: "small_description") as? String
        editImageView.image = UIImage(data: (places[selectedIndex].value(forKeyPath: "picture")  as? Data)!)
        
        
        
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
        editImageView.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
    }
    
    @IBAction func updateButton(_ sender: UIButton) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
    
        let place = places[selectedIndex]
        
        place.setValue(editNameTextField.text!, forKeyPath: "name")
        place.setValue(editDescriptionTextField.text!, forKeyPath: "small_description")
        place.setValue(UIImagePNGRepresentation(editImageView.image!), forKeyPath: "picture")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
        
        
        
        print(place)

    }


}
