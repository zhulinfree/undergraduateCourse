#include<bits/stdc++.h>

using namespace std;
map<string,int> m;
int main(){
	string s="xx";
	m[s]=1;
	string x="xxx";
	//cout<<m[x]<<endl;
	if(m[x]==NULL) m[x]++;
	cout<<m[x];
	return 0;
} 
