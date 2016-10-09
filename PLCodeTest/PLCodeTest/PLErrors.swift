//
//  PLErrors.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

// MARK: - Result
enum Result<T> {
	case success(T)
	case failure(Error)
}

extension Result {
	func resolve() throws -> T {
		switch self {
		case Result.success(let value): return value
		case Result.failure(let error): throw error
		}
	}
}

// MARK: - Book Error
enum BookError: Error {
	case noData, creationFailed
}

// MARK: - Validation Error
enum ValidationError: Error {
	case isEmpty
}
