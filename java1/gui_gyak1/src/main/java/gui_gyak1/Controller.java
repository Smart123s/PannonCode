/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package gui_gyak1;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tombo
 */
public class Controller {
    
    private List<String> songList;
    
    public Controller() {
        songList = new ArrayList<>();
        songList.add("Songg");
        songList.add("Zene");
        songList.add("Cene");
    }
    
    List<String> getSongList() {
        return songList;
    }
    
}
