//
//  ViewController.swift
//  GithubDummy
//
//  Created by MacBook AIR on 23/09/2024.
//

import UIKit

class LandingViewController: UIViewController {

  public let nextButton:UIButton = {
    let button = UIButton()
    button.setTitle("Next", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .green
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 4
    button.layer.masksToBounds = true
    return button
  }()

  private let WelcomeLabel :UILabel  = {
    let label = UILabel()
    label.textColor = .label
    label.textAlignment = .center
    label.font =  .systemFont(ofSize: 30, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Welcome 😁"
    label.clipsToBounds = true
    return label
  }()

  public let gifImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .systemBackground
    addSubviews()
    configureActions()
    configureGif()
    configureConstraints()

  }

  private func addSubviews() {
    view.addSubview(WelcomeLabel)
    view.addSubview(gifImageView)
    view.addSubview(nextButton)
  }


  private func configureConstraints() {

    NSLayoutConstraint.activate([
      WelcomeLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 40),
      WelcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      WelcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
      WelcomeLabel.trailingAnchor.constraint(equalTo: view
        .trailingAnchor,constant: -20)
    ])

    NSLayoutConstraint.activate([
      gifImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      gifImageView.heightAnchor.constraint(equalToConstant: 50),
      gifImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 24),
      gifImageView.trailingAnchor.constraint(equalTo: view
        .trailingAnchor,constant: -50)
    ])

    NSLayoutConstraint.activate([
      nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
      nextButton.heightAnchor.constraint(equalToConstant: 50),
      nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 24),
      nextButton.trailingAnchor.constraint(equalTo: view
        .trailingAnchor,constant: -24)
    ])

  }

  private func configureGif() {
    gifImageView.image = UIImage.gifImageWithName("unboarding")
  }


  private func configureActions() {
    nextButton.addTarget(self, action: #selector(navigateToSeedPhaseController), for: .touchUpInside)
  }

  @objc func navigateToSeedPhaseController() {
  HapticManager.shared.vibrate(for: .success)
  let mainTabViewController = MainTabViewController()
  let navController = mainTabViewController
  if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
      let window = sceneDelegate.window {
      window.rootViewController = navController
  }
  }
}

