import java.util.*;
// import java.math.*;

class feladat4 {
	public static void main(String args[]) {
		Random random = new Random();
		
		for (int i = 0; i < 5; i++) {
			long l = random.nextLong(95) + 5 + 1;
			System.out.println(2 * l * Math.PI);	
		}
	}
}