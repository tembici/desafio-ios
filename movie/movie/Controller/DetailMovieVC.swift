//
//  DetailMovieVC.swift
//  movie
//
//  Created by ely.assumpcao.ndiaye on 23/05/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit
import CoreData


class DetailMovieVC: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var dateMovie: UILabel!
    @IBOutlet weak var genersTxt: UILabel!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var titulo: String!
    var descricao: String!
    var imagem: String!
    var dataMovie: String!
    var genero: String!
    
    var status: Bool!
    
    func initData(title: String, description: String, image: String, date: String, geners: String) {
        self.titulo = title
        self.descricao = description
        self.imagem = image
        self.dataMovie = date
        self.genero = geners
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleMovie.text = titulo
        genersTxt.text = genero
        dateMovie.text = dataMovie
        genersTxt.text = genero
        descriptionTxt.text = descricao
        
        status = false
        
        let pathImage = String(imagem) ?? ""
        let Image = "\(URL_IMG)\(pathImage)" ?? ""
        let url = URL(string: Image)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            movieImage.image = UIImage(data: imageData)
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        
        self.save { (complete) in
            if complete {
                favoriteBtn.isSelected = true
                let xibAddFavoriteVC = XibAddFavotireVC()
                xibAddFavoriteVC.modalPresentationStyle = .custom
                present(xibAddFavoriteVC, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let movie = MovieEntity(context: managedContext)
        
        movie.movieDescription = descricao
        movie.movieTitle = titulo
        movie.movieDate = dataMovie
        movie.movieImage = imagem
        
        do {
            try managedContext.save()
            print("Successfully saved data.")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
             self.EmptyTextField(text: "Pay Atention", message: error.localizedDescription)
            completion(false)
        }
    }
    
    func EmptyTextField(text: String, message: String?){
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true) }
    
}
