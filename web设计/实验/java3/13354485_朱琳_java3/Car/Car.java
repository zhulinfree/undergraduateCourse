
public class Car {
	String model;
	Wheel wheels[]=new Wheel[4];
	Engine engine=new Engine();
	
	public static void main(String args[]){
		Car car=new Car();
		car.start();
		car.changeWheel(0,"Michelin");
		car.changeWheel(1,"Michelin");
		car.changeWheel(2,"Michelin");
		car.model="Mercedes-Benz";
		car.engine.type="Model S";
		car.start();
	}	
	Car(){
		engine.type="Model L";
		for(int i=0;i<4;i++){
			wheels[i]=new Wheel();
			wheels[i].index=i+1;
			wheels[i].type="BridgeStone";
		}
		this.model="BMW";
	}
	private void changeWheel(int index,String _type){
		this.wheels[index].type=_type;
	}	
	private void start(){
		System.out.println("Car("+model+") is firing!");
		engine.start();
		for(int i=0;i<4;i++){
			wheels[i].roll();
		}
		System.out.println("Car("+model+") is running!");
		System.out.println("=============================\n");
	}
}
