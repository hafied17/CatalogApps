//
//  FavoriteProvider.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 02/11/21.
//

import Foundation
import CoreData
import UIKit
 
class FavoriteProvider {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteUser")
        
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func getMaxId(completion: @escaping(_ maxId: Int) -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.fetchLimit = 1
            do {
                let lastMember = try taskContext.fetch(fetchRequest)
                if let member = lastMember.first, let position = member.value(forKeyPath: "id") as? Int {
                    completion(position)
                } else {
                    completion(0)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getAllFavorite(completion: @escaping(_ Favorite: [FavoriteModel]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var favorites: [FavoriteModel] = []
                for result in results {
                    let favorite = FavoriteModel(
                        describ: result.value(forKeyPath: "describ") as? String,
                        developer: result.value(forKeyPath: "developer") as? String,
                        genre: result.value(forKeyPath: "genre") as? String,
                        id: result.value(forKeyPath: "id") as? Int32,
                        idGame: result.value(forKeyPath: "idGame") as? String,
                        image: result.value(forKeyPath: "image") as? String,
                        nameGame:  result.value(forKeyPath: "nameGame") as? String,
                        rating: result.value(forKeyPath: "rating") as? String,
                        released: result.value(forKeyPath: "released") as? String,
                        web: result.value(forKeyPath: "web") as? String
                    )
                    
                    favorites.append(favorite)
                }
                completion(favorites)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func getFavorite(_ id: Int, completion: @escaping(_ members: FavoriteModel) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first {
                    let favorite = FavoriteModel(
                        describ: result.value(forKeyPath: "describ") as? String,
                        developer: result.value(forKeyPath: "developer") as? String,
                        genre: result.value(forKeyPath: "genre") as? String,
                        id: result.value(forKeyPath: "id") as? Int32,
                        idGame: result.value(forKeyPath: "idGame") as? String,
                        image: result.value(forKeyPath: "image") as? String,
                        nameGame:  result.value(forKeyPath: "nameGame") as? String,
                        rating: result.value(forKeyPath: "rating") as? String,
                        released: result.value(forKeyPath: "released") as? String,
                        web: result.value(forKeyPath: "web") as? String
                    )
     
                    completion(favorite)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func createFavorite(
        _ describ: String,
        _ developer: String,
        _ genre: String,
        _ idGame: String,
        _ image: String,
        _ nameGame: String,
        _ rating: String,
        _ released: String,
        _ web: String,

        completion: @escaping() -> Void
    ) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: taskContext) {
                let favorite = NSManagedObject(entity: entity, insertInto: taskContext)
                self.getMaxId { id in
                    favorite.setValue(id+1, forKeyPath: "id")
                    favorite.setValue(genre, forKeyPath: "describ")
                    favorite.setValue(developer, forKeyPath: "developer")
                    favorite.setValue(genre, forKeyPath: "genre")
                    favorite.setValue(idGame, forKeyPath: "idGame")
                    favorite.setValue(image, forKeyPath: "image")
                    favorite.setValue(nameGame, forKeyPath: "nameGame")
                    favorite.setValue(rating, forKeyPath: "rating")
                    favorite.setValue(released, forKeyPath: "released")
                    favorite.setValue(web, forKeyPath: "web")
                        
                    do {
                        try taskContext.save()
                        completion()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }
        }
    }

    func deleteMember(_ id: Int32, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
    
    
}
