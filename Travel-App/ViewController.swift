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
    var users_count:Int = 0

    var viewContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContextviewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        request.returnsObjectsAsFaults = false
        do {
            let users = try viewContext.fetch(request)
            users_count = users.count
            

        } catch {
            users_count = 0
        }
        print(users_count)
        return users_count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
        let place = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        
        do {
            let fetchedPlaces = try viewContext.fetch(place) as! [PlacesMO]
            let singlePlace = fetchedPlaces[indexPath.row]
            cell.textLabel?.text = singlePlace.name

        } catch {
            fatalError("Failed to fetch places: \(error)")
        }
        print("table row")
        return(cell)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedIndex = indexPath.row
//        performSegue(withIdentifier: "detail", sender: self)
//        
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        let detailController = segue.destination as! DetailController
//        detailController.selectedIndex = selectedIndex
//        detailController.placeList = self.placeList
//        
//    }
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.placeList.removeAt(index: indexPath.row)
//            self.tablelist.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }


}

