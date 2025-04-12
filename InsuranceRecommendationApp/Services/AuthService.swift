import Foundation

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    func login(email: String, password: String) async throws -> User {
        if email.isEmpty || password.isEmpty {
            throw APIError.emptyFields
        }
        
        let loginRequest = LoginRequest(email: email, password: password)
        let jsonData = try JSONEncoder().encode(loginRequest)
        
        let response: AuthResponse = try await APIService.shared.request(
            endpoint: "auth/login",
            method: "POST",
            body: jsonData,
            requiresAuth: false
        )
        
        UserDefaults.standard.set(response.accessToken, forKey: "authToken")
        return response.user
    }
    
    func register(name: String, email: String, password: String) async throws -> String {
        if name.isEmpty || email.isEmpty || password.isEmpty {
            throw APIError.emptyFields
        }
        
        if !Validators.isValidEmail(email) {
            throw APIError.invalidEmail
        }
        
        let registerRequest = RegisterRequest(name: name, email: email, password: password)
        let jsonData = try JSONEncoder().encode(registerRequest)
        
        let response: RegisterResponse = try await APIService.shared.request(
            endpoint: "auth/register",
            method: "POST",
            body: jsonData,
            requiresAuth: false
        )
        
        return response.message
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
    
    func updateUserProfile(user: User) async throws -> User {
        let jsonData = try JSONEncoder().encode(user)
        
        let updatedUser: User = try await APIService.shared.request(
            endpoint: "users/update_info",
            method: "PUT",
            body: jsonData
        )
        
        return updatedUser
    }
    
    func getRecommendations(request: InsuranceRecommendationRequest) async throws -> [Insurance] {
        let jsonData = try JSONEncoder().encode(request)
        
        let response: RecommendationResponse = try await APIService.shared.request(
            endpoint: "recommendations",
            method: "POST",
            body: jsonData
        )
        
        return response.recommendations
    }
}
