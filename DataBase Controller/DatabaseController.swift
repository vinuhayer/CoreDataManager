//
//  DatabaseController.swift
//  DataBase Controller
//
//  Created by Appinventiv-Mac on 08/03/18.
//  Copyright © 2018 Appinventiv-Mac. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DBController
{
    let entityName: String?
    var entities = [NSManagedObject]()
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(nameOfEntity: String)
    {
        self.entityName = nameOfEntity
    }
    
    func save()
    {
        do {
            try managedContext.save()     
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: SAVE DATA
    
    func saveData(namePassed:String,mobilePassed:String) {
        
        let entity = NSEntityDescription.entity(forEntityName: entityName!,
                                                in: managedContext)!
        let user = NSManagedObject(entity: entity,
                                   insertInto: managedContext) as! Person
        
        //at this point object saves atrributes with nil values
        
        if((Validations.validate_mobile(mobile: mobilePassed)==true)&&(Validations.validate_name(name:namePassed))) {
            user.name = namePassed
            user.mobile = mobilePassed
            self.save()
            Alerts.displayAlertMessage(messageToDisplay: "Data Stored")
        }
        else {
            managedContext.delete(user) //necessary to avoid storing a nil value
            Alerts.displayAlertMessage(messageToDisplay: "Enter Valid Data")
        }
    }
    
    //MARK: FETCH DATA
    
    func fetchData()->[NSManagedObject]?
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName!)
        do{
            return (try (managedContext.fetch(fetchRequest) as? [NSManagedObject]))!
        } catch let error as NSError{
           print("Could not fetch. \(error), \(error.userInfo)")
           return nil
        }
    }
    
    //MARK: DROP DATA
    
    func dropData() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName!)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(batchDeleteRequest)
            self.save()
            Alerts.displayAlertMessage(messageToDisplay: "Data Dropped")
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: DELETE DATA
    
    func deleteData(index:Int?)->[NSManagedObject] {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName!)

        do {
            entities=try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
                managedContext.delete(entities[index!])
                self.save()
                entities.remove(at: index!)
                Alerts.displayAlertMessage(messageToDisplay: "Data Deleted")
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return entities
    }

    //MARK: UPDATE DATA

    func updateData(index:Int?,mobile:String)-> [NSManagedObject] {

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName!)

            do {
                entities=try managedContext.fetch(fetchRequest) as! [NSManagedObject]
                self.save()
                
                entities[index!].setValue(mobile, forKey: "mobile") //setting value for a key (attribute) at an index.
            
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            return entities
    }

}
