//
//  CoreDataModel.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/29/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataModel {
    var favoriteLeagueObject = [NSManagedObject]()
    var favoriteLeagueList = [FavoriteLeague]()
    
    private let manageContext: NSManagedObjectContext
    init(){
        manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    func gitAllData() -> [FavoriteLeague]{
        favoriteLeagueObject = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeagues")
        do{
            favoriteLeagueObject = try manageContext.fetch(fetchRequest)
        }catch let error{
            print(error)
        }
        for index in 0..<favoriteLeagueObject.count{
            let id = favoriteLeagueObject[index].value(forKey: "id") as! String
            let image = favoriteLeagueObject[index].value(forKey: "image") as! String
            let name = favoriteLeagueObject[index].value(forKey: "name") as! String
            let youtubeUrl = favoriteLeagueObject[index].value(forKey: "youtubeUrl") as! String
            
            let league = FavoriteLeague(id: id, name: name, image: image, youtubeUrl: youtubeUrl)
            favoriteLeagueList.append(league)
        }
        return favoriteLeagueList
    }
    
    func isLeagueInFavorate(ID: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeagues")
        let prdictae = NSPredicate(format: "id == %@", ID)
        fetchRequest.predicate = prdictae
        do{
            favoriteLeagueObject = try manageContext.fetch(fetchRequest)
        }catch let error{
            print(error)
        }
        if favoriteLeagueObject.count == 0 {
            return false
        }
        return true
    }
    
    func getLeagueByID(ID: String) -> NSManagedObject {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeagues")
        let prdictae = NSPredicate(format: "id == %@", ID)
        fetchRequest.predicate = prdictae
        do{
            favoriteLeagueObject = try manageContext.fetch(fetchRequest)
        }catch let error{
            print(error)
        }
        //if favoriteLeagueObject.count == 0 {return 0}
        return favoriteLeagueObject[0]
    }
    func addLeague(league: FavoriteLeague){
        
        let entity = NSEntityDescription.entity(forEntityName:"FavoriteLeagues", in: manageContext)
        let myLeague = NSManagedObject(entity: entity!, insertInto: manageContext)
         
        myLeague.setValue(league.id, forKey: "id")
        myLeague.setValue(league.image, forKey: "image")
        myLeague.setValue(league.name, forKey: "name")
        myLeague.setValue(league.youtubeUrl, forKey: "youtubeUrl")
         do{
             try manageContext.save()
         }catch let error as NSError{
             print(error)
         }
    }
    
    func deleteLeague(leagueID: String){
        let deletedLeague = self.getLeagueByID(ID: leagueID)
        self.manageContext.delete(deletedLeague)
        do{
            try manageContext.save()
        }catch let error{
            print(error)
        }
    }
}

