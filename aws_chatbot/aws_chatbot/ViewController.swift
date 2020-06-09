//
//  ViewController.swift
//  aws_chatbot
//
//  Created by 黃威愷 on 2020/5/30.
//  Copyright © 2020 iOSClub. All rights reserved.
//

import UIKit
import AWSLex

class ViewController: UIViewController,AWSLexInteractionDelegate, UITextFieldDelegate {
    @IBOutlet weak var input:UITextField!
    @IBOutlet weak var display:UILabel!
    let scale:CGFloat = 0.31
    var interactionKit: AWSLexInteractionKit?
    
    func interactionKit(_ interactionKit: AWSLexInteractionKit, onError error: Error) {
        print("interactionKit error: \(error)")
    }
    func setUpLex(){
        self.interactionKit = AWSLexInteractionKit.init(forKey: "chatConfig")
        self.interactionKit?.interactionDelegate = self
    }
    func setUpTextField(){
        input.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        input.resignFirstResponder()
        if  (input.text?.count)! > 0 {
            sendToLex(text: input.text!)
        }
        return true
    }
    func sendToLex(text : String){
        self.interactionKit?.text(inTextOut: text, sessionAttributes: nil)
    }
    func interactionKit(_ interactionKit: AWSLexInteractionKit, switchModeInput: AWSLexSwitchModeInput, completionSource: AWSTaskCompletionSource<AWSLexSwitchModeResponse>?) {
        guard let response = switchModeInput.outputText else {
            let response = "No reply from bot"
            print("Response: \(response)")
            return
        }
        
//        do{
//            try? print(switchModeInput.slots![AnyHashable("seasoning")])
//        } catch {
//            print("Unvalid Value")
//        }
       
        
    //show response on screen
        DispatchQueue.main.async{
            //self.display.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
            self.display.alpha = 0.0
            self.display.text = response
            UIView.animate(withDuration: 0.2, animations: {
                //self.display.center.y = self.view.frame.maxY*self.scale
                self.display.alpha = 1.0
                })
            //UIView.animate(withDuration: <#T##TimeInterval#>, animations: <#T##() -> Void#>)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(display.center)
        //scale = display.center.y / view.frame.maxY
        setUpTextField()
        setUpLex()
        // Do any additional setup after loading the view.
    }


}

