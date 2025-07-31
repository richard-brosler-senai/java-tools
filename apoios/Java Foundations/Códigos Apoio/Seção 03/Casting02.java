public class Casting02 {
    public static void main(String[] args) {
                
        //World population today
        long currentWorldPop = 7_000_000_000;
        System.out.println("Current World Population: " +currentWorldPop);
        
        //World population in 1950,  Source: United Nations Population Division
        //2.52 Billion
        int africaPop   =   221_000_000;
        int asiaPop     = 1_402_000_000;
        int europePop   =   547_000_000;
        int americasPop =   339_000_000;
        int oceanaPop   =    13_000_000;
        System.out.println("World Population in 1950: " 
                +africaPop +asiaPop +europePop +americasPop +oceanaPop);
        
        //The current population of Asia is an estimated 60% of the world population
        double percentAsia = 0.6;
        long currentAsiaPop = currentWorldPop * percentAsia;
        System.out.println("Current Asia Population: " +currentAsiaPop);      
       
    }  
}
