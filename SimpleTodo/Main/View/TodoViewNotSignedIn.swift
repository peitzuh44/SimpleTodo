////
////  TodoViewNotSignedIn.swift
////  SimpleTodo
////
////  Created by Pei-Tzu Huang on 2024/8/29.
////
//
//import SwiftUI
//import SwiftUI
//
//struct TodoViewNotSignedIn: View {
//    @ObservedObject var authManager: AuthManager
//    @State private var showAddSheet: Bool = false
//    @State var selectedTodo: Todo? = nil
//    @State private var showEditSheet: Bool = false
//    
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(vm.todos) { todo in
//                    HStack {
//                        Text(todo.name)
//                        Spacer()
//                        if todo.isDone {
//                            Button {
//                                Task {
//                                    await vm.undoMark(todoID: todo.id)
//                                }
//                            } label: {
//                                Image(systemName: "checkmark.square")
//                            }
//
//                        } else {
//                            Button {
//                                Task {
//                                    await vm.markAsDone(todoID: todo.id)
//                                }
//                            } label: {
//                                Image(systemName: "square")
//                            }
//                        }
//
//                    }
//                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
//                        Button(role: .destructive) {
//                            Task {
//                                await vm.deleteTodo(todoID: todo.id)
//                            }
//                            } label: {
//                                Label("delete", systemImage: "trash.fill")
//                            }
//                            Button {
//                            selectedTodo = todo
//                                
//                            } label: {
//                                Label("edit", systemImage: "pencil")
//                            }
//                            .tint(.blue)
//                    }
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button {
//                        showAddSheet = true
//                        
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//
//                }
//                ToolbarItem(placement: .topBarTrailing) {
//                    NavigationLink {
//                        SettingsView(authManager: authManager)
//
//                    } label: {
//                        Image(systemName: "gear")
//                    }
//
//
//                }
//            }
//            .navigationTitle("Todo")
//            
//            .sheet(isPresented: $showAddSheet, content: {
//                AddView(vm: vm)
//            })
//            .sheet(item: $selectedTodo) { todo in
//                EditView(selectedTodo: todo, vm: vm)
//
//            }
//            
//        }
//        .onAppear {
//            Task {
//                vm.fetchTodo()
//            }
//        }
//    }
//}
