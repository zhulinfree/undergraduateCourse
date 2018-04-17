#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
using namespace std;
vector< vector<double> >trainData;
vector< vector<double> >testData;
vector<double>w0;
int times=0;
void read_file(string fileName)
{
	ifstream in(fileName.c_str());
	string everyLine;
	while(!in.eof())
	{
		getline(in,everyLine);
		stringstream s;
		s<<everyLine;
		vector<double>tempData;
		while(!s.eof())
		{
			string sNum;
			s>>sNum;
			if(!s.eof())
			{
				double num;
				stringstream stringTodouble;
				stringTodouble<<sNum;
				stringTodouble>>num;
				tempData.push_back(num);
			}
			else
			{
				if(sNum=="?")
				{
					testData.push_back(tempData);
				}
				else
				{
					double num;
					stringstream stringTodouble;
					stringTodouble<<sNum;
					stringTodouble>>num;
					tempData.push_back(num);
					trainData.push_back(tempData);
				}
			}
		}
	}
}
double sign(double num)
{
	if(num<0)
	return -1;
	else if(num>0)
	return 1;
	else
	return 0;
}
void PLA(vector< vector<double> > data,vector<double>&w)
{
	for(int i=0;i<data.size();i++)
	{
	//	cout<<"in"<<endl;
		double y=0;
		for(int j=0;j<data[i].size()-1;j++)
		{
			y+=data[i][j]*w[j];
		}
		if(sign(y)!=sign(data[i][ data[i].size()-1]))
		{
			cout<<"i "<<i<<endl;
			int k=0;
			for(vector<double>::iterator it=w.begin();it!=w.end();k++,it++)
			{
				*it=*it+sign(data[i][ data[i].size()-1])*data[i][k];
				cout<<*it<<" ";
			}
			cout<<endl;
		//	break;
		/*	times++;
			if(times>1000)
			break;*/
			
			PLA(data,w);
			break;
		}
	}
}
double pre_res(vector<double>data)
{
	double res=0;
	for(int i=0;i<data.size();i++)
	{
		res+=data[i]*w0[i];
	}
	cout<<"res "<<res<<endl;
	return sign(res);
}
void initial()
{
	w0.push_back(1);
	w0.push_back(1);
	w0.push_back(1);
}
int main()
{
	read_file("PLA.txt");
	initial();
	cout<<"Train Data"<<endl;
	for(int i=0;i<trainData.size();i++)
	{
		for(int j=0;j<trainData[i].size();j++)
		{
			cout<<trainData[i][j]<<" ";
		}
		cout<<endl;
	}
	cout<<endl;
	cout<<"Test Data"<<endl;
	for(int i=0;i<testData.size();i++)
	{
		for(int j=0;j<testData[i].size();j++)
		{
			cout<<testData[i][j]<<" ";
		}
		cout<<endl;
	}
	cout<<endl;
	PLA(trainData,w0);
	cout<<endl;
	cout<<"w0"<<endl;
	for(int i=0;i<w0.size();i++)
	{
		cout<<w0[i]<<" ";
	}	
	cout<<endl;
	
	cout<<endl;
	cout<<"result"<<endl;
	for(int i=0;i<testData.size();i++)
	{
		cout<<"test "<<i<<" "<<pre_res(testData[i])<<endl;
	}
	return 0;
}
