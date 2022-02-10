//
//  BookDetailViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 10/02/22.
//

import UIKit

class BookDetailViewController: UIViewController {

    let customView = BookDetailView()
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func loadView() {
        super.loadView()
        
        view = customView
        
    }
}
