import Testing
@testable import RateLimit
import HummingbirdTesting
import Hummingbird

@Suite
struct RateLimitTests {
  @Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    let router = Router()
    router.add(middleware: RateLimitMiddleware())

    router.get("/hello") { _, _ in
        return "hello"
    }
    let app = Application(router: router)
    
    for _ in 0..<1 {
      try await app.test(.live) { client in
        // does my app return "hello" in the body for this route
        let _ = try await client.execute(uri: "/hello", method: .get)//, headers: [:], body: nil)
      }
    }
  }
}
