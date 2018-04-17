package QueryStuMem;
class Student {
	private int id;
	private String num;
	private String name;

	int getId() {
		return this.id;
	}

	String getNum() {
		return this.num;
	}

	String getName() {
		return this.name;
	}
	Student(int id, String num, String name) {
		this.id=id;
		this.num=num;
		this.name=name;
	}
}
