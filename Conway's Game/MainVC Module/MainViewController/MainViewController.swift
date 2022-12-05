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
    private var statesViewController: MainViewControllerState = .addedRandomLifeCells {
        didSet {
            updateViewController()
        }
    }
    
    
    //MARK: - UI Elements
    private let worldView = WorldView()
    private let gameManagementInterface = GameManagementInterfaceView()
    
    //MARK: - ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        addViews()
        setConstraints()
    }
    
    
    //MARK: - Logic of UI Elements
    private func addTargets() {
        gameManagementInterface.startOrStopGameButton.addTarget(self, action: #selector(startStopGame), for: [.touchUpInside, .touchUpOutside])
        gameManagementInterface.addRandomLifeCellsButton.addTarget(self, action: #selector(addRandomLifeCells), for: [.touchUpInside, .touchUpOutside])
        gameManagementInterface.worldSizeSlider.addTarget(self, action: #selector(worldAreaSliderWasChanged), for: [.valueChanged])
        gameManagementInterface.worldSizeSlider.addTarget(self, action: #selector(worldAreaSliderTouchUp), for: [.touchUpInside, .touchUpOutside])
        gameManagementInterface.countRandomLifeCellsSlider.addTarget(self, action: #selector(coefficientRandomLifeCellsSliderTouchUp), for: [.touchUpInside, .touchUpOutside])
        gameManagementInterface.animationSpeedSlider.addTarget(self, action: #selector(coefficientAnimatingSpeedSliderTouchUp), for: [.touchUpInside, .touchUpOutside])

    }
    
    @objc func startStopGame() {
        viewModel.changeStatusGame()
    }
    
    @objc private func addRandomLifeCells() {
        viewModel.placeRandomLifeCell()
    }
    
    @objc private func worldAreaSliderWasChanged(_ sender: UISlider) {
        viewModel.valueChangedAreaSize(toSize: sender.value)
    }
    
    @objc private func worldAreaSliderTouchUp(_ sender: UISlider) {
        viewModel.finishChangeAreaSize(toSize: Int(sender.value))
        gameManagementInterface.centerWorldSizeSliderLabel.text = "\(Int(sender.value))"
    }
    
    @objc private func coefficientRandomLifeCellsSliderTouchUp(_ sender: UISlider) {
        viewModel.changeRandomLifeCellsCoefficient(coefficient: sender.value)
    }
    
    @objc private func coefficientAnimatingSpeedSliderTouchUp(_ sender: UISlider) {
        viewModel.changeAnimationSpeedCoefficient(coefficient: sender.value)
    }
    
    private func setBindings() {
        viewModel.updatedDataToWorld = { data in
            self.worldView.dataToPresent = data
        }
        viewModel.updateMainVC = { data in
            self.statesViewController = data
        }
    }
    
    private func showStopGameAlertController() {
        let ac = UIAlertController(title: "Игра завершена", message: "Появилась стабильная комбинация. Дальнейшее выполнение не даст новых сочетаний", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel, handler: { _ in
            self.dismiss(animated: true)
        })
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    private func updateViewController() {
        switch statesViewController {
        case .startedGame:
            gameManagementInterface.disableElements()
        case .stopedGame:
            gameManagementInterface.enableElements()
        case .addedRandomLifeCells:
            gameManagementInterface.startOrStopGameButton.setTitle("Запустить игру", for: .normal)
        case .wasChangedWorldAreaSizeSlider(let newValue):
            gameManagementInterface.centerWorldSizeSliderLabel.text = "\(Int(newValue))"
        case .showAlertOfEndGame:
            showStopGameAlertController()
        }
    }
    
    
    //MARK: - Setting UI Elements
    private func addViews() {
        view.addSubview(worldView)
        view.addSubview(gameManagementInterface)
    }
    
    private func setViews() {
        view.backgroundColor = .white
        worldView.translatesAutoresizingMaskIntoConstraints = false
        gameManagementInterface.translatesAutoresizingMaskIntoConstraints = false
        
        viewModel = MainWorldViewViewModel()
        addTargets()
        setBindings()
        viewModel.placeRandomLifeCell()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            worldView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            worldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            worldView.widthAnchor.constraint(equalToConstant: view.frame.width),
            worldView.heightAnchor.constraint(equalToConstant: view.frame.width),
            
            gameManagementInterface.topAnchor.constraint(equalTo: worldView.bottomAnchor),
            gameManagementInterface.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gameManagementInterface.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            gameManagementInterface.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

