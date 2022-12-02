//
//  ViewController.swift
//  Conway's Game
//
//  Created by Michael on 12/2/22.
//

import UIKit

final class MainViewController: UIViewController {

    //MARK: - UI Elements
    private lazy var areaOfSquaresView = AreaView(frame: CGRect(x: 0, y: view.frame.height / 4, width: view.frame.width, height: view.frame.width))
    
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
        print(areaOfSquaresView.frame)
    }
    
    
    //MARK: - Logic of UI Elements
    @objc private func reloadAllArea() {
        self.areaOfSquaresView.ChangeColorInLine(count: 50)
    }
    
    
    //MARK: - Setting UI Elements
    private func addViews() {
        view.addSubview(areaOfSquaresView)
        view.addSubview(reloadAreaButton)
    }
    
    private func setViews() {
        areaOfSquaresView.translatesAutoresizingMaskIntoConstraints = false
        reloadAreaButton.addTarget(self, action: #selector(reloadAllArea), for: [.touchUpInside, .touchUpOutside])
        view.backgroundColor = .white
        self.areaOfSquaresView.makePictureOfSquares(withNumberOfSquares: 50)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            areaOfSquaresView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            areaOfSquaresView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            areaOfSquaresView.widthAnchor.constraint(equalToConstant: view.frame.width),
            areaOfSquaresView.heightAnchor.constraint(equalToConstant: view.frame.width),
            
            reloadAreaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadAreaButton.topAnchor.constraint(equalTo: areaOfSquaresView.bottomAnchor, constant: 50 )
            
        ])
    }

}

