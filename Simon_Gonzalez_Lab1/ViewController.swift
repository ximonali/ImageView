//
//  ViewController.swift
//  Simon_Gonzalez_Lab1
//
//  Created by macadmin on 2016-07-27.
//  Copyright © 2016 Lambton_College. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

// Variables
    var timer = Timer()
    var actualImage: Int = 0
    var imageStrings:[String] = []
    var myScrollView:UIScrollView!
    var scrollWidth : CGFloat = 320
    let scrollHeight : CGFloat = 100
    let thumbNailWidth : CGFloat = 80
    let thumbNailHeight : CGFloat = 80
    let padding: CGFloat = 10
    
    fileprivate var gestureStartPoint: CGPoint!
    
    @IBAction func run(_ sender: UIButton) {

    }
   
    @IBAction func stop(_ sender: UIButton) {
        
    }
    
    
    
    @IBOutlet weak var previewView: UIImageView!
    
    @IBAction func btnNext(_ sender: UIButton) {
        timer.invalidate()
        nextImage()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        timer.invalidate()
        previousImage()
    }
    
    func nextImage(){
        if (actualImage >= 0 && actualImage < 6) {
            actualImage = actualImage + 1
            showImagesByIndex(actualImage)
            //print(actualImage)
        }else {
            actualImage = 0
            
        }

    }
    
    func previousImage(){
        if (actualImage > 0 && actualImage <= 6 ) {
            actualImage = actualImage - 1
            showImagesByIndex(actualImage)
            //print(actualImage)
        }else {
            actualImage = 0
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
        addImages()
        showImages()
        getSwipes()
        getTaps()
        startSlide()
        
        
    }// end viewDidLoad


    func loadImages(){
        imageStrings = ["Image-0","Image-1","Image-2","Image-3","Image-4","Image-5","Image-6"]
        
        scrollWidth = self.view.frame.width
        
        //setup scrollView
        myScrollView = UIScrollView(frame: CGRect(x: 0, y: self.view.frame.height - scrollHeight, width: scrollWidth, height: scrollHeight))
        
        //setup content size for scroll view
        let contentSizeWidth:CGFloat = (thumbNailWidth + padding) * (CGFloat(imageStrings.count))
        let contentSize = CGSize(width: contentSizeWidth ,height: thumbNailHeight)
        
        myScrollView.contentSize = contentSize
        myScrollView.autoresizingMask = UIViewAutoresizing.flexibleWidth
    
    }
    
    func addImages(){
        for(index,value) in imageStrings.enumerated() {
            
            let button:UIButton = UIButton(type: .custom)
            
            //calculate x for uibutton
            let xButton = CGFloat(padding * (CGFloat(index) + 1) + (CGFloat(index) * thumbNailWidth))
            button.frame = CGRect(x: xButton,y: padding, width: thumbNailWidth, height: thumbNailHeight)
            button.tag = index
            
            let image = UIImage(named:value)
            button.setBackgroundImage(image, for: UIControlState())
            button.addTarget(self, action: #selector(ViewController.changeImage(_:)), for: .touchUpInside)
            
            myScrollView.addSubview(button)
        }//end for
        
    }
    
    func showImages(){
        previewView.image = UIImage(named: imageStrings[0])
        self.view.addSubview(myScrollView)
    
    }
    
    func showImagesByIndex(_ value: Int ){
    
        let name = imageStrings[value]
        //print(value)
        previewView.image = UIImage(named: name)
        
        previewView.image = UIImage(named: imageStrings[value])
        self.view.addSubview(myScrollView)
        
    }
    
    func changeImage(_ sender:UIButton){
        let name = imageStrings[sender.tag]
        print(sender.tag)
        previewView.image = UIImage(named: name)
    }

    
    func getSwipes(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeDown)
    }

    func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                //print("Swiped right")
//                if (actualImage > 0) {
//                    showImagesByIndex(actualImage--)
//                }
                previousImage()
                
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                //print("Swiped left")
//                if (actualImage < 7) {
//                    showImagesByIndex(actualImage++)
//                }
                nextImage()
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    func getTaps(){
    
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.singleTap))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(singleTap)
    
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.doubleTap))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(doubleTap)
        singleTap.require(toFail: doubleTap)
    
    }
  
    //Target For mi Taps
    func singleTap() {
        //print("Single Tap Detected")
        timer.invalidate()
        
    }
    
    func doubleTap() {
        //print("Double Tap Detected")
        startSlide()
        
    }
    
    //Init Timer
    func startSlide(){
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    //Target for My Timer
    func update() {
        print("Timer working")
        
        if (actualImage >= 0 && actualImage < 6) {
            actualImage = actualImage + 1
            showImagesByIndex(actualImage)
            //print(actualImage)
        }else if (actualImage > 0 && actualImage <= 6 ) {
            actualImage = actualImage - 1
            showImagesByIndex(actualImage)
            //print(actualImage)
        }

        
//        if (actualImage < 7) {
//            showImagesByIndex(actualImage++)
//        }else if (actualImage > 0) {
//            showImagesByIndex(actualImage--)
//        }
        
    }
    

}// end ViewController

