//
//  ViewController.swift
//  RealmSample
//
//  Created by Administrator on 01/03/24.
//

import UIKit
import RealmSwift

class AuthManager {
    static let shared = AuthManager()
//application-0-skqlq
//application-0-anzuc
    private let app = App(id: "application-0-anzuc")

    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        app.login(credentials: Credentials.emailPassword(email: email, password: password)) { result in
            switch result {
            case .success(let user):
                print("Successfully logged in as user: \(user)")
                completion(.success(user))
            case .failure(let error):
                print("Failed to log in: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

    // Add more authentication methods as needed
}

class ViewController: UIViewController {
    // Create an instance of AuthManager
    @IBOutlet var myTableview: UITableView!
    let authManager = AuthManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView();
        // Do any additional setup after loading the view.
    }
    private func setupTableView() {

        // Register cell class if needed
        myTableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Set delegates
        myTableview.delegate = self
        myTableview.dataSource = self

       
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        // Call the login function
        authManager.login(email: "gogulayadhav@gmail.com", password: "Rajasekhar@226") { result in
            switch result {
            case .success(let user):
                // User successfully logged in
                print("Logged in as user: \(user)")
                // Navigate to the next screen or perform other actions
            case .failure(let error):
                // Failed to log in
                print("Failed to log in: \(error.localizedDescription)")
                // Show an alert or error message to the user
            }
        }
    }
    

}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        //return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Data \(indexPath.row)"
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle row selection
        print("Selected item: \(indexPath.row)")
    }
}
