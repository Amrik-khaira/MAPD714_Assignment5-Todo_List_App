//
//  LocalStorage.swift
//  Author's name : Amrik Singh
//  StudentID : 301296257
//
//  Todo List App - Part 2
//
//  Created by Amrik on 25/11/22.
// Version: 1.1

import Foundation

class LocalStorage {
    static let shared = LocalStorage()
    
     var isTodoListUpdate: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: "isTodoListUpdate")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isTodoListUpdate")
        }
    }
    
    
    func saveDataInPersistent(toDoArr:ToDoList) {
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode([toDoArr]), forKey:"TodoList")
               
    }
    
    //MARK: - Get Saved Items
    func GetSavedItems() -> [ToDoList]  {
        if let data = UserDefaults.standard.value(forKey:"TodoList") as? Data {
         do
         {
            return try PropertyListDecoder().decode([ToDoList].self, from: data)
         } catch {
             return [ToDoList]()
         }
        } else {
               return [ToDoList]()
           }
    }
    
    
    
}
