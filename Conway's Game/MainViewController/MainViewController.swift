//
//  ViewController.swift
//  Conway's Game
//
//  Created by Michael on 12/2/22.
//

import UIKit

final class MainViewController: UIViewController {

    //MARK: - Model
    private var viewModel: MainWorldViewViewModelProtocol!
    
    
    //MARK: - UI Elements
    private lazy var worldView = WorldView(frame: CGRect(x: 0, y: view.frame.height / 4, width: view.frame.width, height: view.frame.width))
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let startStopGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Запустить игру", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let addRandomLifeCellsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Задать точки рандомно", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    //MARK: - ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        addViews()
        setConstraints()
    }
    
    
    //MARK: - Logic of UI Elements
    @objc private func startStopGame() {
        if viewModel.gamingStatus == .start {
            startStopGameButton.setTitle("Запустить игру", for: .normal)
            viewModel.changeStatusGame()
        } else {
            startStopGameButton.setTitle("Остановить игру", for: .normal)
            viewModel.changeStatusGame()
        }
    }
    
    @objc private func addRandomLifeCells() {
        viewModel.placeRandomLifeCell()
        startStopGameButton.setTitle("Запустить игру", for: .normal)
    }
    
    
    //MARK: - Setting UI Elements
    private func addViews() {
        view.addSubview(worldView)
        view.addSubview(startStopGameButton)
        view.addSubview(addRandomLifeCellsButton)
        view.addSubview(slider)
    }
    
    private func setViews() {
        viewModel = MainWorldViewViewModel()
        viewModel.updateViewData = { data in
            self.worldView.dataToPresent = data
        }
        viewModel.placeRandomLifeCell()
        view.backgroundColor = .white
        worldView.translatesAutoresizingMaskIntoConstraints = false
        startStopGameButton.addTarget(self, action: #selector(startStopGame), for: [.touchUpInside, .touchUpOutside])
        addRandomLifeCellsButton.addTarget(self, action: #selector(addRandomLifeCells), for: [.touchUpInside, .touchUpOutside])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            worldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            worldView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            worldView.widthAnchor.constraint(equalToConstant: view.frame.width),
            worldView.heightAnchor.constraint(equalToConstant: view.frame.width),
            
            slider.topAnchor.constraint(equalTo: worldView.bottomAnchor, constant: 3),
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            
            startStopGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startStopGameButton.topAnchor.constraint(equalTo: worldView.bottomAnchor, constant: 50),
            startStopGameButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            
            addRandomLifeCellsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            addRandomLifeCellsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addRandomLifeCellsButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.75)
        ])
    }
}

