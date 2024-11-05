class feladat1 {
	public static void main(String[] args) {
		Employee a = new Employee("Jani", "2200.01.01", "Tanár", "Pannon Egyetem");
		System.out.println("Name " + a.getName());
		System.out.println("Birthday " + a.getBday());
		System.out.println("Job " + a.getJob());
		System.out.println("Workplace" + a.getWorkplace());
	}
}

class Person {
	private String name;
	private String bday;
	
	public Person(String name, String bday) {
		this.name = name;
		this.bday = bday;
	}
	
	public String getName() {
		return name;
	}
	
	public String getBday() {
		return bday;
	}
}

class Employee extends Person {
	private String job;
	private String workplace;
	
	public Employee(String name, String bday, String job, String workplace) {
		super(name, bday);
		this.job = job;
		this.workplace = workplace;
	}
	
	public String getJob() {
		return job;
	}
	
	public String getWorkplace() {
		return workplace;
	}
}
