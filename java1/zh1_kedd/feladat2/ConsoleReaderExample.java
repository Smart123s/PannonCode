import java.util.*;
import java.io.*;

class ConsoleReaderExample {
	public static void main(String args[]) {
		Map<String, Integer> shoppingList = new HashMap<String, Integer>();
		
		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
			
			while (true) {
				String line = reader.readLine();
				if (line.startsWith("*")) {
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