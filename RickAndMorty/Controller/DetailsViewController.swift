//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by Mac on 17.04.2023.
//

import UIKit

class DetailsViewController: UIViewController {
   
    @IBOutlet weak var stackViewOne: UIStackView!
    
    @IBOutlet weak var stackViewSeven: UIStackView!
    @IBOutlet weak var stackViewFive: UIStackView!
    @IBOutlet weak var stackViewFour: UIStackView!
    @IBOutlet weak var stackViewThree: UIStackView!
    @IBOutlet weak var stackViewTwo: UIStackView!
    @IBOutlet weak var stackViewSix: UIStackView!
    @IBOutlet weak var views: UIView!
    
    @IBOutlet weak var uiView: UIView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var specyLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var episodesLabel: UILabel!
    @IBOutlet var createdLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    var character = CharacterData(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: Origin(name: ""), image: "", episode: [], created: "", location: Location(name: ""))
    let scrollView = UIScrollView()
    
    
    override func viewDidLoad() {
        views.layer.cornerRadius = 12
        let stackViews = [stackViewOne, stackViewTwo, stackViewThree, stackViewFour, stackViewFive, stackViewSix, stackViewSeven]
        super.viewDidLoad()
        uploadData()
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 20
        for stackView in stackViews {
            stackView?.layer.cornerRadius = 12
        }
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        uiView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(uiView)

        NSLayoutConstraint.activate([
            uiView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            uiView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            uiView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            uiView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            uiView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func uploadData(){
        
        self.imageView.sd_setImage(with: URL(string: character.image))
        navigationItem.title = character.name
        self.locationLabel.text = character.location.name
        self.statusLabel.text = character.status
        self.specyLabel.text = character.species
        self.genderLabel.text = character.gender
        self.originLabel.text = character.origin.name
        let episodes = character.episode
        var episodeArray: [String] = []
        for episode in episodes {
            let episodeUrl = URL(string: episode)
            if let episodeId = episodeUrl?.lastPathComponent{
                episodeArray.append(episodeId)
                self.episodesLabel.text = episodeArray.joined(separator: ", ")
            }
        }
        self.createdLabel.text = character.created
    }
}
