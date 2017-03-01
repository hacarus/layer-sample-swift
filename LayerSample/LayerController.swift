//
//  LayerController.swift
//  LayerSample
//

import LayerKit

class LayerController: NSObject, LYRClientDelegate {
    
    // https://github.com/layerhq/Atlas-Messenger-iOS/blob/v0.9.5/Code/Utilities/ATLMUtilities.m
    let identityBaseUrl:URL = URL(string:"https://layer-identity-provider.herokuapp.com")!
    
    var layerClient:LYRClient?
    
    var appID:URL?
    
    init(_ appID: URL){
        super.init()
        
        self.appID = appID
        let layerClient = LYRClient(appID:appID, delegate:self, options:nil)
        layerClient.connect { (success, error) in
            if(success){
                print("Successfully connected to Layer!")
                self.authenticate()
            }else{
                print("Failed connection to Layer with error: ")
            }
        }
        self.layerClient = layerClient
    }
    
    func authenticate(){
        
        self.layerClient?.requestAuthenticationNonce(completion: { (nonce, error) in
            if error != nil {
                print(error!)
                return
            }
            print("nonce: \(nonce!)")
            self.getIdentityToken(nonce!)
        })
    }
    
    // https://github.com/layerhq/Atlas-Messenger-iOS/blob/v0.9.5/Code/ATLMAuthenticationProvider.m

    func getIdentityToken(_ nonce: String){
        let firstName = "Takashi"
        let lastName = "Someda"
        let displayName = String(format:"%@ %@", firstName, lastName)
        let appUUID = self.appID!.lastPathComponent
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
            
            let configuration = URLSessionConfiguration.ephemeral
            configuration.httpAdditionalHeaders = [
                "Accept": "application/json",
                "X_LAYER_APP_ID": self.appID!.absoluteString
            ]
            let session = URLSession(configuration: configuration)
            
            print(urlRequest)
            
            session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if response == nil && error != nil {
                    print("Failed with error: \(error)")
                    return
                }
                print(data)
            }).resume()
            
        }catch let error as NSError {
            print("Found an error - \(error)")
        }
        
    }
    
    
    public func layerClient(_ client: LYRClient, didReceiveAuthenticationChallengeWithNonce nonce: String){
        self.getIdentityToken(nonce)
    }
}

