import ArgumentParser
import Hummingbird
import Logging
import RateLimit

@main
struct AppCommand: AsyncParsableCommand {
  @Option(name: .shortAndLong)
  var hostname: String = "127.0.0.1"

  @Option(name: .shortAndLong)
  var port: Int = 8080

  func run() async throws {
    let router = Router()
    router.add(middleware: RateLimitMiddleware())
    router.get("hello") { request, _ -> String in
      return "Hello123"
    }
    // create application using router
    let app = Application(
      router: router,
      configuration: .init(address: .hostname(hostname, port: port))
    )
    // run hummingbird application
    try await app.runService()
  }
}
