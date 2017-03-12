//
//  DetailViewController.swift
//  Travel-App
//
//  Created by Enoch Ko on 3/11/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var detailName: UILabel?
    @IBOutlet weak var detailPicture: UIImageView?
    @IBOutlet weak var detailDescription: UILabel?
    var selectedIndex:Int = 0
    var places: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailName?.text = places[selectedIndex].value(forKeyPath: "name") as? String
        self.detailDescription?.text = places[selectedIndex].value(forKeyPath: "small_description") as? String

        self.detailPicture?.image = UIImage(data: (places[selectedIndex].value(forKeyPath: "picture")  as? Data)!)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.viewDidLoad()
        self.detailName?.text = places[selectedIndex].value(forKeyPath: "name") as? String
        self.detailDescription?.text = places[selectedIndex].value(forKeyPath: "small_description") as? String
        
        self.detailPicture?.image = UIImage(data: (places[selectedIndex].value(forKeyPath: "picture")  as? Data)!)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "edit" {
            let updateViewController = segue.destination as! UpdateViewController
            updateViewController.selectedIndex = selectedIndex
            updateViewController.places = places
        }
    }

}
