import Foundation


public struct Feeds {

    /**
     Create a new post.

     - parameter text: The body of the post. 256 character-limited string.
     - parameter isNSFW: Optional boolean whether the post should be marked as "NSFW" (Not Safe For Work/mature/offensive).
     - parameter replyTo: Optional ID of another post to reply to.
     - parameter raw: An array of `Raw` objects that will be attached to the post.
     - parameter parseLinks: Optional boolean whether the links should be parsed by the server.
     - parameter parseMarkdownLinks: Optional boolean whether the markdown links should be parsed by the server. Default true.
     - parameter updateMarker: Indicates whether the stream marker should be updated to this post.
     */
    public static func create(text : String) -> Request<Feed> {
        let parameters = [
            Parameter(name: "h", value: "entry"),
            Parameter(name: "content", value: text),
            ]
        let method = HTTPMethod.post(Payload.parameters(parameters))

        return Request<Feed>(path: "/micropub", method: method, parse: Request<Feed>.parser)
    }

    public static func all() -> Request<Feed> {
        let method = HTTPMethod.get(Payload.empty)

        return Request<Feed>(path: "/posts/all", method: method, parse: Request<Feed>.parser)
    }

    /**
     Retrieves mentions for the logged in user.

     - parameter range: The bounds used when requesting data from Micro.blog.
     - returns: Request for `Feed`.
     */
    public static func mentions(range: RequestRange = .default) -> Request<Feed> {
        let rangeParameters = range.parameters(limit: between(1, and: 40, fallback: 20))
        let method = HTTPMethod.get(Payload.parameters(rangeParameters))

        return Request<Feed>(path: "/posts/mentions", method: method, parse: Request<Feed>.parser)
    }

    public static func favorites(postId : String) -> Request<Feed> {
        let method = HTTPMethod.put(Payload.empty)

        return Request<Feed>(path: "/posts/favorites", method: method, parse: Request<Feed>.parser)
    }

    /**
     Retrieves posts by a specified user.

     - parameter range: The bounds used when requesting data from Micro.blog.
     - returns: Request for `Feed`.
     */
    public static func posts(username : String, range: RequestRange = .default) -> Request<Feed> {
        let rangeParameters = range.parameters(limit: between(1, and: 40, fallback: 20))
        let method = HTTPMethod.get(Payload.parameters(rangeParameters))

        return Request<Feed>(path: "/posts/\(username)", method: method, parse: Request<Feed>.parser)
    }

    // conversation
    public static func conversation(id : Int) -> Request<Feed> {
        let parameters = [
            Parameter(name: "id", value: String(id))
        ]
        let method = HTTPMethod.get(Payload.parameters(parameters))

        return Request<Feed>(path: "/posts/conversation", method: method, parse: Request<Feed>.parser)
    }

    // check
    public static func check(sinceId : Int) -> Request<Feed> {
        let parameters = [
            Parameter(name: "since_id", value: String(sinceId))
        ]
        let method = HTTPMethod.get(Payload.parameters(parameters))

        return Request<Feed>(path: "/posts/check", method: method, parse: Request<Feed>.parser)
    }

    // favorite
    public static func favorite(postId : Int) -> Request<Feed> {
        let parameters = [
            Parameter(name: "id", value: String(postId)),
        ]
        let method = HTTPMethod.post(Payload.parameters(parameters))

        return Request<Feed>(path: "/posts/favorites/\(postId)", method: method, parse: Request<Feed>.parser)
    }

    // unfavorite
    public static func unfavorite(postId : Int) -> Request<Feed> {
        let method = HTTPMethod.delete

        return Request<Feed>(path: "/posts/favorites/\(postId)", method: method, parse: Request<Feed>.parser)
    }

    // reply
    public static func reply(to postId : Int, with text : String) -> Request<Feed> {
        let parameters = [
            Parameter(name: "id", value: String(postId)),
            Parameter(name: "text", value: text),
            ]
        let method = HTTPMethod.post(Payload.parameters(parameters))

        return Request<Feed>(path: "/posts/reply", method: method, parse: Request<Feed>.parser)
    }

    // delete
    public static func delete(postId : String) -> Request<Feed> {
        let method = HTTPMethod.delete

        return Request<Feed>(path: "/posts/\(postId)", method: method, parse: Request<Feed>.parser)
    }

}
