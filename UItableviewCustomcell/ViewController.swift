//
//  ViewController.swift
//  UItableviewCustomcell
//
//  Created by A RAJU on 1/7/20.
//  Copyright © 2020 A RAJU. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {
     // create varabels
           var tabelviewDta:UITableView!
           var moc:NSManagedObjectContext!
           var ad:AppDelegate!
        
           var imagePikkedObj:UIImageView!
           var studentEntity:NSEntityDescription!
           var pikedVC = UIImagePickerController()
        
          
          
           var deleteBtn = [UIButton]()
           var actImg = [UIImage]()
           var cricImg = [UIImage]()
           var poltImg = [UIImage]()
           var frstNm = [String]()
           var lastNm = [String]()
           var number = [Int64]()
           var totalText  = [String]()
           var text:String!
           
     
           var actors = [String]()
           var cricketer = [String]()
           var poltician = [String]()
     override func viewDidLoad() {
         super.viewDidLoad()
          coreDta()
          crateTB()
     
         // Do any additional setup after loading the view.
     }

     // coreData func
     func  coreDta(){
         ad = UIApplication.shared.delegate as! AppDelegate
         moc = ad.persistentContainer.viewContext
     studentEntity = NSEntityDescription.entity(forEntityName: "Allpeoples", in: moc)
     }
     
     // Create TabelView Func
        func crateTB(){
            
            tabelviewDta = UITableView(frame: view.frame, style: UITableView.Style.grouped)
            tabelviewDta.delegate = self
            tabelviewDta.dataSource = self
            tabelviewDta.register(UITableViewCell.self, forCellReuseIdentifier: "abc")
            tabelviewDta.backgroundColor = #colorLiteral(red: 0.7576924562, green: 0.9412582517, blue: 0.7989848256, alpha: 1)
            view.addSubview(tabelviewDta)
        }
          func numberOfSections(in tableView: UITableView) -> Int {
          return 3
     }
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
    
         if(section == 0){
         
            return "Actors"
             }
         else if(section == 1){
             return "Cricketers"
          }
            return "Politician"
      }
     // TabelView Delagate Methods
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
         if(section == 0){
             
             return actors.count
         }else if(section == 1){
             
             return cricketer.count
         } else if(section == 2){
        
             return poltician.count
         
         }
         return 3
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         
       var   cell = tableView.dequeueReusableCell(withIdentifier: "abc", for: indexPath)
         
           cell.textLabel!.numberOfLines = 0
           cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
           cell.widthAnchor.constraint(equalToConstant: 100).isActive = true
           cell.textLabel?.textAlignment  = .center
           cell.imageView?.layer.cornerRadius = 20
           cell.imageView?.clipsToBounds = true
        
           if(indexPath.section == 0){
                 cell.textLabel?.text = actors[indexPath.row]
                 cell.imageView?.image = actImg[indexPath.row]
              }
             else if(indexPath.section == 1){
              
                 cell.textLabel?.text = cricketer[indexPath.row]
             cell.imageView?.image = cricImg[indexPath.row]
              }
              else if(indexPath.section == 2){
             
             cell.textLabel?.text = poltician[indexPath.row]
             cell.imageView?.image = poltImg[indexPath.row]
              }
               
           return cell
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           return 80
       }
       
     @IBAction func addBtn(_ sender: Any) {
         frstNm = [String]()
         lastNm = [String]()
         number = [Int64]()
         actors = [String]()
         cricketer = [String]()
         poltician = [String]()
         totalText = [String]()
         cricImg = [UIImage]()
         actImg = [UIImage]()
          poltImg = [UIImage]()
         let svc = self.storyboard?.instantiateViewController(withIdentifier: "SVC") as! SCViewController
                    navigationController?.pushViewController(svc, animated: true)
                
                
     }
     @IBAction func deleteBtn(_ sender: Any) {
         let fectchingRqst = NSFetchRequest<NSFetchRequestResult>(entityName: "Allpeoples")
         let  result = try? moc.fetch(fectchingRqst)
           for object in result as! [NSManagedObject]{
            moc.delete(object as! NSManagedObject)
               do{
           print("deleted")
             try moc.save()
               }catch{
               print("Not Delteted")
              }
                }
                  
     }
     // ViewWiilAppear function
     override func viewWillAppear(_ animated: Bool) {
                  actors = [String]()
                  cricketer = [String]()
                  poltician = [String]()
                   frstNm = [String]()
                   lastNm = [String]()
                   number = [Int64]()
                   cricImg = [UIImage]()
                   actImg = [UIImage]()
                    poltImg = [UIImage]()
                   totalText = [String]()
         let fectchingRqst = NSFetchRequest<NSFetchRequestResult>(entityName: "Allpeoples")

                 do{


                 let fetchMoc =  try moc.fetch(fectchingRqst)
               

                 for i in 0..<fetchMoc.count{
                 
                                       
                    let currentMo = fetchMoc[i] as! NSManagedObject
                    let path =   currentMo.value(forKey: "deisignation") as? String ?? "empty"
                     
                     print("deisignation",currentMo.value(forKey: "deisignation") as? String ?? "empty")
                     
                     
                    let defaultImage = UIImage(named: "images")
                    let imageDef = defaultImage?.pngData() as! NSData
                    let imaged = currentMo.value(forKey: "image") as? NSData ?? imageDef
                     let uiimage = UIImage(data: ((imaged as Data?)!))
                     if let c = uiimage
                     {
                      if(path == "Actors"){
                      actImg.append(c)
                      }
                      if(path == "Criketer"){
                         cricImg.append(c)
                     }
                      if(path == "Politician"){
                          poltImg.append(c)
                     }
                     }
         let nameTF1 = currentMo.value(forKey: "name") as! String
                         //frstNm.append(nameTF1)
                         text = nameTF1
                         print(nameTF1)
         let nameTF2 = currentMo.value(forKey: "industry") as! String
                         lastNm.append(nameTF2)
                         text += "\n" + "\(nameTF2)"
                         print(nameTF2)
         let numTF3 = currentMo.value(forKey: "age") as? Int64 ?? 0

                         text +=  "\n" + "\(numTF3)"
                          number.append(numTF3)

                     totalText.append(text)
                        // print(numTF3)
              if(path == "Actors"){
               actors.append(text)
                print("act:", actors)
                      
                }
              if(path == "Criketer"){
                 cricketer.append(text)
                  print("cric:", cricketer)
                                  }
              if(path == "Politician")
              {
                  poltician.append(text)
               print("poltiy:", poltician)
                                         
             }
               print("sucess")
                     }

                 }catch
             {
                 print("unabel to Display")
             }

         tabelviewDta.reloadData()
         }


}

