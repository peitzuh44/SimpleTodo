//
//  EditView.swift
//  SimpleTodo
//
//  Created by Pei-Tzu Huang on 2024/8/27.
//

import SwiftUI

struct EditView: View {
    @Environment (\.presentationMode) var prsentationMode
    @ObservedObject var vm: TodoViewModel
    let selectedTodo: Todo
    @State private var name: String
    @State private var due: Date
    init(selectedTodo: Todo, vm: TodoViewModel) {
        self.selectedTodo = selectedTodo
        self.vm = vm
        _name = State(initialValue: selectedTodo.name)
        _due = State(initialValue: selectedTodo.due)
      
    }
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("todo name", text: $name)
                    DatePicker("Due", selection: $due, displayedComponents: .date)
                }
                Spacer()
                Button {
                    // Task allows the use of keyword async/await. The addTodo method is async so we need to use the keyword await when calling it.
                    Task {
                        await vm.editTodo(todoID:selectedTodo.id,
                                          name: name,
                                          due: due)
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
            .navigationTitle("Edit todo")
        }
    }
}

