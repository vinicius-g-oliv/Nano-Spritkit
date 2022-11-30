//
//  Dados.swift
//  ProjetoSpritKit iOS
//
//  Created by Vinicius on 30/11/22.
//

import Foundation



class Dados {
    
    public var Creditos: Int?
    public var Recorde: Double?
    
     
    public func carregarDados(){
        let dadosCarregar : [String:String] = UserDefaults.standard.dictionary(forKey: "Dados") as! [String : String]
        
        self.Creditos = Int(dadosCarregar["Creditos"]!)
        self.Recorde  = Double(dadosCarregar["Recorde"]!)
       
    }
    
    public func salvarDados(){
        let dadosSalvar : [String:String] = ["Creditos": String(self.Creditos!), "Recorde": String(self.Recorde!)]
        
        UserDefaults.standard.set(dadosSalvar, forKey: "Dados")
    }
    
}
