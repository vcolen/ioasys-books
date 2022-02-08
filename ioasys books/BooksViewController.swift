//
//  BooksViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit

class BooksViewController: UIViewController {
    
    lazy var viewCustom = BooksCatalogueView()
   // var books = [Book]()
    var authorization = ""
    
    override func loadView() {
        super.loadView()
        
        view = viewCustom
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       // loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // loginUser()
    }
    
    
    
    
}


