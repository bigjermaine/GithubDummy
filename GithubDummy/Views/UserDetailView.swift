//
//  UaerDetailView.swift
//  GithubDummy
//
//  Created by MacBook AIR on 25/09/2024.
//

import Foundation
import UIKit

class UserDetailsView: UIView {

    private let companyLabel = UILabel()
    private let blogLabel = UILabel()
    private let locationLabel = UILabel()
    private let emailLabel = UILabel()
    private let hireableLabel = UILabel()
    private let bioLabel = UILabel()
    private let twitterLabel = UILabel()
    private let reposLabel = UILabel()
    private let gistsLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        // Customize labels
        [companyLabel, blogLabel, locationLabel, emailLabel, hireableLabel, bioLabel, twitterLabel, reposLabel, gistsLabel].forEach {
            $0.numberOfLines = 0
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            companyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            companyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            companyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            blogLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            blogLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            blogLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            locationLabel.topAnchor.constraint(equalTo: blogLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            emailLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            hireableLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            hireableLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            hireableLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            bioLabel.topAnchor.constraint(equalTo: hireableLabel.bottomAnchor, constant: 10),
            bioLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            bioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            twitterLabel.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 10),
            twitterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            twitterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            reposLabel.topAnchor.constraint(equalTo: twitterLabel.bottomAnchor, constant: 10),
            reposLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            reposLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            gistsLabel.topAnchor.constraint(equalTo: reposLabel.bottomAnchor, constant: 10),
            gistsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            gistsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            gistsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10) // Ensure proper bottom constraint
        ])
    }

    func configure(with userDetail: User) {
        companyLabel.text = "Company: \(userDetail.company ?? "N/A")"
        blogLabel.text = "Blog: \(userDetail.blog ?? "N/A")"
        locationLabel.text = "Location: \(userDetail.location ?? "N/A")"
        emailLabel.text = "Email: \(userDetail.email ?? "N/A")"
        hireableLabel.text = "Hireable: \(userDetail.hireable == true ? "Yes" : "No")"
        bioLabel.text = "Bio: \(userDetail.bio ?? "N/A")"
        twitterLabel.text = "Twitter: \(userDetail.twitterUsername ?? "N/A")"
        reposLabel.text = "Public Repos: \(userDetail.publicRepos ?? 0)"
        gistsLabel.text = "Public Gists: \(userDetail.publicGists ?? 0)"
    }
}
