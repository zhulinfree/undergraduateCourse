package X.Y;

public class B{
		
public void sayPublic(){
	System.out.println("Hi,"+getClass()+ "."+"public");
}


private void sayPrivate(){
	System.out.println("Hi,"+getClass()+ "."+"private");
}


protected void sayProtected(){
	System.out.println("Hi,"+getClass()+ "."+"protected");
}

void sayDefault(){
	System.out.println("Hi,"+getClass()+ "."+"default");
}


}
