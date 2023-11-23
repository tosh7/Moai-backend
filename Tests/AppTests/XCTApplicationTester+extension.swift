//
//  File.swift
//  
//
//  Created by Satoshi Komatsu on 2023/11/23.
//

import XCTVapor

extension XCTApplicationTester {
    func test(
        _ method: HTTPMethod,
        _ path: String,
        headers: HTTPHeaders = [:],
        body: ByteBuffer? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCTHTTPResponse {
        return try await withCheckedThrowingContinuation { continuation in
            do {
                try test(method, path, headers: headers, body: body, file: file, afterResponse: { res in
                    continuation.resume(returning: res)
                })
            } catch let error {
                continuation.resume(throwing: error)
            }
        }
    }
}
