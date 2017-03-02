//
//  LayerController.swift
//  LayerSample
//

import LayerKit

class LayerController: NSObject, LYRClientDelegate {
    
    // https://github.com/layerhq/Atlas-Messenger-iOS/blob/v0.9.5/Code/Utilities/ATLMUtilities.m
    let identityBaseUrl:URL = URL(string:"https://layer-identity-provider.herokuapp.com")!
    
    var layerClient:LYRClient?
    
    var authenticationProvider:AuthenticationProvider?
    
    override init(){
        super.init()
        
        let ud = UserDefaults.standard
        let appID = URL(string: ud.string(forKey: "LAYER_APP_ID")!)!
        
        self.authenticationProvider = AuthenticationProvider(appID)
        self.layerClient = LYRClient(appID:appID, delegate:self, options:nil)
        self.layerClient!.connect { (success, error) in
            if(success){
                print("Successfully connected to Layer!")
                let authenticatedUser = self.layerClient?.authenticatedUser
                if authenticatedUser == nil {
                    self.authenticate()
                }else{
                    print("user: \(authenticatedUser!)")
                }
            }else{
                print("Failed connection to Layer with error: ")
            }
        }
    }
    
    func authenticate(){
        
        self.layerClient?.requestAuthenticationNonce(completion: { (nonce, error) in
            if error != nil {
                print("Found error: \(error!)")
                return
            }
            print("nonce: \(nonce!)")
            self.getIdentityToken(nonce!)
        })
    }
    

    func getIdentityToken(_ nonce: String){
        self.authenticationProvider?.authenticateWithCredentials(nonce, firstName: "Takashi", lastName: "Someda") { (token, error) in
            if error != nil {
                print("Found error: \(error!)")
                return
            }
            print("token: \(token!)")
            self.verifyToken(token!)
        }
    }
    
    func verifyToken(_ token:String) {
        self.layerClient?.authenticate(withIdentityToken: token, completion: { (authenticatedUser, error) in
            if error != nil {
                print("Found error: \(error!)")
                return
            }
            print(authenticatedUser)
        })
    }

    public func layerClient(_ client: LYRClient, didReceiveAuthenticationChallengeWithNonce nonce: String){
        self.getIdentityToken(nonce)
    }
}

// https://github.com/layerhq/Atlas-Messenger-iOS/blob/v0.9.5/Code/ATLMAuthenticationProvider.m
class AuthenticationProvider {
    // https://github.com/layerhq/Atlas-Messenger-iOS/blob/v0.9.5/Code/Utilities/ATLMUtilities.m
    let identityBaseUrl:URL = URL(string:"https://layer-identity-provider.herokuapp.com")!
    
    var urlSession:URLSession
    
    var appID:URL

    init(_ appID:URL){
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpAdditionalHeaders = [
            "Accept": "application/json",
            "X_LAYER_APP_ID": appID.absoluteString
        ]
        self.urlSession =  URLSession(configuration: configuration)
        self.appID = appID
    }
    
    public func authenticateWithCredentials(_ nonce:String, firstName: String, lastName: String, completion: @escaping (String?, NSError?) -> Void) {
        let displayName = String(format:"%@ %@", firstName, lastName)
        let appUUID = self.appID.lastPathComponent
        let urlString = String(format:"apps/%@/atlas_identities", appUUID)
        
        let url = URL(string: urlString, relativeTo:identityBaseUrl)
        let parameters:[AnyHashable: Any] = [
            "nonce": nonce,
            "user": [
                "first_name": firstName,
                "last_name": lastName,
                "display_name": displayName
            ]
        ]
        
        do{
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions(rawValue: 0))
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            print(urlRequest)
            
            self.urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if response == nil && error != nil {
                    completion(nil, error as! NSError)
                    return
                }
                
                do{
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions(rawValue:0))
                    guard let dictionary = jsonObject as? Dictionary<String, Any> else {
                        return
                    }
                    completion(dictionary["identity_token"] as! String, nil)
                }catch let deserializeError as NSError{
                    completion(nil, deserializeError)
                }
            }).resume()
            
        }catch let error as NSError {
            completion(nil, error)
        }
    }
    
}



