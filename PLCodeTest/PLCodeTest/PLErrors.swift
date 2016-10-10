//
//  PLErrors.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

// MARK: - Result
enum PLResult<T> {
	case success(T)
	case failure(Error)
}

extension PLResult {
	func resolve() throws -> T {
		switch self {
		case PLResult.success(let value): return value
		case PLResult.failure(let error): throw error
		}
	}
}

// MARK: - Book Error
enum PLBookError: Error {
	case noData, creationFailed
}

// MARK: - Validation Error
enum PLValidationError: Error {
	case isEmpty
}
