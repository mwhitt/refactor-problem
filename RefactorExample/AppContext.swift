protocol ShareableContext {
    var apiManager: APICallable { get }
}

class AppContext: ShareableContext {
    var apiManager: APICallable = APIManager()
}
