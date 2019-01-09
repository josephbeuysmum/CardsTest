//
//  ApiService.swift
//  CardsTest
//
//  Created by Richard Willis on 09/01/2019.
//  Copyright © 2019 Rich Text Format Ltd. All rights reserved.
//

import Foundation

enum CallTypes: String {
	case GET, POST
}

class ApiService {
	private var delegates: [String: ApiResponseDelegate]
	
	init() {
		delegates = [:]
	}
	
	// would normally test for internet connection at some point, skipping for this test
	
	func call(_ url: String, httpMethod: CallTypes, delegate: ApiResponseDelegate) -> Bool {
		guard
			delegates[url] == nil,
			let validUrl = URL(string: url)
			else { return false }
		delegates[url] = delegate
		var request = URLRequest(url: validUrl)
		request.httpMethod = httpMethod.rawValue
		_ = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
			guard error == nil else {
				print("ERROR NEEDS HANDLING")
				return
			}
			guard
				let strongSelf = self,
				let strongData = data,
				let strongDelegate = strongSelf.delegates[url]
				else {
					print("EITHER MISSING SELF, DATA, OR DELEGATE NEEDS HANDLING")
					return
			}
			strongSelf.delegates.removeValue(forKey: url)
			do {
				let json = try JSONSerialization.jsonObject(with: strongData, options: []) as? Jsonary
				strongDelegate.present(ApiResponse(url: url, result: json))
			} catch {
				print("FAILED JSON SERIALISATION NEEDS HANDLING")
			}
		}.resume()
		return true
	}
}
