//
//  TodoViewModel.swift
//  SimpleTodo
//
//  Created by Pei-Tzu Huang on 2024/8/27.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class TodoViewModel: ObservableObject {
    // Initializing Firestore
    let db = Firestore.firestore()
    @Published var todos: [Todo] = []
    private var listenerRegistration: ListenerRegistration?
    
    // MARK: Fetch Todo
    func fetchTodo() {
       
        guard let user = Auth.auth().currentUser else {
            print("Current user not sign in")
            return
        }
        
        listenerRegistration = db.collection("todos")
            .whereField("createdBy", isEqualTo: user.uid)
            .addSnapshotListener { [weak self] querySnapshot, error in
            guard let self = self else { return }
            guard let documents = querySnapshot?.documents, error == nil else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            self.todos = documents.compactMap { try? $0.data(as: Todo.self)}
        }
        
        
    }
    
    // MARK: Add Todo
    func addTodo(name: String, due: Date) async {
        
        
        // Make sure that current user is signin so we have the uid
        guard let user = Auth.auth().currentUser else {
            print("Current user not sign in")
            return
        }
        
        let todoRef = db.collection("todos").document()
        let todoID = todoRef.documentID
        let todo = Todo(id: todoID, createdBy: user.uid, timeCreated: Date(), name: name, due: due, isDone: false)
        do {
            try
            db.collection("todos").document(todoID)
                .setData(from: todo)
            print("Document with id: \(todoID) added sucessfully!")
        } catch {
            print("Error adding document: \(error)")
        }
    }
    
    // MARK: Edit Todo
    func editTodo(todoID: String, name: String, due: Date) async {
        let todoRef = db.collection("todos").document(todoID)
        do {
            try await todoRef.updateData(
                ["name": name,
                 "due": due
                ]
            )
            print("Document with id: \(todoID) was sucessfully edited.")
        } catch {
            print("Error adding document: \(error)")
        }
        
    }
    
    
    // MARK: Delete Todo
    func deleteTodo(todoID: String) async {
        let todoRef = db.collection("todos").document(todoID)
        do {
            try await todoRef.delete()
            print("Document successfully removed!")
        } catch {
            print("Error removing document: \(error)")
            
        }
        
    }
    
    
    // MARK: Mark Todo As Done
    func markAsDone(todoID: String) async {
        let todoRef = db.collection("todos").document(todoID)
        
        do {
            try await todoRef.updateData(
                ["isDone" : true]
            )
            
            print("Sucessfully mark todo as done.")
            
            // Manually Update the Todo Array
            if let index = todos.firstIndex(where: {$0.id == todoID}) {
                DispatchQueue.main.async {
                    self.todos[index].isDone = true
                }
            }
            
        } catch {
            print ("Error marking todo as done.")
        }
    }
    
    func undoMark(todoID: String) async {
        let todoRef = db.collection("todos").document(todoID)
        
        do {
            try await todoRef.updateData(
                ["isDone" : false]
            )
            // Manually Update the Todo Array
            if let index = todos.firstIndex(where: {$0.id == todoID}) {
                DispatchQueue.main.async {
                    self.todos[index].isDone = false
                }
            }
            
            print("Sucessfully mark todo as done.")
            
        } catch {
            print ("Error marking todo as done.")
        }
    }
    
}
