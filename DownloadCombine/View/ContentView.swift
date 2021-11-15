//
//  ContentView.swift
//  DownloadCombine
//
//  Created by Angelo Essam on 15/11/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject  var vm = DownloadWithCombineViewModel()
    var body: some View {
        List{
            ForEach(vm.posts){ post in
                VStack(alignment: .leading){
                    Text(post.title ?? "")
                        .font(.headline)
                    
                    Text(post.body ?? "")
                        .foregroundColor(.gray)
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
