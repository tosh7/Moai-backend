@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    func testHelloWorld() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        let res = try await app.test(.GET, "hello")
        XCTAssertEqual(res.status, .ok)
        XCTAssertEqual(res.body.string, "Hello, world!")
    }

    func testNoPath() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        let res = try await app.test(.GET, "")
        XCTAssertEqual(res.status, .ok)
        XCTAssertEqual(res.body.string, "It works!")
    }

    func testMe() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        let res = try await app.test(.GET, "me")
        XCTAssertEqual(res.status, .ok)
        XCTAssertEqual(Int(res.body.string), 1000)
    }
}
