//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by Mac 11 on 5/18/21.
//  Copyright © 2021 ColeccionDeJuegos. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var JuegoImageVoew: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var categoriaTextField: UITextField!
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    
    let categories = ["Naturaleza", "Wallpappers", "Praderas", "Playas", "Ríos"]
    
    var imagePicker = UIImagePickerController()
    var pickerView = UIPickerView()
    var juego: JuegoT? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        categoriaTextField.inputView = pickerView
        
        if juego != nil {
            tituloTextField.text = juego!.titulo
            categoriaTextField.text = juego!.categoria
            JuegoImageVoew.image = UIImage(data: (juego!.imagen!) as Data)
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        } else {
            eliminarBoton.isHidden = true
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoriaTextField.text = categories[row]
        categoriaTextField.resignFirstResponder()
    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        
        
        
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        
        if juego != nil {
            juego!.imagen = JuegoImageVoew.image?.jpegData(compressionQuality: 0.50)
            juego!.titulo = tituloTextField.text
            juego!.categoria = categoriaTextField.text
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = JuegoT(context: context)
            juego.titulo = tituloTextField.text
            juego.categoria = categoriaTextField.text
            juego.imagen = JuegoImageVoew.image?.jpegData(compressionQuality: 0.50)
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imageSelected = info[.originalImage] as? UIImage
        JuegoImageVoew.image = imageSelected
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
