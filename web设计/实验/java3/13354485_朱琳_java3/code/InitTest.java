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
  {                            // �ÿ�(block)���г�ʼ��
    area = Math.PI * radius * radius;
   }
  Circle(String color){
    super(color);              // ���û��๹����(�в���)
    System.out.println("Circle is intialized. Radius = " 
                      + radius + ". Area = " + area);
  }  
 
  void draw(){
    super.draw();		// super���ڵ��û����ͬ������
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