//
//  GestioneImmagini.swift
//  MessaggiApp
//
//  Created by Michele on 08/01/21.
//

import Foundation
import UIKit
import SwiftUI


struct CatturaImmagine : UIViewControllerRepresentable{
    @Binding var image : UIImage?
    @Binding var isShow : Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, isShow: $isShow)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CatturaImmagine>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CatturaImmagine>) {
        
    }
}
class Coordinator: NSObject,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    @Binding var imageCordinator : UIImage?
    @Binding var isShowCordinator : Bool
    init(image: Binding<UIImage?>, isShow: Binding<Bool> ) {
        _imageCordinator = image
        _isShowCordinator = isShow
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        imageCordinator =  unwrapImage
        isShowCordinator = false
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        Serve per disattivarlo
        isShowCordinator = false
        
    }
}
