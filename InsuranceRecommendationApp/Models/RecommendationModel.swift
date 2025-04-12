import Foundation

struct RecommendationRequest: Codable {
    var age: Int
    var gender: String
    var occupation: String
    var income: Double
    var maritalStatus: String
    var hasChildren: Bool
    var hasVehicle: Bool
    var hasHome: Bool
    var hasMedicalConditions: Bool
    var travelFrequency: String
    
    enum CodingKeys: String, CodingKey {
        case age
        case gender
        case occupation
        case income
        case maritalStatus = "marital_status"
        case hasChildren = "has_children"
        case hasVehicle = "has_vehicle"
        case hasHome = "has_home"
        case hasMedicalConditions = "has_medical_conditions"
        case travelFrequency = "travel_frequency"
    }
}

struct RecommendationResponse: Codable {
    let recommendations: [Insurance]
}
