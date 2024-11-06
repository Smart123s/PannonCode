import java.util.*;

public class Feladat3 {
	private static final int LEN = 4;
	public static void main(String args[]){
		String ar[] = new String[LEN];
		ar[0] = "Java";
		ar[1] = "Object";
		ar[2] = "Class";
		ar[3] = "Compiler";
		
		for (int i = 0; i < LEN; i++){
			// remélem jó, ha 0. elmet veszem párosnak
			// ha ember értelemben kéne, hogy az első elem a Java, akkor pont fordítva :)
			if (i % 2 == 0) {
				System.out.println(i + ". elem (paros): " + ar[i].toUpperCase());
			} else {
				System.out.println(i + ". elem (paratlan): " + ar[i].toLowerCase());
			}
		}
		
		System.out.println("Rendezve");
		Arrays.sort(ar);
		for (int i = 0; i < LEN; i++){
			System.out.println(i + ". elem: " + ar[i]);
		}
	}
}