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
public class Test {
    public static void main(String[] args){
        int dimFE = 2;int dimFP = 3;
        Estudiante[] vecEst = new Estudiante[dimFE];
        Profesor[] vecProf = new Profesor[dimFP];
        
        vecEst[0] = new Estudiante();
        vecEst[0].setNom("Raul");vecEst[0].setApe("Crivaro");
        vecEst[0].setCom("1B");vecEst[0].setEmail("raul@gmail.com");
        vecEst[0].setDir("Calle 131");
        
        vecEst[1] = new Estudiante();
        vecEst[1].setNom("Lucía");
        vecEst[1].setApe("Martínez");
        vecEst[1].setCom("1B");
        vecEst[1].setEmail("lucia@gmail.com");
        vecEst[1].setDir("Avenida 456");
        
        for (int i=0;i < 3;i++){
            vecProf[i] = new Profesor();
        }
        
        vecProf[0].setNom("José");
        vecProf[0].setApe("Pérez");
        vecProf[0].setEmail("jose@gmail.com");
        vecProf[0].setCatedra("Matemáticas");
        vecProf[0].setFacultad("Exactas");

        vecProf[1].setNom("Laura");
        vecProf[1].setApe("Rodríguez");
        vecProf[1].setEmail("laura@gmail.com");
        vecProf[1].setCatedra("Literatura");
        vecProf[1].setFacultad("Humanidades");

        vecProf[2].setNom("Martín");
        vecProf[2].setApe("López");
        vecProf[2].setEmail("martin@gmail.com");
        vecProf[2].setCatedra("Historia");
        vecProf[2].setFacultad("Sociales");
        
        System.out.println("Estudiates:");System.out.println("------------------\n");
        for (Estudiante est : vecEst){
            System.out.println(est.tusDatos() + "\n");
        }
        System.out.println("------------------");
        
        System.out.println("\nProfesores:");System.out.println("------------------\n");
        for (Profesor prof : vecProf){
            System.out.println(prof.tusDatos() + "\n");
        }
        System.out.println("------------------");
    }
}
