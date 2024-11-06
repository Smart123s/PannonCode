public class Kor extends Shape {
	
	private float r;
	
	public Kor(float r) {
		this.r = r;
	}
	public float kerulet() {
		return 2 * r * (float) Math.PI;
	}
}