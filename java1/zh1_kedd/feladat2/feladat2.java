import java.util.*;
import java.io.*;

class feladat2 {
	public static void main(String args[]) {
		Map<String, Integer> shoppingList = new HashMap<String, Integer>();
		shoppingList.put("Alma", 100);
		shoppingList.put("Korte", 200);
		
		try {
			Writer out = new BufferedWriter(new FileWriter("out.txt"));
			
			shoppingList.forEach( (k, v) -> {
				try {
					out.write(k + ": " + v + "\n");
				} catch (IOException e) {
					e.printStackTrace();
				}
			} );
			
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}