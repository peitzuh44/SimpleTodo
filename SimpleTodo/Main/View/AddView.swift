//
//  AddView.swift
//  SimpleTodo
//
//  Created by Pei-Tzu Huang on 2024/8/27.
//

import SwiftUI

struct AddView: View {
    @Environment (\.presentationMode) var prsentationMode
    @StateObject var vm: TodoViewModel
    @State private var todoText: String = ""
    @State private var todoDueDate: Date = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("todo name", text: $todoText)
                    
                    DatePicker("Due", selection: $todoDueDate, displayedComponents: .date)
                }
                Spacer()
                Button {
                    // Task allows the use of keyword async/await. The addTodo method is async so we need to use the keyword await when calling it. 
                    Task {
                        await vm.addTodo(name: todoText, due: todoDueDate)
                        prsentationMode.wrappedValue.dismiss()
                    }
                   
                } label: {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .foregroundStyle(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.accentColor)
                        )
                        .padding()
            
                        
                }

            }
            .navigationTitle("Add new todo")
        }
    }
}

