//
//  ViewController.swift
//  Travel-App
//
//  Created by Enoch Ko on 3/11/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tablelist: UITableView!
    var users_count:Int = 0
    var places: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Places")
        do {
            places = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        print(places.count)
        print("loaded again")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext =
            appDelegate!.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Places")
        do {
            places = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        print(places.count)
        return places.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
//        let place = places[indexPath.row]
//        cell.textLabel?.text = place.value(forKeyPath: "name") as? String
        
        
        
        
        let cell:MyCustomCell = tablelist.dequeueReusableCell(withIdentifier: "cell") as! MyCustomCell
        
        let place = places[indexPath.row]
        cell.myCellName.text = place.value(forKeyPath: "name") as? String
        let picture = UIImage(data: place.value(forKeyPath: "picture")  as! Data)
        cell.myCellPicture.image = picture
        
        return(cell)
        
        
        
    }

}

