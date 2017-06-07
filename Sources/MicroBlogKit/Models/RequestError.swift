import Foundation


struct ServiceError {
    /// Reason why Micro.blog returned an error.
    let description : String
}

extension ServiceError {

    init(json : JSONObject) {
        let dictionary = json as? JSONDictionary
        self.description = dictionary?["error"].flatMap(asString) ?? ""
    }

}
