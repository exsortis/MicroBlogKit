import Foundation


public struct Users {

    public static func follow(username : String) -> Request<Empty> {
        let parameters = [
            Parameter(name: "username", value: username),
            ]
        let method = HTTPMethod.post(Payload.parameters(parameters))

        return Request<Empty>(path: "/users/follow", method: method, parse: Request<Empty>.parser)
    }
    
    public static func unfollow(username : String) -> Request<Empty> {
        let parameters = [
            Parameter(name: "username", value: username),
        ]
        let method = HTTPMethod.post(Payload.parameters(parameters))

        return Request<Empty>(path: "/users/unfollow", method: method, parse: Request<Empty>.parser)
    }
    
}
