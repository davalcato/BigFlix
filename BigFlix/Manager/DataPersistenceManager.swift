//
//  DataPersistenceManager.swift
//  BigFlix
//
//  Created by Daval Cato on 9/8/22.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    // for the error for the "do" case below
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchDatabase
        // pass new error
        case failedToDeleteData
    }
    
    // a shared instance across the app
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        
        // download title with model passed inside collectionView
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // enable us to talk to the manager
        let context = appDelegate.persistentContainer.viewContext
        // what we're storing in database / pass context
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        // populate all the attributes
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        do {
            // context manager waiting for us to order and save data
            try context.save()
            // if we manager to save the data pass the success empty result
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    // call new func
    func fetchingTitlesFromDatabase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        
        // download title with model passed inside collectionView
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // enable us to talk to the manager
        let context = appDelegate.persistentContainer.viewContext
        
        // talk to contect manager for a request
        let request: NSFetchRequest<TitleItem>
        // request ready to be executed for the context manager
        request = TitleItem.fetchRequest()
        
        // dispatch the request for database
        do {
            // asking to access the database
            let titles = try context.fetch(request)
            // pass back to the result
            completion(.success(titles))
            
        } catch {
            print(error.localizedDescription)
            completion(.failure(DatabaseError.failedToFetchDatabase))
        }
    }
    // new function to get TitleItem
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        
        // download title with model passed inside collectionView
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // enable us to talk to the manager
        let context = appDelegate.persistentContainer.viewContext
        
        // asking database to delete certain objects
        context.delete(model)
        
        // commit those changes inside database
        do {
            // confirm deletion
            try context.save()
            completion(.success(()))
            
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
        
    }
    
}











