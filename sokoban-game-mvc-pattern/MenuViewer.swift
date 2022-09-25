//
//  MenuViewer.swift
//  sokoban-game-mvc-pattern
//
//  Created by sher on 25/9/22.
//

import UIKit

protocol MenuDelegate: AnyObject {
    func returnLevel(level: Int)
}

class MenuViewer: UITableViewController {
    weak var delegate: MenuDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = "level\(indexPath.row + 1)"
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.returnLevel(level: indexPath.row + 1)
        dismiss(animated: true)
    }

}
