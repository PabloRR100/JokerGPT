//
//  ContentView.swift
//  JokerGPT
//
//  Created by Pablo Ruiz on 25/8/23.
//

import SwiftUI
import OpenAISwift


// Implement it with a Class
//final class ViewModel: ObservableObject {
//    init() {}
//    
//    private var client: OpenAISwift?
//    
//    func setup() {
//        let key = "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"
//        client = OpenAISwift(config: OpenAISwift.Config.makeDefaultOpenAI(apiKey: key))
//    }
//    
//    func send(
//        text: String,
//        completion: @escaping (String) -> Void
//    ){
//        client?.sendCompletion(
//            with: text,
//            maxTokens: 500,
//            completionHandler: {result in
//                switch result {
//                case .success(let response):
//                    let output = response.choices?.first?.text ?? ""
//                    completion(output)
//                case .failure:
//                    break
//                }
//            }
//        )
//    }
//}

struct ContentView: View {
    
    let key = "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"
    let client = OpenAISwift(config: OpenAISwift.Config.makeDefaultOpenAI(apiKey: "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"))
    
    @State var text = "Cuentame un chiste"
    @State var joke = ""
    
    func tellJoke() async -> String {
        
        do {
            let result = try await client.sendCompletion(
                with: text,
                model: .gpt3(.davinci),
                maxTokens: 100,
                temperature: 1.0
            )
            return result.choices?.first?.text ?? ""
        } catch {
            print("Error calling the API!")
            return ""
        }
    }
    
    var body: some View {
        
        ZStack {
            
            Color(.systemMint).ignoresSafeArea()
            
            VStack {
                
                Spacer(minLength: 200)
                VStack {
                    
                    Text("Cuenta Chistes").font(.largeTitle).bold()
                    
                }
                .padding()
                .background(
                    Rectangle()
                        .foregroundColor(.pink)
                        .cornerRadius(15)
                        .shadow(radius: 15)
                )
                
                Spacer(minLength: 50)
                
                Button("Cuenta!") {
                    Task {
                        joke = await tellJoke()
                        print(joke)
                    }
                }
                .padding()
                .background(
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 15)
                )
                Spacer()
                
                Text(joke)
                    .opacity(joke.isEmpty == true ? 0.0 : 1.0)
//                print("Empty \(joke.isEmpty == true ? 0.0 : 1.0)")
            }
        }
    }
//        .onAppear { viewModel.setup() }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() // Initialize your struct
    }
}
