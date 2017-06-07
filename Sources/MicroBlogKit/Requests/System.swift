import Foundation


public struct System {
    
    public static func config() -> Request<Configuration> {
        let parameters = [
            Parameter(name: "q", value: "config")
        ]
        let method = HTTPMethod.get(Payload.parameters(parameters))
        
        return Request<Configuration>(path: "/micropub", method: method, parse: Request<Configuration>.parser)
    }
    
}
