#include<iostream>
#include<bits/stdc++.h>
#include<map>

using namespace std;

void clearMap(map<string,int> &map,string *words,int count){
	for(int i=0;i<count;i++)
	map[words[i]]=0;
}

string checkString(string words){
	if(words=="ѵ���ı�1"
	||words=="ѵ���ı�2"||words=="ѵ���ı�3"
	||words=="ѵ���ı�4"||words=="ѵ���ı�5"
	||words=="ѵ���ı�6"||words=="ѵ���ı�7"
	||words=="ѵ���ı�8"||words=="ѵ���ı�9"
	||words=="ѵ���ı�10")
	return "title1";
	
	if(words=="�����ı�1"
	||words=="�����ı�2"||words=="�����ı�3"
	||words=="�����ı�4"||words=="�����ı�5"
	||words=="�����ı�6"||words=="�����ı�7"
	||words=="�����ı�8"||words=="�����ı�9"
	||words=="�����ı�10") 
	return "title2"; 
	
	if(words=="�ı����"||words=="���б��Կո�ָ���") 
	return "title3";
		
}

int main(){
	
	int count_all=0,count_noRepeat=0;
	map<string,int> map;
	fstream fin;
	fin.open("Dataset_words.txt");
	if(fin==NULL) cout<<"can not read!"<<endl; 
	string words[300],no_repeat_words[300];
	
	while(fin>>words[count_all++]);
	fin.close();
	cout<<"all="<<count_all<<endl;
	
	clearMap(map,words,count_all);
	
	for(int j=2;j<count_all;j++){
		string check=checkString(words[j])
		if(check!="title1"&&check!="title2"&&check!="title3"&&map[words[j]]==0){
			no_repeat_words[count_noRepeat++]=words[j];
			map[words[j]]=1;
		}
//		else{
//			cout<<"illegle="<<checkString(words[j])<<endl;
//			cout<<"j="<<j<<endl;
//		}

		//cout<<words[j]<<" "; 
	}
	cout<<"no_repeat="<<count_noRepeat<<endl;
	for(int i=0;i<count_noRepeat;i++){
		cout<<no_repeat_words[i]<<"  ";
	}
	cout<<endl;

	
	
	/*fstream fout;
	fout.open("out.txt");
	for(int i=0;i<count;i++){
		fout<<no_repeat_words[i]<<" ";
	}
	fout.close();	
	cout<<"File writting over"<<endl;*/
	
//	clearMap(map,words,countWords);
//	int start=2;
//	for(int i=2;i<countWords-1;i++){
//		
//		if(checkString(words[i])=="title1"||checkString(words[i])=="title2"){
//			cout<<words[i]<<"=";
//			start=i;
//		}
//		else if(checkString(words[i+1])=="title1"||checkString(words[i+1])=="title2"){
//			//cout<<map[words[i]]<<",";
//			for(int j=start;j<i;j++){
//				cout<<map[words[j]]<<",";
//			}
//			cout<<map[words[i]]<<")"<<endl;;
//			
//		}else{
//			//cout<<map[words[i]]<<")"<<endl;
//			map[words[i]]++;
//		}
//		cout<<map[words[i]]<<" ";
//	}
	
	
	return 0;
}
