//
//  ViewController.swift
//  FrameworkClient
//
//  Created by iMac on 18/02/21.
//

import UIKit
import PuGradientUISlider
class ViewController: UIViewController {

    @IBOutlet weak var slidernw: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        PUGradientSlider.setSliderWithFrame(CGRect(x: 0.0, y: 0.0, width: slidernw.bounds.width, height: 12.0 ), sliderNamed: slidernw, withcolors: [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor], thumbFrm: CGRect(x: 0, y: 0, width: 35.0, height: 35.0), thumbBgColor: UIColor.green,thumbImg: UIImage.init(named: "thumbtint")!)
    }
}
