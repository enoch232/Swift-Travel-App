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
    
    let insertContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var viewContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
    

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
        
        let entity = NSEntityDescription.entity(forEntityName: "Places", in: self.insertContext!)
        
        let newPlace = PlacesMO(entity: entity!, insertInto: self.insertContext!)
        
        newPlace.name = selectedImage.description
        let imageData = UIImagePNGRepresentation(selectedImage.image!)
        
        newPlace.picture = imageData! as NSData?
        newPlace.name = placeNameTextField.text!
        newPlace.small_description = placeDescriptionTextField.text!
        
        do {
            try self.insertContext?.save()
        } catch _ {
        }
        
        
        print(newPlace)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
