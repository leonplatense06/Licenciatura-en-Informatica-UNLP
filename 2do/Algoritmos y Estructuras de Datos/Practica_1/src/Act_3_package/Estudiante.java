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
public class Estudiante extends Persona {
    private String com;
    private String dir;
    
    public Estudiante(){
        
    }
    public Estudiante(String nom, String ape, String email, String com, String dir){
        super(nom, ape, email);
        this.com = com;
        this.dir = dir;
    }
    
    public void setCom(String com){
        this.com = com;
    }
    public String getCom(){
        return this.com;
    }
    
    public void setDir(String dir){
        this.dir = dir;
    }
    public String getDir(){
        return this.dir;
    }
    
    @Override
    public String tusDatos(){
        return ("Estudiante.\nApellido y Nombre: " + getApe() + " " + getNom() +
                ".\nEmail: " + getEmail() + ".\nComision: " + getCom() +
                ".\nDireccion: " + getDir() + ".");
    }
}
