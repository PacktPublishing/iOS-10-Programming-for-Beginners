//
//  CreateReviewViewController.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/23/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices


class CreateReviewViewController: UITableViewController {
    
    @IBOutlet var tvReview: UITextView!
    @IBOutlet var tfName: UITextField!
    @IBOutlet var btnThumbnail: UIButton!
    @IBOutlet var btnRating: UIButton!
    
    var image: UIImage?
    var thumbnail: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case Segue.applyFilter.rawValue:
            showApplyFilter(with: segue)
        default:
            print("Segue not added")
        }
    }
    
    func initialize() {
        requestAccess()
        updateTextView()
    }
    
    func updateTextView() {
        tvReview.layer.borderColor = UIColor.lightGray.cgColor
        tvReview.layer.borderWidth = 0.5
        tvReview.layer.cornerRadius = 5.0
        tvReview.text = ""
    }
    
    func showApplyFilter(with segue:UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController,
            let viewController = navController.topViewController as? ApplyFilterViewController else {
                return
        }
        
        viewController.image = image
        viewController.thumbnail = thumbnail
    }
    
    func requestAccess() {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { granted in
            if granted {}
        }
    }
    
    func checkSource() {
        let cameraMediaType = AVMediaTypeVideo
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: cameraMediaType)
        
        switch cameraAuthorizationStatus {
            
        case .authorized:
            showCameraUserInterface()
            
        case .restricted:
            break
            
        case .denied:
            break
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: cameraMediaType) { granted in
                if granted {
                    self.showCameraUserInterface()
                } else {
                }
            }
        }
    }
    
    @IBAction func unwindReviewCancel(segue:UIStoryboardSegue) {}
    @IBAction func unwindRatingSave(segue:UIStoryboardSegue) {}
    @IBAction func unwindFilterSave(segue:UIStoryboardSegue) {
        if segue.source is ApplyFilterViewController {
            if let thumbnail = thumbnail {
                btnThumbnail.setImage(thumbnail, for: .normal)
            }
        }
    }
    
    @IBAction func onPhotoTapped(_ sender: AnyObject) {
        checkSource()
    }
}

extension CreateReviewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showCameraUserInterface() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        #else
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.showsCameraControls = true
            
        #endif
        
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func generate(image:UIImage, ratio:CGFloat) -> UIImage {
        let size = image.size
        var croppedSize:CGSize?
        var offsetX:CGFloat = 0.0
        var offsetY:CGFloat = 0.0
        
        if size.width > size.height {
            offsetX = (size.height - size.width) / 2
            croppedSize = CGSize(width: size.height, height: size.height)
        }
        else {
            offsetY = (size.width - size.height) / 2
            croppedSize = CGSize(width: size.width, height: size.width)
        }
        guard let cropped = croppedSize, let cgImage = image.cgImage else {
            return UIImage()
        }
        
        let clippedRect = CGRect(x: offsetX * -1, y: offsetY * -1, width: cropped.width, height: cropped.height)
        let imgRef = cgImage.cropping(to: clippedRect)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: ratio, height: ratio)
        UIGraphicsBeginImageContext(rect.size)
        
        if let ref = imgRef {
            UIImage(cgImage: ref).draw(in: rect)
        }
        
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let thumb = thumbnail else { return UIImage() }
        
        return thumb
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        if let img = image {
            self.btnThumbnail.imageView?.image = generate(image: img, ratio: CGFloat(102))
            self.thumbnail = generate(image: img, ratio: CGFloat(102))
            self.image = generate(image: img, ratio: CGFloat(752))
        }
        
        picker.dismiss(animated: true, completion: {
            self.performSegue(withIdentifier: Segue.applyFilter.rawValue, sender: self)
        })
    }
}
