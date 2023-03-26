//
//  ViewController.swift
//  Simpsons Quote
//
//  Created by serif mete on 19.03.2023.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire

final class ViewController: UIViewController {

    //MARK: - MyVarabile
    private var simpsonİmg: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var quoteLabel: UILabel = UILabel()
    private var quoteNameLabel: UILabel = UILabel()
    private var button: UIButton = UIButton()
    private var simpsonsQuote: [Quote] = []
    
    //MARK: - MyFunc
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        allVarabileConfigure()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchitem()
    }
    
    private func allVarabileConfigure() {
        view.addSubview(titleLabel)
        view.addSubview(quoteNameLabel)
        view.addSubview(button)
        view.addSubview(simpsonİmg)
        view.addSubview(quoteLabel)
        allVarabileDrawDesing()
        makeQuoteNameLabel()
        makeTitleLabel()
        makebutton()
        makeİmg()
        makeQuoteLabel()
    }
    private func allVarabileDrawDesing(){
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        DispatchQueue.main.async {
            self.simpsonİmg.image = UIImage(named: "logo")
            self.simpsonİmg.contentMode = .scaleAspectFit
            self.titleLabel.text = "Random Simpsons Quote's"
            self.titleLabel.font = .boldSystemFont(ofSize: 35)
            self.titleLabel.numberOfLines = 0
            self.titleLabel.textAlignment = .center
            self.quoteNameLabel.text = ""
            self.quoteNameLabel.font = .boldSystemFont(ofSize: 22)
            self.quoteLabel.text = "Touch The Button"
            self.quoteLabel.numberOfLines = 0
            self.quoteLabel.lineBreakMode = .byTruncatingTail
            self.quoteLabel.font = .boldSystemFont(ofSize: 18)
            self.button.setTitle("Tap", for: .normal)
            self.button.backgroundColor = .blue
        }
        
    }
    @objc func buttonTap() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .brown
            self.quoteNameLabel.text = self.simpsonsQuote.first?.character
            self.quoteLabel.text = "'\(self.simpsonsQuote.first?.quote ?? "")'"
        let url = URL(string: (self.simpsonsQuote.first?.image)!)
            self.simpsonİmg.kf.setImage(with: url)
        }
        fetchitem()
    }
   private func fetchitem() {
        fetchAllData{ [weak self] (response) in
            self?.simpsonsQuote = response ?? []
        }
    }
}

//MARK: - AF Controller
extension ViewController {
   private func fetchAllData(response: @escaping ([Quote]?) -> Void) {
        AF.request("https://thesimpsonsquoteapi.glitch.me/quotes").responseDecodable(of: [Quote].self) {
            (model) in
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data)
        }
    }
}


//MARK: - SnapKit Make Variable
extension ViewController {
    private func makeİmg() {
        simpsonİmg.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.bottom.equalTo(view.snp_centerYWithinMargins).offset(-20)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
        }
    }
    private func makeTitleLabel() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    private func makeQuoteLabel(){
        quoteLabel.snp.makeConstraints { (make) in
            make.top.equalTo(quoteNameLabel).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview().offset(130)
        }
    }
    
    private func makeQuoteNameLabel() {
        quoteNameLabel.snp.makeConstraints { (make) in
            make.height.equalToSuperview().offset(80)
            make.left.right.equalToSuperview().offset(5)
            make.centerY.equalToSuperview().offset(80)
        }
    }
    
    private func makebutton() {
        button.frame.size.width = 200
        button.frame.size.height = 50
        button.layer.cornerRadius = 25
        button.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-60)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview().offset(-50)
        }
        
    }
    
}
