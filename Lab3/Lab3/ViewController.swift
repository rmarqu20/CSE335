//
//  ViewController.swift
//  Lab3
//
//  Created by Richard Marquez on 2/14/22.
//

import UIKit

class ViewController: UIViewController
{
    // create an infoDictionary object that stores the movie info
    var movieInfoDictionary:infoDictionary = infoDictionary()
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var genreInput: UITextField!
    @IBOutlet weak var saleInput: UITextField!
    
    @IBOutlet weak var searchedTitle: UILabel!
    @IBOutlet weak var searchedGenre: UILabel!
    @IBOutlet weak var searchedSale: UILabel!
    
    @IBOutlet weak var currentTitle: UILabel!
    @IBOutlet weak var currentGenre: UILabel!
    @IBOutlet weak var currentSale: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Add(_ sender: UIBarButtonItem)
    {
        // check if input fields are empty
        if let  title = titleInput.text,
            let genre = genreInput.text,
            let sale = Int32(saleInput.text!)
        {
            movieInfoDictionary.add(title, genre, sale)
            
            self.currentTitle.text = title
            self.currentGenre.text = genre
            //let saleInt = sale
            self.currentSale.text = String(sale)
            
            // remove data from the text fields
            self.titleInput.text = ""
            self.genreInput.text = ""
            self.saleInput.text = ""
        }
        else
        {
            // Alert message will be displayed to th user if there is no input
            let alert = UIAlertController(title: "Data Input Error", message: "Data Inputs are either empty or incorrect types", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func Delete(_ sender: UIBarButtonItem)
    {
        // show the alert controller with data input text field
        let alertController = UIAlertController(title: "Delete Record", message: "", preferredStyle: .alert)
        
        let searchAction = UIAlertAction(title: "Delete", style: .default) { (aciton) in
            
            let text = alertController.textFields!.first!.text!
            
            if !text.isEmpty
            {
                let title = text
                self.movieInfoDictionary.deleteRec(s: title)
             }
             else
             {
                   // Alert message will be displayed to the user if there is no input
                   let alert = UIAlertController(title: "Data Input Error", message: "enter movie title to search", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "enter movie title here"
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func Search(_ sender: UIBarButtonItem)
    {
        // show the alert controller with data input text field
        let alertController = UIAlertController(title: "Search Record", message: "", preferredStyle: .alert)
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { (aciton) in
            
            let text = alertController.textFields!.first!.text!
            
            if !text.isEmpty {
                let title = text
                let p =  self.movieInfoDictionary.search(s: title)
                if let x = p {
                    self.searchedTitle.text = x.title!
                    self.searchedGenre.text = x.genre!
                    self.searchedSale.text = String(x.sale!)
                    print("In search")
                }else{}
             }
             else
             {
                // Alert message will be displayed to the user if there is no input
                let alert = UIAlertController(title: "Data Input Error", message: "enter movie title to search", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "enter movie title here"
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func Edit(_ sender: UIBarButtonItem)
    {
        // show the alert controller with data input text field
        let alertController = UIAlertController(title: "Edit Record", message: "", preferredStyle: .alert)
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { (aciton) in
            
            let text = alertController.textFields![0] as UITextField
            let newSale = alertController.textFields![1] as UITextField
            
            if text.hasText && newSale.hasText
            {
                let title = text
                let sale = newSale
                let p = self.movieInfoDictionary.search(s: title.text!)
                p?.sale = Int32(sale.text!)
                var index = 0
                for rec in self.movieInfoDictionary.recArray
                {
                    if(rec.title == title.text!)
                    {
                        self.movieInfoDictionary.recArray[index].sale = Int32(sale.text!)
                        if(self.currentTitle.text == text.text!)
                        {
                            self.currentSale.text = sale.text
                        }
                    }
                    index += 1
                }
             }
             else
             {
                   // Alert message will be displayed to the user if there is no input
                   let alert = UIAlertController(title: "Data Input Error", message: "enter movie title and sale to edit", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "enter movie title here"
            //textField.keyboardType = .decimalPad
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "enter new sale amount here"
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(editAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func Previous(_ sender: UIBarButtonItem)
    {
        if(movieInfoDictionary.recArray.isEmpty)
        {
            self.resultLabel.text = "No Entries"
            self.resultLabel.isHidden = false
        }
        else
        {
            let current = currentTitle.text!
            let prev = self.movieInfoDictionary.getPreviousRec(title: current)
            resultLabel.isHidden = true
            if(prev != nil)
            {
                self.currentTitle.text = prev?.title
                self.currentGenre.text = prev?.genre
                let saleInt = prev?.sale
                self.currentSale.text = String(saleInt!)
            }
            else
            {
                resultLabel.text = "Showing the first Record"
                resultLabel.isHidden = false
            }
        }
    }
    @IBAction func Next(_ sender: UIBarButtonItem)
    {
        if(movieInfoDictionary.recArray.isEmpty)
        {
            self.resultLabel.text = "No Entries"
            self.resultLabel.isHidden = false
        }
        else
        {
            let current = currentTitle.text!
            let next = self.movieInfoDictionary.getNextRec(title: current)
            resultLabel.isHidden = true
            if(next != nil)
            {
                self.currentTitle.text = next?.title
                self.currentGenre.text = next?.genre
                let saleInt = next?.sale
                self.currentSale.text = String(saleInt!)
            }
            else
            {
                resultLabel.text = "No more Records"
                resultLabel.isHidden = false
            }
        }
    }
    
}

