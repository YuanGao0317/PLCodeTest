//
//  PLErrors.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

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

enum BookError: Error {
	case noData, creationFailed
}


enum ValidationError: Error {
	case isEmpty
}
