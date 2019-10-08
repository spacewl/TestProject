import Alamofire

struct ParametersQueryConfigurator {
    static func configureRequrst(baseUrlStr: String, path: String, parameters: Encodable? = nil) -> URLRequest {
        var url: URL!
        let urlComponents = NSURLComponents(string: baseUrlStr)!
        
        if let parameters = parameters?.asAnyDictionary() {
            var queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: String(describing: value)))
            }
            
            urlComponents.queryItems = queryItems
        }
        
        url = urlComponents.url
        
        return URLRequest(url: url.appendingPathComponent(path))
    }
}

struct ParametersBodyConfigurator {
    static func configureRequest(baseUrlStr: String, path: String, parameters: Encodable? = nil) throws -> URLRequest {
        
        let url = try baseUrlStr.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        guard let params = parameters else { return urlRequest }
        
        do {
            let encoder = URLEncoding(destination: .httpBody, arrayEncoding: .brackets, boolEncoding: .literal)
            
            if let params = params as? [Encodable] {
                let dic = params.compactMap({$0.asAnyDictionary()})
                let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
            } else {
                urlRequest = try encoder.encode(urlRequest, with: params.asAnyDictionary())
            }
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
}

private extension Encodable {
    private func asDictionary<T>() -> [String: T]? {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: T] else { return nil }
            
            let encoder = JSONEncoder()
            if let json = try? encoder.encode(self) {
                print(String(data: json, encoding: .utf8)!)
            }

            return dictionary
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func asAnyDictionary() -> [String: Any]? {
        return asDictionary()
    }

    func asStringDictionary() -> [String: String]? {
        return asDictionary()
    }
}
