import HTTPTypes
import Hummingbird

public struct RateLimitMiddleware<Context: RequestContext>: RouterMiddleware {
  public init() {}

  public func handle(
    _ input: HummingbirdCore.Request,
    context: Context,
    next: (HummingbirdCore.Request, Context) async throws -> HummingbirdCore.Response
  ) async throws -> HummingbirdCore.Response {
    print(input.headers)
    print(input.uri)
    print(input.head)

    print(input.headers[.xForwardedFor])
    print(input.headers[.cfConnectionIP])

    return try await next(input, context)
  }
}

extension HTTPField.Name {
  static let xForwardedFor = Self("X-Forwarded-For")!
  static let cfConnectionIP = Self("CF-Connecting-IP")!
}
