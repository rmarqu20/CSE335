//
//  ViewController.swift
//  Lab4
//
//  Created by Richard Marquez on 2/27/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var cityTable: UITableView!
    
    //model object
    let test: cities = cities()
    var photoPicker = UIImagePickerController()
    let section = ["A", "B", "C"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        test.initCounter()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        cityTable.reloadData()
    }
    
    /*
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return section.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return test.fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
            cell.layer.borderWidth = 1.0
        cell.textLabel?.text = test.fetchResults[indexPath.row].cityName
        
        if let picture = test.fetchResults[indexPath.row].cityImage
        {
            cell.imageView?.image =  UIImage(data: picture as Data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle
    {
        return UITableViewCell.EditingStyle.delete
    }
    
    // implement delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            // delete the selected object from the managed
            // object context
            test.managedObjectContext.delete(test.fetchResults[indexPath.row])
            // remove it from the fetch results array
            test.fetchResults.remove(at:indexPath.row)
            
            do
            {
                // save the updated managed object context
                try test.managedObjectContext.save()
            }
            catch
            {
                print("Unable to save data")
            }
            // reload the table after deleting a row
            cityTable.reloadData()
        }
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
    //load image picker
    @IBAction func loadImage(_ sender: Any)
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
    //add a new city record
    func addRecord(image: UIImage)
    {
        // one more item added
        test.updateCounter()
        
        // show the alert controller to select an image for the row
        let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
        
        //alert text fields
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the City Here"
        })
           alertController.addTextField(configurationHandler: { textField in
               textField.placeholder = "Enter Description of the City Here"
           })
        //add new city button
        let searchAction = UIAlertAction(title: "New City", style: .default) { (action) in
            let name2 = alertController.textFields?.first?.text
                print("city name: \(name2)")
            let descript = alertController.textFields?.last?.text
                print("city description: \(descript)")
            
            if(name2 != "" && descript != "")
            {
                //send data to model
                let img = NSData(data: image.jpegData(compressionQuality: 0.5)!)
                self.test.addNewCity(cName: name2, cDescription: descript, cImage: img)
            }
            //save new city to core data and reload data
            do
            {
                try self.test.managedObjectContext.save()
                self.test.fetch()
                self.cityTable.reloadData()
            }
            catch
            {
                print("Could not save data: \(error.localizedDescription)")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        //add create and cancel action to alert
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    //add image to city record
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image2 = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            picker.dismiss(animated: true, completion: {
                self.addRecord(image: image2)
            })
        }
    }
    //update cityTable
    func updateLastRow()
    {
        let indexPath = IndexPath(row: test.fetchResults.count - 1, section: 0)
        cityTable.reloadRows(at: [indexPath], with: .automatic)
    }
    //prepare function for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        if(segue.identifier == "detailView")
        {
            if let viewController: SecondViewController = segue.destination as? SecondViewController
            {
                //pass selected city data to model
                let selected = test.fetchResults[selectedIndex.row]
                viewController.selectedObject = selected
                viewController.selectedCity = selected.cityName
                viewController.selectedCityDescription = selected.cityDescription
                viewController.selectedCityImage = selected.cityImage
            }
        }
    }
    //memory warning
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
