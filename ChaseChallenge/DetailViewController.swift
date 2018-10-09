//
//  DetailViewController.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import MapKit
class DetailViewController: UITableViewController {

    //School Info
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var borough: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var overView: UITextView!
    @IBOutlet weak var email: UILabel!
    
    //SAT Scores
    @IBOutlet weak var criticalReadingAvg: UILabel!
    @IBOutlet weak var mathAvg: UILabel!
    @IBOutlet weak var writingAvg: UILabel!
    
    //Location
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var detailSAT: SAT?
    var detailSchool: School?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        self.view.backgroundColor = Styles.Colors.background
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        guard let SAT = detailSAT, let school = detailSchool else { return }
        self.title       = SAT.schoolName
        schoolName.text  = SAT.schoolName
        borough.text     = school.borough
        city.text        = school.city
        phoneNumber.text = school.phone_number
        email.text       = school.school_email
        overView.text    = school.overview_paragraph ?? ""
        
        criticalReadingAvg.text = SAT.criticalReadingAvg
        mathAvg.text            = SAT.mathAvg
        writingAvg.text         = SAT.writingAvg
        
        address.text = school.primary_address_line_1
        
        if  let lat = school.latitude,
            let long = school.longitude,
            let latCoordinate = Double(lat),
            let longCoordinate = Double(long){
            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
            let SATLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latCoordinate, longCoordinate)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(SATLocation, span)
            mapView.setRegion(region, animated: true)
            
            let schoolAnnotation = MKPointAnnotation()
            schoolAnnotation.title = school.school_name
            schoolAnnotation.coordinate = CLLocationCoordinate2D(latitude: latCoordinate, longitude: longCoordinate)
            mapView.addAnnotation(schoolAnnotation)
            
            mapView.layer.cornerRadius = Styles.Sizes.cardCornerRadius
            
        }
    }
}

