/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Act_3_package;

/**
 *
 * @author rama
 */
public abstract class Persona {
    private String nom;
    private String ape;
    private String email;
    
    public Persona(){
        
    }
    public Persona(String nom, String ape, String email){
        this.nom = nom;
        this.ape = ape;
        this.email = email;
    }
    
    public void setNom(String nom){
        this.nom = nom;
    }
    public String getNom(){
        return this.nom;
    }
    
    public void setApe(String ape){
        this.ape = ape;
    }
    public String getApe(){
        return this.ape;
    }
    
    public void setEmail(String email){
        this.email = email;
    }
    public String getEmail(){
        return this.email;
    }
    
    public abstract String tusDatos();
}
