# URLSession and the Combine framework
## How  to make HTTP requests and parse the response using the brand new Combine framework with foundation networking.
>I love how the code "explains itself":

First we make a cancellable storage for your Publisher
 > var cancallables = Set<AnyCancellable>()
Then we create a brand new data task publisher object
Map the response, we only care about the data part (ignore errors)
Decode the content of the data using a JSONDecoder
If anything goes wrong, just go with an empty array
Erase the underlying complexity to a simple AnyPublisher
Use sink to display some info about the final value
Optional: you can cancel your network request any time

URLSession.shared.dataTaskPublisher(for: url) <br/>
            .subscribe(on:DispatchQueue.global(qos: .background))<br/>
            .receive(on:DispatchQueue.main)<br/>
            .tryMap(handlerOutput) // check data is true <br/>
            .decode(type: PostModel.self, decoder: JSONDecoder()) // decode data into model <br/>
            .replaceError(with: []) <br/>
            .sink { (completion) in <br/>
                switch completion{ <br/>
                case .finished: <br/>
                    print("finished") <br/>
                case .failure(let error):<br/>
                    print("Error : \(error)") <br/>
                } <br/>
            } receiveValue: { [weak  self] (model) in<br/>
                self?.posts = model<br/>
            }// cancel subscribtion if needed<br/>
            .store(in: &cancallables)<br/>
