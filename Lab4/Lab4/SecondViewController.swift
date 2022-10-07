//
//  SecondViewController.swift
//  Lab4
//
//  Created by Richard Marquez on 2/27/22.
//

import UIKit

class SecondViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityNameLabel2: UILabel!
    @IBOutlet weak var cityDescriptionLabel: UILabel!
    
    var selectedObject:City?
    var selectedCity:String?
    var selectedCityDescription:String?
    var selectedCityImage:NSData?
    let test: cities = cities()
    var photoPicker = UIImagePickerController()
    
    override func viewDidLoad()
        {
            super.viewDidLoad()
            //set image and labels for selected city
            cityNameLabel2.text = selectedCity!
            cityImage.image = UIImage(data: selectedCityImage! as Data)
            cityDescriptionLabel.text = selectedCityDescription!
        }
        
        func openCamera()
        {
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                photoPicker.sourceType = UIImagePickerController.SourceType.camera
                photoPicker.allowsEditing = true
                self.present(photoPicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        func openGallary()
        {
            photoPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            photoPicker.allowsEditing = true
            self.present(photoPicker, animated: true, completion: nil)
        }
        
        @IBAction func updateImage(_ sender: Any)
        {
            // load image
            photoPicker.delegate = self
            photoPicker.sourceType = .photoLibrary
            
            let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                self.openGallary()
            }))
                
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        //edit city image
        func editRec(image: UIImage)
        {
            let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
            let add = UIAlertAction(title: "Save", style: .default) { [self] (action) in
                let description = alert.textFields?.last?.text
                if description != ""
                {
                    test.editCity(cName: selectedCity!, cDescription: description, cImage: image)
                    self.cityImage.image = image
                    self.cityDescriptionLabel.text = description
                }
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                
            }
            alert.addTextField(configurationHandler: { (field) in
                field.placeholder = "Enter new description"
            })
            alert.addAction(add)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    
        //add image to city record
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
        {
            if let image2 = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            {
                picker.dismiss(animated: true, completion: {
                    self.editRec(image: image2)
                })
            }
        }
        
        override func didReceiveMemoryWarning()
        {
            super.didReceiveMemoryWarning()
        }
    }
