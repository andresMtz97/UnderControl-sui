//
//  Webservice.swift
//  UnderControl
//
//  Created by Desarrollo on 19/07/24.
//

import Foundation

struct LoginRequestBody: Codable {
    let username: String
    let password: String
}

class UnderControlServiceManager {
    
    func login(username: String, password: String, completion: @escaping (Result<UserDto, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: Constants.baseUrl + "usuarios/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
                
        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            print(error)
//            print("UnderControlServiceManager.swift line 38: \(error?.localizedDescription)")
//            print(error == nil)
            
            if error != nil {
                completion(.failure(.custom(errorMessage: "An error has ocurred.\n Please try again later.")))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data.")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(UserDto.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(loginResponse))
        }.resume()
    }
    
    func getAccounts(completion: @escaping (Result<[AccountDto], ResponseError>) -> Void) {
        guard let url = URL(string: Constants.baseUrl + "cuentas/") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No jwt")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            print(error)
//            print("UCSM: \(response)")
//            print("UnderControlServiceManager.swift line 38: \(error?.localizedDescription)")
//            print(error == nil)
            
            if error != nil {
                completion(.failure(.custom(errorMessage: "An error has ocurred.\n Please try again later.")))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data.")))
                return
            }
            
            guard let accounts = try? JSONDecoder().decode([AccountDto].self, from: data) else {
                completion(.failure(.custom(errorMessage: "An error has ocurred.")))
                return
            }

            completion(.success(accounts))

        }.resume()
    }
    
    func getIncomeCategories(completion: @escaping (Result<[CategoryDto], ResponseError>) -> Void) {
        guard let url = URL(string: Constants.baseUrl + "categorias/ingreso") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No jwt")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.custom(errorMessage: "An error has ocurred.\n Please try again later.")))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data.")))
                return
            }
            
            guard let categories = try? JSONDecoder().decode([CategoryDto].self, from: data) else {
                completion(.failure(.custom(errorMessage: "An error has ocurred.")))
                return
            }

            completion(.success(categories))

        }.resume()
    }
    
    func getMovements(completion: @escaping (Result<[MovementDto], ResponseError>) -> Void) {
        guard let url = URL(string: Constants.baseUrl + "movimientos/") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No jwt")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.custom(errorMessage: "An error has ocurred.\n Please try again later.")))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data.")))
                return
            }
            
            guard let movements = try? JSONDecoder().decode([MovementDto].self, from: data) else {
                completion(.failure(.custom(errorMessage: "An error has ocurred.")))
                return
            }
            
            completion(.success(movements))

        }.resume()
    }
}
