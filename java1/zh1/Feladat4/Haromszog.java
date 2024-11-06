public class Haromszog extends Shape {
	
	private float a;
	private float b;
	private float c;
	
	public Haromszog(float a, float b, float c) {
		this.a = a;
		this.b = b;
		this.c = c;
	}
	public float kerulet() {
		return a + b + c;
	}
}