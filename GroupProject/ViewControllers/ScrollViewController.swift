//
//  ScrollViewController.swift
//  GroupProject
//
//  Created by Oreoluwa Omomofe on 7/29/20.
//  Copyright © 2020 One Summer Chicago. All rights reserved.
//

import UIKit
import PDFKit

class ScrollViewController: UIViewController {
    
// hardcoded pdf file
    var pdfname: String = "NAPOLEON"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
// view pdf autoscale vertically
        let pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)

        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        
        
        // Thumbnail view pages
        let thumbnailView = PDFThumbnailView()
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thumbnailView)
        
        thumbnailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        thumbnailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        thumbnailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        thumbnailView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        thumbnailView.thumbnailSize = CGSize(width: 100,  height: 60)
        thumbnailView.layoutMode = .horizontal
        thumbnailView.pdfView = pdfView
        
        guard let path = Bundle.main.url(forResource: "NAPOLEON" , withExtension: "pdf") else { return }

         let document = PDFDocument(url: path)
            pdfView.document = document
        
     // Get an array of selections where each selection corresponds to a single line of the selected text
     guard let selections = pdfView.currentSelection?.selectionsByLine()
         else { return }

     // Loop over the selections line by line
     selections.forEach({ selection in
         // Loop over the pages encompassed by each selection
         selection.pages.forEach({ page in
             // Create a new highlight annotation with the selection's bounds and add it to the page
             let highlight = PDFAnnotation(bounds: selection.bounds(for: page), forType: .highlight, withProperties: nil)
             highlight.color = .yellow
             page.addAnnotation(highlight)
            
            // Get the current page
            guard let page = pdfView.currentPage else {return}
            // Create a rectangular path
            // Note that in PDF page coordinate space, (0,0) is the bottom left corner of the page
            let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 100, height: 100))
            let inkAnnotation = PDFAnnotation(bounds: page.bounds(for: pdfView.displayBox), forType: .ink, withProperties: nil)
            inkAnnotation.add(path)
            page.addAnnotation(inkAnnotation)
         })
     })
       
    }
        }



