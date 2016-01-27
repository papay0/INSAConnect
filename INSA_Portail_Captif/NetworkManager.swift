//
//  NetworkManager.swift
//  INSA_Portail_Captif
//
//  Created by Arthur Papailhau on 21/01/16.
//  Copyright © 2016 Arthur Papailhau. All rights reserved.
//

import Foundation
import Alamofire

class Network: NSObject {
    
    var thread : NSThread!
    
    override init(){
        print("init NetworkManager")
        super.init()
    }
    
    func initThread(){
        thread = NSThread(target: self, selector: "infiniteConnection", object: nil)
    }
    
    func requestServerForAConnection(url:String, pseudo: String, password: String) {
        print("I request a connection to url \(url)")
        Alamofire.request(.POST, url, parameters: ["auth_user":pseudo, "auth_pass":password, "accept":"Connection"]).responseJSON { response in
            print("Request: \(response.request)\n\n")
            print("Response: \(response.response)\n\n")
            let dataString = String(data: response.data!, encoding: NSUTF8StringEncoding)
            print("Response.data: \(response.data)\n\n")
            print("Response.result: \(response.result)\n\n")
            print("Response.dataString: \(dataString!)\n\n")
        }
    }
    
    
    func infiniteConnectionManager(enable:Bool){
        if enable {
            initThread()
            print("I start the thread")
            thread.start()
        } else {
            print("I stop the thread")
            thread.cancel()
        }
    }
    
    func infiniteConnection(){
        let pseudo = NSUserDefaults.standardUserDefaults().stringForKey(Information.pseudo)!
        let password = NSUserDefaults.standardUserDefaults().stringForKey(Information.password)!
        let urlPromolo = "https://portail-promologis-lan.insa-toulouse.fr:8003"
        let urlInviteINSA = "https://portail-invites-lan.insa-toulouse.fr:8003"
        print("infiniteConnection enable")
        while !thread.cancelled {
            requestServerForAConnection(urlPromolo, pseudo: pseudo, password: password)
            requestServerForAConnection(urlInviteINSA, pseudo: pseudo, password: password)
            sleep(20)
        }
        print("infinite connection disabled")
    }
    
}