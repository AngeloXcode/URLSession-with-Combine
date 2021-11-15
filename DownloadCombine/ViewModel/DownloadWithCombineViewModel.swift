//
//  DownloadWithCombineViewMode.swift
//  DownloadCombine
//
//  Created by Angelo Essam on 15/11/2021.
//

import Foundation
import SwiftUI
import Combine

class DownloadWithCombineViewModel : ObservableObject{
    
    @Published var posts : PostModel = []
    var cancallables = Set<AnyCancellable>()
   
    init(){
        getPosts()
    }
    
    private func getPosts(){
        guard let url  = URL(string:"https://jsonplaceholder.typicode.com/posts") else { return }
        
        // Newtrok Request to download data
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on:DispatchQueue.global(qos: .background))
            .receive(on:DispatchQueue.main)
            .tryMap(handlerOutput) // check data is true
            .decode(type: PostModel.self, decoder: JSONDecoder()) // decode data into model
            .replaceError(with: [])
            .sink { (completion) in
                switch completion{
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("Error : \(error)")
                }
            } receiveValue: { [weak  self] (model) in
                self?.posts = model
            }// cancel subscribtion if needed
            .store(in: &cancallables)

          
    }
    
    private func handlerOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data{
        guard let resposne =  output.response as? HTTPURLResponse, resposne.statusCode >= 200 && resposne.statusCode < 300 else{
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
