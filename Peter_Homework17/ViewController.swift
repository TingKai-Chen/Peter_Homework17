//
//  ViewController.swift
//  Peter_Homework17
//
//  Created by 陳庭楷 on 2018/12/6.
//  Copyright © 2018年 陳庭楷. All rights reserved.
//

import UIKit

import GameplayKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pictureimageView: UIImageView!
    
    @IBOutlet weak var disPlayLabel: UILabel!
    
    @IBOutlet weak var resultButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    var answerArray = [ "你是擁有純真和善良和氣，超群智慧讓你永不退卻！" , "您是位溫和又堅忍的人物，常付出自己只讓別人快樂！" , "您是可愛迷人的偶像，走到哪裡都被粉絲包圍不孤單。" ]
    
    override func viewDidLoad() {
        
        reNew()
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func picturePressed(_ sender: Any) {
        
        self.resultButton.isEnabled = true
        
        let alert = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
    
        let action_Cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
            self.resultButton.isEnabled = false
        
        } )
        
        self.present(alert, animated: true, completion: nil)
        
        let action_Camera = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            
            let controller = UIImagePickerController()
            
            controller.delegate = self
            
            controller.sourceType = .camera
            
            self.present(controller, animated: true, completion: nil)
            
        } )
        
        let action_PhotoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            
            let controller = UIImagePickerController()
            
            controller.delegate = self
            
            controller.sourceType = .photoLibrary
            
            self.present(controller, animated: true, completion: nil)
            
        } )
        
        alert.addAction(action_Cancel)
        
        alert.addAction(action_Camera)
        
        alert.addAction(action_PhotoLibrary)

    }
    
    @IBAction func uploadPressed(_ sender: Any) {
        
        guard pictureimageView.image != UIImage(named: "空白") else {
            
            let alert = UIAlertController(title: "請先選擇照片", message: nil, preferredStyle: .alert)
            
            let action_OK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(action_OK)
            
            self.present(alert, animated: true, completion: nil)
            
            return}
        
        let activityController = UIActivityViewController(activityItems: [ pictureimageView.image , disPlayLabel.text ] ,  applicationActivities: nil)
        
        activityController.popoverPresentationController?.sourceView = self.view
        
        activityController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop , UIActivity.ActivityType.postToFacebook ]
        
        self.present(activityController, animated: true, completion: nil)
        
    }
    
    @IBAction func result(_ sender: UIButton) {
        
        self.resultButton.isEnabled = false
        
        let randomDistribution = GKRandomDistribution(lowestValue: 0, highestValue: self.answerArray.count-1)
        
        let randomAnswer = randomDistribution.nextInt()
        
        let answer = self.answerArray[randomAnswer]
        
        self.disPlayLabel.text = "\(answer)"
        
    }
    
    @IBAction func round(_ sender: UIButton) {
        
        reNew()
        
    }
    
    func reNew () {
        
        self.resultButton.isEnabled = false
        
        self.disPlayLabel.text = ""
        
        self.pictureimageView.image = UIImage(named: "空白")
        
    }
    
}

extension ViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            
            print("No image found")
            
            return
            
        }

        self.pictureimageView.image = image

    }

}

extension ViewController : UINavigationControllerDelegate {
    
}
