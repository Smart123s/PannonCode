/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cofeemachinew;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

/**
 *
 * @author zhuser
 */
public class CofeeMachinew {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        System.out.println("Welcome to the Ultimate Java Cofee Machine!\n");
        CofeeMachine machine = new CofeeMachine();
        
        // Csak azért is megmutatom a Scannert is ...
        // Tudom, hogy lassabb, mint a BufferedReader
        // Scanner scanner = new Scanner(System.in);
        
        // De vannak benne ilyen fancy funkciók, mint pl
        // String inp = scanner.nextInt();
        
        printHelp();
        
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {            
            // lehetne do whiel is, de azt nme szeretem :(
            while (true) {
            System.out.println("What would you like to brew today?");            
            System.out.print("Type 6 for help\nYour choice: ");
            
            String inp = reader.readLine();
            
            System.out.println("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
            
            // csak hogy string->int conversion is legyen
            int inpVal;
            
            try {
                inpVal = Integer.parseInt(inp);
            } catch (NumberFormatException ex) {
                // ex.printStackTrace();
                System.out.println("This is not a number!");
                continue;
            }
            
            // nem  legszebb, hogy ez alatt van egy switch, de
            // case-ből nem tudok whlie(true)-t breakelni, tehát
            // ígyis-úgyis kéne egy if valahova
            // így legalább picit olvashatóbb
            if (inpVal == 9) {
                System.out.println("Thank you, and have a Nice Day!");
                break;
            }
            
            CofeeType type = null;
            switch (inpVal) {
                case 7:
                    machine.printLevels();
                    continue;
                case 8:
                    machine.printHistory();
                    continue;
                case 6:
                    printHelp();
                    continue;
                case 5:
                    System.out.println("418 I'm a teapot!");
                    continue;
                case 1:
                    type = CofeeType.ESPRESSO;
                    break;
                case 2:
                    type = CofeeType.LONG;
                    break;
                case 3:
                    type = CofeeType.CAPUCCINO;
                    break;
                case 4:
                    type = CofeeType.LATTE;
                    break;
                default:
                    System.out.println("Invalid selection");
                    continue;
            }
            
            machine.brew(type);
            }

            
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public static void printHelp() {
        System.out.println("Type 1 to brew ESPRESSO cafee \n" +
                "Type 2 to brew LONG cafee\n" +
                "Type 3 to brew CAPUCCINO cafee\n" +
                "Type 4 to brew LATTE cafee\n\n" + 
                "Type 5 to ask the teapot to brew cofee (this is a joke and an extra function)\n" +
                "Type 6 for help\n" +
                "Type 7 to print current levels\n" + 
                "Type 8 to print brewing history\n" +
                "Type 9 to exit\n");
    }
    
}
