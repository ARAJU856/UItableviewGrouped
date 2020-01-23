//
//  SCViewController.swift
//  UItableviewCustomcell
//
//  Created by A RAJU on 1/7/20.
//  Copyright © 2020 A RAJU. All rights reserved.
//

import UIKit
import CoreData

class SCViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
      
        @IBOutlet weak var ageTF: UITextField!
        
       
        @IBOutlet weak var allCatogirySC: UISegmentedControl!
        @IBOutlet weak var imageVw: UIImageView!
        @IBOutlet weak var nameTF: UITextField!
        
        @IBOutlet weak var industryTF: UITextField!
        @IBOutlet weak var conentView: UIView!
        var imagePikker = UIImagePickerController()
        var imageButton:UIButton!
        var moc:NSManagedObjectContext!
        var frstTF = ""
        var lastTF = ""
        var numTF  =  ""
        var image11 = [UIImage]()
        var imagedata:NSData!
        var msg:String!
        var ad:AppDelegate!
        var index:Int!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // sgemtedCntrol()
         ad = UIApplication.shared.delegate as! AppDelegate
                moc = ad.persistentContainer.viewContext
                    imagesdata()
            // Do any additional setup after loading the view.
        }
        
        
        //segmented controlobjects
        
    //    func sgemtedCntrol(){
    //        allCatogirySC = UISegmentedControl()
    //        allCatogirySC.frame = CGRect(x: 100, y: 500, width: 120, height: 30)
    //        let catagiries = ["Actors","Criketers","Politician"]
    //        allCatogirySC.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    //        allCatogirySC.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    //        allCatogirySC.clipsToBounds = true
    //        allCatogirySC = UISegmentedControl(items: catagiries)
    //        conentView.addSubview(allCatogirySC)
    //    }
        
        
        @objc func tagetsSC(obj:UISegmentedControl){
            index = obj.tag
        }
        
        // Create imageDisplay button and addtarget function
                
                func imagesdata(){
                imageButton = UIButton(frame: CGRect(x: 110, y: 140, width: 200, height: 150))
                imageButton .clipsToBounds = true
                imageButton .layer.cornerRadius = imageButton.frame.size.width/2
                imageButton.addTarget(self, action: #selector(imageTarget), for: UIControl.Event.touchUpInside)
                imageButton.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                imageButton.setTitle("ChooseImage", for: UIControl.State.normal)
                imageButton.setBackgroundImage(UIImage(named: "images"), for: UIControl.State.normal)
                conentView.addSubview(imageButton)
                }
                
        // addtrarget fun in image
            @objc func imageTarget(obj:Any)
                 {
                   if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum)){
                    imagePikker.delegate = self
                        imagePikker.sourceType = .savedPhotosAlbum
                        imagePikker.allowsEditing = true
                        self.present(imagePikker, animated: true, completion: nil)
                    }
                }
    
        // image pikkercontroller fun
                
                func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                    if let pickkedImage:UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage{
                  imageButton.setImage(pickkedImage, for: UIControl.State.normal)
                  imagedata = (pickkedImage.pngData() as! NSData)
                 
                    }
                    dismiss(animated: true, completion: nil)
                }
             
        // SAVE Contacts fun Of IB ActionButton
         
        @IBAction func saveBtn(_ sender: Any) {
            
                let entity = NSEntityDescription.entity(forEntityName: "Allpeoples", in: moc)
                let newUser = NSManagedObject(entity: entity!, insertInto: moc)
                       
       
            
            if (allCatogirySC.selectedSegmentIndex == 0){
                
                newUser.setValue(imagedata, forKey: "image")
                newUser.setValue(nameTF.text!, forKey: "name")
                newUser.setValue(industryTF.text!, forKey: "industry")
                newUser.setValue("Actors", forKey: "deisignation")
                let age = Int(ageTF.text!)
                newUser.setValue(age, forKey: "age")
                       
            }
            
            if (allCatogirySC.selectedSegmentIndex == 1){
                
                newUser.setValue(imagedata, forKey: "image")
                newUser.setValue(nameTF.text!, forKey: "name")
                newUser.setValue(industryTF.text!, forKey: "industry")
                newUser.setValue("Criketer", forKey: "deisignation")
                let age = Int(ageTF.text!)
                newUser.setValue(age, forKey: "age")
                       
            }
            
           
            if (allCatogirySC.selectedSegmentIndex == 2){
                
                newUser.setValue("Politician", forKey: "deisignation")
                newUser.setValue(imagedata, forKey: "image")
                newUser.setValue(nameTF.text!, forKey: "name")
                newUser.setValue(industryTF.text!, forKey: "industry")
                let age = Int(ageTF.text!)
                newUser.setValue(age, forKey: "age")
                       
            }
            
                navigationController?.popViewController(animated: true)
                 //print("saved")
            
            do
            {
                try moc.save()
            }catch{
                print("not saved")
            }
            
            }
            
   
}
