import java.util.*;
import  java.util.Random;

class Fruit{

  	public void eat(){ 
  		System.out.println("Eat "+this.getClass());
  	}

  public static void main(String[] args){
  
  		final int COUNT=20;
  		Fruit []f=new Fruit[COUNT];
  		int n=0;
  		for(int i=0;i<COUNT;i++){
  			Random rnd= new Random();
        	int number= rnd.nextInt(3);  
     
  			switch(number){
  				case 0: 					
  					f[n++]=new Fruit();
  					break;
  				case 2:
  					f[n++]=new Apple();
  					break;
  				default:
  					f[n++]=new Orange();
  					break;
  			}
  		}

  		for(Fruit f1:f){
  			f1.eat();
  		}
  }

}

class Orange extends Fruit{
	public void eat(){
		System.out.println("The orange tastes a little sour");
	}
}

class Apple extends Fruit{
}

