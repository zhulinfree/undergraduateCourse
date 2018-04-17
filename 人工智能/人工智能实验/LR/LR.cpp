#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <cmath>
using namespace std;
vector< vector<double> >trainData;
vector< vector<double> >testData;
vector<double>w0;
int times;
double step;
void initial()
{
	w0.push_back(1);
	w0.push_back(1);
	w0.push_back(1);
	times=0;
	step=0.01;
}
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
void LR(vector< vector<double> >data,vector<double>&w)
{
	double error[w.size()];
	for(int i=0;i<w.size();i++)
	{
		error[i]=0;
	}
	for(int i=0;i<data.size();i++)
	{
		double wx=0;
		for(int j=0;j<data[i].size()-1;j++)
		{
			wx+=w[j]*data[i][j];
		}
		double e=exp(wx)/(1+exp(wx))-data[i][ data[i].size()-1];
		for(int j=0;j<data[i].size()-1;j++)
		{
			error[j]+=e*data[i][j];
		}
	}
	int k=0;
	for(vector<double>::iterator it=w.begin();it!=w.end();k++,it++)
	{
		*it=*it-step*error[k];
	}
	if(times<500)
	{
		cout<<"times "<<times<<endl;
		times++;
		LR(data,w);
	}
}
double pre_res(vector<double>data)
{
	double res=0;
	for(int i=0;i<data.size();i++)
	{
		res+=data[i]*w0[i];
	}
	double p_res=exp(res)/(1+exp(res));
	cout<<"p_res "<<p_res<<endl;
	if(p_res>=0.5)
	return 1;
	else
	return 0;
}
int main()
{
	read_file("LR.txt");
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
	initial();
	LR(trainData,w0);
	for(int i=0;i<testData.size();i++)
	{
		cout<<"test "<<i<<" "<<pre_res(testData[i])<<endl;
	}
	return 0;
}
