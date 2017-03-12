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
    var selectedIndex:Int = 0
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
        let cell:MyCustomCell = tablelist.dequeueReusableCell(withIdentifier: "cell") as! MyCustomCell
        
        let place = places[indexPath.row]
        cell.myCellName.text = place.value(forKeyPath: "name") as? String
        let picture = UIImage(data: place.value(forKeyPath: "picture")  as! Data)
        cell.myCellPicture.image = picture
        
        return(cell)

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let detailViewController = segue.destination as! DetailViewController
        
//        let place = places[selectedIndex]
        detailViewController.selectedIndex = selectedIndex
        detailViewController.places = places
//        detailViewController.detailName?.text = place.value(forKeyPath: "name") as? String
//        detailViewController.detailDescription?.text = place.value(forKeyPath: "small_description") as? String
//        let picture = UIImage(data: place.value(forKeyPath: "picture")  as! Data)
//        detailViewController.detailPicture?.image = picture
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.places.removeAt(index: indexPath.row)
//            self.tablelist.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
//    
    
    

}

