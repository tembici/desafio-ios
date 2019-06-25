
import Moya

enum Connection {
    case testCase(params:[String:Any]?)
}

extension Connection: TargetType {
    
    var baseURL: URL { return URL(string: "http://api.atacadapp.com:8080/storefront")! }
    var path: String {
        switch self {
        case .testCase:
            return "/auth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .testCase:
            return .post
        }
    }
    var task: Task {
        
        switch self {
        case let .testCase(params):
            return .requestParameters(parameters: params ?? [:], encoding: JSONEncoding.default);
        }
    }
    
    var sampleData: Data {
        switch self {
        case .testCase:
            return "{\"userToken\":\"123123\"}".utf8Encoded;
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
