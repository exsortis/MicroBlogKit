import Foundation


public struct Authentication {

    /**
     Logs the user in using the password grant method.

        - parameter email: The email address of the user signing in.
        - parameter appName: The name of the app from which the user is signing in.
        - parameter redirectURL: The URL where the user will be directed in the sign-in response email.
      - returns: Request for `LoginResponse`.
     */
    public static func signin(email : String, appName: String, redirectURL: URL) -> Request<Empty> {
        let parameters = [
            Parameter(name: "email", value: email),
            Parameter(name: "app_name", value: appName),
            Parameter(name: "redirect_url", value: redirectURL.absoluteString),
        ]

        let method = HTTPMethod.post(Payload.parameters(parameters))
        return Request<Empty>(path: "/account/signin", method: method, parse: Request<Empty>.parser)
    }
    
}
