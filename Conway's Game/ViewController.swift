//
//  ViewController.swift
//  Conway's Game
//
//  Created by Michael on 12/2/22.
//

import UIKit

final class MainViewController: UIViewController {

    //MARK: - UI Elements
    private lazy var worldView = WorldView(frame: CGRect(x: 0, y: view.frame.height / 4, width: view.frame.width, height: view.frame.width))
    
    private let reloadAreaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Обновить все поле", for: .normal)
        button.backgroundColor = .blue
        button.tintColor = .red
        return button
    }()
    
    
    //MARK: - ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setViews()
        setConstraints()
    }
    
    
    override func viewWillLayoutSubviews() {

    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    
    //MARK: - Logic of UI Elements
    @objc private func reloadAllArea() {
        self.worldView.makeStap()
    }
    
    
    //MARK: - Setting UI Elements
    private func addViews() {
        view.addSubview(worldView)
        view.addSubview(reloadAreaButton)
    }
    
    private func setViews() {
        worldView.translatesAutoresizingMaskIntoConstraints = false
        reloadAreaButton.addTarget(self, action: #selector(reloadAllArea), for: [.touchUpInside, .touchUpOutside])
        view.backgroundColor = .white
        self.worldView.createRandomPositions(numberOfPositions: 6000)
        self.worldView.createWorld()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            worldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            worldView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            worldView.widthAnchor.constraint(equalToConstant: view.frame.width),
            worldView.heightAnchor.constraint(equalToConstant: view.frame.width),
            
            reloadAreaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadAreaButton.topAnchor.constraint(equalTo: worldView.bottomAnchor, constant: 50 )
            
        ])
    }

}

