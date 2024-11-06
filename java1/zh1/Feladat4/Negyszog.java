public class Negyszog extends Shape {
	
	private float a;
	private float b;
	private float c;
	private float d;
	
	public Negyszog(float a, float b, float c, float d) {
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}
	public float kerulet() {
		return a + b + c + d;
	}
}