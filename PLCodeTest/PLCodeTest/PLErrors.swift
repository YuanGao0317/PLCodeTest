//
//  PLErrors.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

enum Result<T> {
	case Success(T)
	case Failure(ErrorType)
}

extension Result {
	func resolve() throws -> T {
		switch self {
		case Result.Success(let value): return value
		case Result.Failure(let error): throw error
		}
	}
}

enum BookError: ErrorType {
	case NoData
}