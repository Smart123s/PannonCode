public class Feladat4 {
	public static void main(String args[]){
		Shape kor = new Kor(2);
		System.out.println(kor.kerulet());
		
		Shape haromszog = new Haromszog(2, 3, 4);
		System.out.println(haromszog.kerulet());
		
		Shape negyszog = new Negyszog(2, 3, 4, 5);
		System.out.println(negyszog.kerulet());
	}
}