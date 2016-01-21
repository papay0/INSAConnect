//
//  NetworkManager.swift
//  INSA_Portail_Captif
//
//  Created by Arthur Papailhau on 21/01/16.
//  Copyright © 2016 Arthur Papailhau. All rights reserved.
//

import Foundation
import Alamofire

class Network {
    
    func requestServerForAConnection(url:String, pseudo: String, password: String) {
        Alamofire.request(.POST, url, parameters: ["auth_user":pseudo, "auth_pass":password, "accept":"Connection"]).responseJSON { response in
            print("Request: \(response.request)\n\n")
            print("Response: \(response.response)\n\n")
            let dataString = String(data: response.data!, encoding: NSUTF8StringEncoding)
            print("Response.data: \(response.data)\n\n")
            print("Response.result: \(response.result)\n\n")
            print("Response.dataString: \(dataString!)\n\n")
        }
        
    }
    
}