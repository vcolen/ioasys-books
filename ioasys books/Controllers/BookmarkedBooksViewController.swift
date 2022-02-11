//
//  BookmarkedBooksViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 11/02/22.
//

import UIKit

class BookmarkedBooksViewController: UIViewController {

    var customView = BooksCatalogueView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after oading the view.
        
    }
    
    override func loadView() {
        super.loadView()
        
        view = customView
    }
    
}
