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
public class Profesor extends Persona {
    private String catedra;
    private String facultad;

    public Profesor(){
        
    }
    
    public Profesor(String nom, String ape, String email, String catedra, String facultad) {
        super(nom, ape, email);
        this.catedra = catedra;
        this.facultad = facultad;
    }

    public String getCatedra() {
        return catedra;
    }
    public void setCatedra(String catedra) {
        this.catedra = catedra;
    }

    public String getFacultad() {
        return facultad;
    }
    public void setFacultad(String facultad) {
        this.facultad = facultad;
    }
    
    @Override
    public String tusDatos(){
        return ("Profesor.\nApellido y Nombre: " + getApe()+ " " + getNom() +
                ".\nEmail: " + getEmail() + ".\nCatedra: " + getCatedra() +
                ".\nFacultad: " + getFacultad() + ".");
    }
}
