//
//  MenuViewer.swift
//  sokoban-game-mvc-pattern
//
//  Created by sher on 25/9/22.
//

import UIKit

protocol MenuDelegate: AnyObject {
    func returnLevel()
}

class MenuViewer: UIViewController {
    weak var delegate: MenuDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        // Do any additional setup after loading the view.
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
