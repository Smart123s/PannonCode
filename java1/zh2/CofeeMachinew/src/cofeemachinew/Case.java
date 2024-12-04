/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cofeemachinew;

/**
 *
 * @author zhuser
 */
public class Case {
    private int level;
    private final int capacity;
    
    public Case(int capacity, int level) {
        this.capacity = capacity;
        this.level = level;
    }
    
    public int getLevel() {
        return level;
    }
    
    public void setLevel(int level) throws IllegalArgumentException {
        if (level > capacity) {
            throw new IllegalArgumentException("The amount specified doesn't fit this case.");
        } else if (level < 0) {
            throw new IllegalArgumentException("The isn't enough substance in this case.");
        }
        this.level = level;
    }
    
    public boolean hasEnough(int level) {
        return this.level > level;
    }
    
    public void subtract(int level) {
        if (!hasEnough(level)) {
            throw new IllegalArgumentException("The isn't enough substance in this case.");
        }
        this.level -= level;
    }
    
    public int getCapacity() {
        return capacity;
    }
}


