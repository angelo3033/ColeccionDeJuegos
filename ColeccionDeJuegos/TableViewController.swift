//
//  TableViewController.swift
//  ColeccionDeJuegos
//
//  Created by Mac 11 on 5/18/21.
//  Copyright © 2021 ColeccionDeJuegos. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var juegos: [JuegoT] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return juegos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let juego = juegos[indexPath.row]
        cell.imageView?.image = UIImage(data: (juego.imagen!))
        cell.textLabel?.text = juego.titulo
        cell.detailTextLabel?.text = juego.categoria

        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let juego = juegos[indexPath.row]
        performSegue(withIdentifier: "juegoSegue", sender: juego)
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(juegos.remove(at: indexPath.row))
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let btnActualizar = UITableViewRowAction(style: .normal, title: "Actualizar") {
            (actionRow, indexRow) in
            let juego = self.juegos[indexPath.row]
            self.performSegue(withIdentifier: "juegoSegue", sender: juego)
        }
        btnActualizar.backgroundColor = UIColor.red
    
        let btnDelete = UITableViewRowAction(style: .normal, title: "Eliminar") {
             (actionRow, indexRow) in
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(self.juegos.remove(at: indexPath.row))
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        btnDelete.backgroundColor = UIColor.green
            
        self.navigationController?.popViewController(animated: true)
        tableView.reloadData()
    
        return[btnActualizar, btnDelete]
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    @IBAction func editCell(_ sender: Any) {
        
        if tableView.isEditing {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let siguienteVC = segue.destination as! JuegosViewController
        siguienteVC.juego = sender as? JuegoT
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try juegos = context.fetch(JuegoT.fetchRequest())
            tableView.reloadData()
        } catch {
        }
    }

}
