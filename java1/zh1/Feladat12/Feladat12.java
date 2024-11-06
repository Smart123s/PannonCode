import java.io.*;

public class Feladat12 {
	public static void main(String args[]){
		System.out.println("Feladat 1 és feladat2");
		BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
		System.out.println("Darabszám: ");
		
		// Beton beton = new Beton(1, 2, 3, 2);
		try {
			float totalWeight = 0;
			int count = Integer.parseInt(reader.readLine());
			Beton b[] = new Beton[count];
			for (int i = 0; i < count; i++) {
				System.out.println("Beton " + (i + 1) + ". X oldal: ");
				float sizeX = Float.parseFloat(reader.readLine());
				System.out.println("Beton " + (i + 1) + ". Y oldal: ");
				float sizeY = Float.parseFloat(reader.readLine());
				System.out.println("Beton " + (i + 1) + ". Z oldal: ");
				float sizeZ = Float.parseFloat(reader.readLine());
				// amúgy nem lenne muszáj tárolni, de megmutatom, hogy ezt is tudom :)
				b[i] = new Beton(sizeX, sizeY, sizeZ, 2);
				totalWeight += b[i].weight();
			}
			System.out.println("Össztömeg: " + totalWeight);
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
