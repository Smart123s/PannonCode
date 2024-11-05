import java.util.*;
import java.io.*;

class ReaderExample {
	public static void main(String args[]) {
		Map<String, Integer> shoppingList = new HashMap<String, Integer>();
		
		try {
			BufferedReader reader = new BufferedReader(new FileReader("out.txt"));
			
			while (true) {
				String line = reader.readLine();
				if (line == null) {
					break;
				}
				
				String ls[] = line.split(": ");
				shoppingList.put(ls[0], Integer.parseInt(ls[1]));
				System.out.println(ls[0] + ": " + shoppingList.get(ls[0]));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}