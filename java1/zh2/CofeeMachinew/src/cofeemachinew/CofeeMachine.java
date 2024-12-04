/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cofeemachinew;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author zhuser
 */
public class CofeeMachine {
    private Case cofeeCase = new Case(1000, 500);
    private Case waterCase = new Case(1000, 500);
    private Case milkCase = new Case(1000, 500);
    
    private final Map<CofeeType, Integer> history = new HashMap<CofeeType, Integer>();
    
    public CofeeMachine() {
        history.put(CofeeType.ESPRESSO, 0);
        history.put(CofeeType.LONG, 0);
        history.put(CofeeType.CAPUCCINO, 0);
        history.put(CofeeType.LATTE, 0);
    }
    
    public boolean brew(CofeeType type) {
        int cofeeNeeded = 7;
        int waterNeeded = 0;
        int milkNeeded = 0;
        
        switch (type) {
            case ESPRESSO:
                waterNeeded = 30;
                break;
            case LONG:
                waterNeeded = 60;
                break;
            case CAPUCCINO:
                waterNeeded = 40;
                break;
            case LATTE:
                waterNeeded = 30;
                milkNeeded = 200;
                break;
            default:
                break;
        }
        
        boolean wasEverythingEnough = true;
        if (!cofeeCase.hasEnough(cofeeNeeded)) {
            wasEverythingEnough = false;
            System.out.println("Not enough Cofee in machine. Refilling... Please try again.");
            cofeeCase.setLevel(1000);
        }
        
        if (!waterCase.hasEnough(waterNeeded)) {
            wasEverythingEnough = false;
            System.out.println("Not enough Water in machine. Refilling... Please try again.");
            waterCase.setLevel(1000);
        }

        if (!milkCase.hasEnough(milkNeeded)) {
            wasEverythingEnough = false;
            System.out.println("Not enough Milk in machine. Refilling... Please try again.");
            milkCase.setLevel(1000);
        }
        
        if (!wasEverythingEnough) {
            return false;
        }
        
        cofeeCase.subtract(cofeeNeeded);
        waterCase.subtract(waterNeeded);
        milkCase.subtract(milkNeeded);
        
        addToBrewingHistory(type);
        System.out.println("Brewed Cofee! Enjoy your " + type);
        return true;
        
    }
    
    private void addToBrewingHistory(CofeeType type) {
        Integer current = history.get(type);
        
        // jus tin case, if a new CofeeType has been added, which wasn't initialized
        if (current != null) {
            history.put(type, current + 1);
        } else {
            history.put(type, 1);
        }
    }
    
    public Integer getBrewHistory(CofeeType type) {
        return history.get(type);
    }
    
    public void printLevels() {
        System.out.println("Current levels: (current / max)");
        System.out.println("Cofee level: " + cofeeCase.getLevel() 
                + "mg / " + cofeeCase.getCapacity() + "mg");
        
        System.out.println("Water level: " + waterCase.getLevel() 
                + "ml / " + waterCase.getCapacity() + "ml");
        
        System.out.println("Milk level: "  + milkCase.getLevel()  
                + "ml / " + milkCase.getCapacity() + "ml\n");
    }
    
    public void printHistory(){
        System.out.println("Brewing history (not in the same order as the menu!): ");
        history.forEach((k, v) -> {
            System.out.println(k + ": " + v);
        });
    }
    
}
