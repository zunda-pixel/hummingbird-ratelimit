import HTTPTypes
import Hummingbird
import Logging

public struct RateLimitMiddleware<Context: RequestContext>: RouterMiddleware {
  public init() {}

  public func handle(
    _ input: HummingbirdCore.Request,
    context: Context,
    next: (HummingbirdCore.Request, Context) async throws -> HummingbirdCore.Response
  ) async throws -> HummingbirdCore.Response {
    let logger = Logger(label: "RateLimitMiddleware")
    logger.info(
      "Request",
      metadata: [
        "headerFields": .dictionary(input.headers.reduce(into: Logger.Metadata(), { partialResult, field in
          partialResult[field.name.rawName] = .string(field.value)
        })),
        "uri": .string(input.uri.string),
        "head": .dictionary([
          "method": .string(input.head.method.rawValue),
          "path": .string(input.head.path ?? "no path"),
          "headerFields": .dictionary(input.head.headerFields.reduce(into: Logger.Metadata(), { partialResult, field in
            partialResult[field.name.rawName] = .string(field.value)
          }))
        ])
      ]
    )

    return try await next(input, context)
  }
}

extension HTTPField.Name {
  static let xForwardedFor = Self("X-Forwarded-For")!
  static let cfConnectionIP = Self("CF-Connecting-IP")!
}
