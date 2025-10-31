import Hummingbird

public struct RateLimitMiddleware<Context: RequestContext>: RouterMiddleware {
  public func handle(
    _ input: HummingbirdCore.Request,
    context: Context,
    next: (HummingbirdCore.Request, Context) async throws -> HummingbirdCore.Response
  ) async throws -> HummingbirdCore.Response {
    print(input.headers)
    print(input.uri)
    print(input.head)
    
    return try await next(input, context)
  }
}
