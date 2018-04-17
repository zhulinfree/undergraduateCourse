class Shape{
  String color = "black";
  Shape(){
    System.out.println("Shape color is "+color);
  }
  Shape(String color){
    this.color = color;
    System.out.println("Shape color is " + color);
  }
  void draw(){
    System.out.println("Shape is drawn!");
  }
}

class Circle extends Shape{
  int radius=10;
  double area;
  {                            // 用块(block)进行初始化
    area = Math.PI * radius * radius;
   }
  Circle(String color){
    super(color);              // 调用基类构造器(有参数)
    System.out.println("Circle is intialized. Radius = " 
                      + radius + ". Area = " + area);
  }  
 
  void draw(){
    super.draw();		// super用于调用基类的同名方法
    System.out.println("Circle is drawn!");
  }
}

public class InitTest {
  InitTest(){
     Circle circle = new Circle("red");
     circle.draw();
  }
  public static void main(String[] args){
     InitTest init = new InitTest();
     System.out.println("finish!");        
  }
}