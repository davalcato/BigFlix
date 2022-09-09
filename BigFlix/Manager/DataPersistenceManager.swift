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
}











