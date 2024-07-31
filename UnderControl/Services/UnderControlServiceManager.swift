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
            completion(.failure(.custom(errorMessage: "No session.")))
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
            DataProvider.accounts = accounts
            completion(.success(accounts))

        }.resume()
    }
    
    func getIncomeCategories(completion: @escaping (Result<[CategoryDto], ResponseError>) -> Void) {
        guard let url = URL(string: Constants.baseUrl + "categorias/ingreso") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No session.")))
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
            DataProvider.incomeCategories = categories
            completion(.success(categories))

        }.resume()
    }
    
    func getExpenseCategories(completion: @escaping (Result<[CategoryDto], ResponseError>) -> Void) {
        guard let url = URL(string: Constants.baseUrl + "categorias/egreso") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No session.")))
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
            DataProvider.expenseCategories = categories
            completion(.success(categories))

        }.resume()
    }
    
    func getMovements(completion: @escaping (Result<[MovementDto], ResponseError>) -> Void) {
        guard let url = URL(string: Constants.baseUrl + "movimientos/") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No session.")))
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
            DataProvider.movements =  movements
            completion(.success(movements))

        }.resume()
    }
    
    func addAccount(account: AccountDto, completion: @escaping (Result<ResponseDto<AccountDto>, ResponseError>) -> Void) {
        guard let url = URL(string: Constants.baseUrl + "cuentas/") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No session.")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(account)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.custom(errorMessage: "An error has ocurred.\n Please try again later.")))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data.")))
                return
            }
            
            guard let responseDto = try? JSONDecoder().decode(ResponseDto<AccountDto>.self, from: data) else {
                completion(.failure(.custom(errorMessage: "An error has ocurred.")))
                return
            }
            
            completion(.success(responseDto))

        }.resume()
    }
    
    func updateAccount(account: AccountDto, completion: @escaping (Result<ResponseDto<AccountDto>, ResponseError>) -> Void) {
        guard let url = URL(string: Constants.baseUrl + "cuentas/\(account.id ?? 0)") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No session.")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(account)
                
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.custom(errorMessage: "An error has ocurred.\n Please try again later.")))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data.")))
                return
            }
            
            guard let responseDto = try? JSONDecoder().decode(ResponseDto<AccountDto>.self, from: data) else {
                completion(.failure(.custom(errorMessage: "An error has ocurred.")))
                return
            }
            
            completion(.success(responseDto))
        }.resume()
    }
    
    func deleteAccount(id: Int, completion: @escaping (Result<ResponseDto<AccountDto>, ResponseError>) -> Void) {
        guard let url = URL(string: Constants.baseUrl + "cuentas/\(id)") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No session.")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
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
            
            guard let responseDto = try? JSONDecoder().decode(ResponseDto<AccountDto>.self, from: data) else {
                completion(.failure(.custom(errorMessage: "An error has ocurred.")))
                return
            }
                        
            completion(.success(responseDto))
        }.resume()
    }
    
    func addCategory(category: CategoryDto, completion: @escaping (Result<ResponseDto<CategoryDto>, ResponseError>) -> Void) {
        let type = (category.type) ? "ingreso" : "egreso"
        guard let url = URL(string: Constants.baseUrl + "categorias/\(type)") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No session.")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(category)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.custom(errorMessage: "An error has ocurred.\n Please try again later.")))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data.")))
                return
            }
            
            guard let responseDto = try? JSONDecoder().decode(ResponseDto<CategoryDto>.self, from: data) else {
                completion(.failure(.custom(errorMessage: "An error has ocurred.")))
                return
            }
            
            completion(.success(responseDto))

        }.resume()
    }
    
    func updateCategory(category: CategoryDto, completion: @escaping (Result<ResponseDto<CategoryDto>, ResponseError>) -> Void) {
        guard let url = URL(string: Constants.baseUrl + "categorias/\(category.id ?? 0)") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No session.")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(category)
                
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.custom(errorMessage: "An error has ocurred.\n Please try again later.")))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data.")))
                return
            }
            
            guard let responseDto = try? JSONDecoder().decode(ResponseDto<CategoryDto>.self, from: data) else {
                completion(.failure(.custom(errorMessage: "An error has ocurred.")))
                return
            }
            
            completion(.success(responseDto))
        }.resume()
    }
    
    func deleteCategory(id: Int, completion: @escaping (Result<ResponseDto<CategoryDto>, ResponseError>) -> Void) {
        guard let url = URL(string: Constants.baseUrl + "categorias/\(id)") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No session.")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
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
            
            guard let responseDto = try? JSONDecoder().decode(ResponseDto<CategoryDto>.self, from: data) else {
                completion(.failure(.custom(errorMessage: "An error has ocurred.")))
                return
            }
            
            print(responseDto)
            
            completion(.success(responseDto))
        }.resume()
    }
    
    func addMovement(movement: MovementDto, completion: @escaping (Result<ResponseDto<MovementDto>, ResponseError>) -> Void) {
        var route = "movimientos/"
        if let transaction = movement.transaction {
            route += "transaccion/" + ((transaction.type) ? "ingreso" : "egreso")
        } else {
            route += "transferencia"
        }
        
        guard let url = URL(string: Constants.baseUrl + route) else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        print(url)
        print(movement)
        
        guard let token = DataProvider.user?.token else {
            completion(.failure(.custom(errorMessage: "No session.")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(movement)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.custom(errorMessage: "An error has ocurred.\n Please try again later.")))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data.")))
                return
            }
            
//            guard let responseDto = try? JSONDecoder().decode(ResponseDto<MovementDto>.self, from: data) else {
//                completion(.failure(.custom(errorMessage: "An error has ocurred.")))
//                return
//            }
            
            do {
                let responseDto = try JSONDecoder().decode(ResponseDto<MovementDto>.self, from: data)
                completion(.success(responseDto))
            } catch let e {
                print(e)
            }
            
            //completion(.success(responseDto))

        }.resume()
    }
}
