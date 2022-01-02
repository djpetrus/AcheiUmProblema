//
//  ViewController.swift
//  AcheiUmProblema
//
//  Created by Petrus Ribeiro Lima da Costa on 31/12/21.
//

import UIKit

class ProblemViewController: UIViewController {
    
    @IBOutlet weak var imageViewFoto: UIImageView!
    @IBOutlet weak var labelNomeProblema: UILabel!
    @IBOutlet weak var labelEnderecoProblema: UILabel!
    @IBOutlet weak var labelDataProblema: UILabel!
    @IBOutlet weak var textViewDescricaoProblema: UITextView!
    
    var problem: Problem?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let problemFormViewController = segue.destination as? ProblemFormViewController {
            problemFormViewController.problem = problem
        }
    }
    
    func prepareScreen() {
        if let problem = problem {
            if let image = problem.imagem {
                imageViewFoto.image = UIImage(data: image)
            }
            labelNomeProblema.text = problem.nome
            labelEnderecoProblema.text = problem.endereco
            labelDataProblema.text = problem.data
            textViewDescricaoProblema.text = problem.descricao
        }
    }


}

