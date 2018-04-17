//Fib.java
public class Fib{
	public static void main(String args[]){
		final int COUNT=40;
		int fibs[]=new int[COUNT];
		double nums[]=new double[COUNT-1];
		fibs[0]=0;
		fibs[1]=1;
		int i=2;
		while(i<COUNT){
			fibs[i]=fibs[i-1]+fibs[i-2];		
			i++;
		}
		for(int j=0;j<COUNT-1;j++){
			nums[j]=fibs[j]*1.0/(fibs[j+1]*1.0);
		}
		for(double num:nums){
			System.out.println(num);
		}
	}
}