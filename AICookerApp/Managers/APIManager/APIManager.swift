//
//  APIManager.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 06.09.2025.
//

import Foundation

import Foundation

final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    private let baseURL = URL(string: "https://kovbwbpmfrwhoawabbkw.supabase.co/functions/v1/generateReceipts")!
    
    func generateReceipt(category: String,
                         locale: String,
                         userId: String,
                         completion: @escaping (Result<AIReceiptResponse, Error>) -> Void) {
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "category": category,
            "locale": locale,
            "user_id": userId
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "AIReceiptsManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let receipt = try JSONDecoder().decode(AIReceiptResponse.self, from: data)
                completion(.success(receipt))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
