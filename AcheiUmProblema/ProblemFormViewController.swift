//
//  ProblemFormViewController.swift
//  AcheiUmProblema
//
//  Created by Petrus Ribeiro Lima da Costa on 02/01/22.
//

import UIKit

class ProblemFormViewController: UIViewController {
    
    @IBOutlet weak var textFieldNomeProblema: UITextField!
    @IBOutlet weak var textFieldEndereco: UITextField!
    @IBOutlet weak var textFieldData: UITextField!
    @IBOutlet weak var buttonFoto: UIButton!
    @IBOutlet weak var imageViewFoto: UIImageView!
    @IBOutlet weak var textViewDescricao: UITextView!
    @IBOutlet weak var buttonGravarEditar: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var problem: Problem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.keyboardDismissMode = .interactive
        
        if let problem = problem {
            title = "Alterar o problema"
            textFieldNomeProblema.text = problem.nome
            textFieldEndereco.text = problem.endereco
            textFieldData.text = problem.data
            textViewDescricao.text = problem.descricao
            if let image = problem.imagem {
                imageViewFoto.image = UIImage(data: image)
            }
            buttonGravarEditar.setTitle("Alterar o problema", for: .normal)
        }

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {return}
        scrollView.contentInset.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
    }
    
    @objc
    func keyboardWillHide() {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        super.viewWillAppear(animated)
    }
    
    @IBAction func selectFoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar uma foto",
                                      message: "De onde você deseja escolher a foto?",
                                      preferredStyle: .actionSheet)
        
        // O if a seguir serve para prevenir o código de erros, pois não existe câmera no simulador
        // O código só vai funcionar se uma câmera for localizada
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera",
                                            style: .default) { _ in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos",
                                          style: .default) { _ in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let albumAction = UIAlertAction(title: "Álbum de fotos",
                                          style: .default) { _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(albumAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar",
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker,
                animated: true,
                completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        if problem == nil {
            problem = Problem(context: context)
        }
        
        problem?.nome = textFieldNomeProblema.text
        problem?.endereco = textFieldEndereco.text
        problem?.data = textFieldData.text
        problem?.descricao = textViewDescricao.text
        problem?.imagem = imageViewFoto.image?.jpegData(compressionQuality: 0.9)
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProblemFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageViewFoto.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
