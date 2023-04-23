import UIKit
import SDWebImage

class MainViewController: UIViewController, UIScrollViewDelegate {
   
    var locationModelArray = [LocationModel]()
    var page = 2
    var isLoading = false
    var characterArray: [CharacterData] = []
    var residentUrl: [String] = []
    var choosenCharacter = CharacterData(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: Origin(name: ""), image: "", episode: [""], created: "", location: Location(name: ""))
    var char = [CharacterData(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: Origin(name: ""), image: "", episode: [""], created: "", location: Location(name: ""))]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableViewIndicatorView: UIActivityIndicatorView!
    let characterManager = CharacterManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        let image = UIImage(named: "Rick-and-Morty-removebg-preview")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        tableViewIndicatorView.isHidden = true
        indicatorView.isHidden = true
        getData()
        scrollView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewWidth = scrollView.frame.width
        let contentWidth = scrollView.contentSize.width
        let contentOffset = scrollView.contentOffset.x
        
        if page <= 7 {
            if contentOffset + scrollViewWidth >= contentWidth {
                if !isLoading{
                    page += 1
                    getData()
                }
            }
        }
    }
    
    func getData() {
        indicatorView.isHidden = false
        let url = URL(string: "https://rickandmortyapi.com/api/location?page=\(page)")!
        LocationManager().performRequest(url: url) { locations in
            if let locations = locations {
                for location in locations {
                    let locationModel = LocationModel(locationsName: location.locationsName, locationResidentsUrl: location.locationResidentsUrl)
                    self.locationModelArray.append(locationModel)
                }
                DispatchQueue.main.async {
                    self.createButtons(with: self.locationModelArray)
                    self.isLoading = false
                    self.indicatorView.isHidden = true
                }
            }
        }
    }
    func createButtons(with locationModels: [LocationModel]) {
        let buttonWidth: CGFloat = 300
        let buttonHeight: CGFloat = 50
        var buttonX: CGFloat = 20
        var tag = 0
        
        for locationModel in locationModels {
            let button = UIButton()
            button.setTitle(locationModel.locationsName, for: .normal)
            button.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
            button.frame = CGRect(x: buttonX, y: 20, width: buttonWidth, height: buttonHeight)
            button.backgroundColor = .lightGray
            button.layer.borderWidth = 2
            button.layer.cornerRadius = 10
            button.setTitleColor(.black, for: .normal)
            button.tag = tag
            self.scrollView.addSubview(button)
            buttonX += buttonWidth + 50
            tag += 1
        }
        self.scrollView.contentSize = CGSize(width: buttonX, height: self.scrollView.frame.height)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        tableView.allowsSelection = true
        tableViewIndicatorView.startAnimating()
        tableViewIndicatorView.isHidden = false
        char.removeAll()
        for button in scrollView.subviews where button is UIButton {
            button.backgroundColor = .lightGray
        }
        sender.backgroundColor = .white
        DispatchQueue.main.async { [self] in
            let locationModel = locationModelArray[sender.tag]
            residentUrl = locationModel.locationResidentsUrl
            characterManager.getCharacter(residentUrls: residentUrl) {  characters, error in
                if let characters = characters {
                    self.char = characters
                    self.tableView.reloadData()
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.character = choosenCharacter
        }
    }
}
//MARK: -
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return char.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenCharacter = self.char[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
       
        DispatchQueue.main.async {
            let character = self.char[indexPath.row]
            cell.imageViev.sd_setImage(with: URL(string: character.image))
            let gender = character.gender
            cell.textLabellll.text = character.name
            if indexPath.row % 2 == 1 {
                cell.stackView.semanticContentAttribute = .forceRightToLeft
            } else {
                cell.stackView.semanticContentAttribute = .forceLeftToRight
            }
            if gender == "Male" {
                cell.genderView.image = UIImage(named: "male")
            } else if gender == "Female" {
                cell.genderView.image = UIImage(named: "female")
            } else if gender == "Genderless" {
                cell.genderView.image = UIImage(named: "genderless")
            } else {
                cell.genderView.image = UIImage(named: "question")
            }
        }
        self.tableViewIndicatorView.isHidden = true
        self.tableViewIndicatorView.stopAnimating()
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

