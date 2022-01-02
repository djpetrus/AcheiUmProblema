//
//  ProblemTableViewCell.swift
//  AcheiUmProblema
//
//  Created by Petrus Ribeiro Lima da Costa on 31/12/21.
//

import UIKit

class ProblemTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewProblem: UIImageView!
    @IBOutlet weak var labelNameProblem: UILabel!
    @IBOutlet weak var labelAddresProblem: UILabel!
    @IBOutlet weak var labelDateProblem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(_ problem: Problem) {
        if let image = problem.imagem {
            imageViewProblem.image = UIImage(data: image)
        }
        labelNameProblem.text = problem.nome
        labelAddresProblem.text = problem.endereco
        labelDateProblem.text = problem.data
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
