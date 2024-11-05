import java.io.*;
import java.util.*;

public class ComparatorExample {
    public static void main (String[] args) {
        try{
        System.out.println("1. +\n2. -\n3. *\n4. /\n\n");
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int choice = Integer.parseInt(reader.readLine());
        System.out.println("Ket szam:");
        //int numOne = Integer.parseInt(reader.readLine());
        //int numTwo = Integer.parseInt(reader.readLine());
        List<Integer> nums = new ArrayList<Integer>();        
        nums.add(Integer.parseInt(reader.readLine()));
        nums.add(Integer.parseInt(reader.readLine()));
        //Collections.sort(nums);
        Collections.sort(nums, new IntComparator());
        // System.out.println(nums.get(0));
        int result = 00;
        switch(choice) {
                case 1: result = nums.get(0) + nums.get(1); break;
                case 2: result = nums.get(0) - nums.get(1); break;
                case 3: result = nums.get(0) * nums.get(1); break;
                case 4: result = nums.get(0) / nums.get(1); break;
                default: break;
            }
        System.out.println(result);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
}

    class IntComparator implements Comparator<Integer>{
        public int compare(Integer a, Integer b) {
            return b - a;
        }
    }