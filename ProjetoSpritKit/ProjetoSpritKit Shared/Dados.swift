//
//  Dados.swift
//  ProjetoSpritKit iOS
//
//  Created by Vinicius on 30/11/22.
//

import Foundation



class Dados {
    
    public var Recorde: Double?
    
     
    public func carregarDados(){
        let dadosCarregar : Double = UserDefaults.standard.double(forKey: "Dados")
        
        self.Recorde  = dadosCarregar
       
    }
    
    public func salvarDados(){
        let dadosSalvar : Double = self.Recorde!
        UserDefaults.standard.set(dadosSalvar, forKey: "Dados")
    }
    
}
