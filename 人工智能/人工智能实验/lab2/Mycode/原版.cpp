/* Created on: 2015年10月26日
 * Author: 朱琳
 */
#include<bits/stdc++.h>
#include<fstream>
using namespace std;


struct train{
	string train_words[100];//
	int vector[2000];//与不相同的单词
	
	
};
string trains[400][100],tests[3000][100];
string unique_words[100000];


float anger[300], disgust[300], fear[300], joy[300], sad[300], surprise[300];
float t_anger[300], t_disgust[300], t_fear[300], t_joy[300], t_sad[300],t_surprise[300];
int row_of_trains =-1, row_of_tests = -1,numOfUnique=0;

map<string, int> check_map;
map<string, int> map[10000];
char Dataset_words[40] ="E:/Desktop/Lab2/Dataset_words.txt";
char Dataset_words_anger[40] = "E:/Desktop/Lab2/Dataset_words_anger.txt";
char Dataset_words_disgust[50]= "E:/Desktop/Lab2/Dataset_words_disgust.txt";
char Dataset_words_fear[40]= "E:/Desktop/Lab2/Dataset_words_fear.txt";
char Dataset_words_joy[40]= "E:/Desktop/Lab2/Dataset_words_joy.txt";
char Dataset_words_sad[40]= "E:/Desktop/Lab2/Dataset_words_sad.txt";
char Dataset_words_surprise[50]= "E:/Desktop/Lab2/Dataset_words_surprise.txt";


void read(ifstream &fin,char name[]) {//读取文本单词，并生成不重复的单词
	fin.open(name);
	string words;
	int col = 0, flag = 0; //用于区分trains和test
	getline(fin, words); //忽略掉第一行标题行
	while (fin >> words) {
		string tmp = words + "xxxxx"; //防止判断单词长度不够导致bug
		if (tmp.substr(0, 5) == "train" && tmp.substr(5, 1)<="9"&&tmp.substr(5, 1)>"0") {
			flag = 0;
			row_of_trains++;
			col = 0;
		} else if (tmp.substr(0, 4) == "test" && tmp.substr(4, 1)<="9"&&tmp.substr(4, 1)>"0") {
			flag = 1;
			row_of_tests++;
			col = 0;
		} else {
			if (!flag) {
				trains[row_of_trains][col++] = words;
				if(check_map[words]==0){
					check_map[words]=1;
					unique_words[numOfUnique++]=words;
				}else{
					check_map[words]++;
				}
			} else {
				tests[row_of_trains][col++] = words;
			}
		}
	}
	row_of_trains++;
	row_of_tests++;
	cout << "row_of_trains=" << row_of_trains << endl;
	cout << "row_of_tests=" << row_of_tests << endl;
	cout<<"numOfUnique="<<numOfUnique<<endl;
	fin.close();
}

float to_float(string s){
	int x=0;
	x=(int)(s[0]-'0')*1000+(int)(s[1]-'0')*100+(int)(s[2]-'0')*10+(int)(s[3]-'0');
	return x*1.0/10000.0;
}
void read_probability(ifstream &fin,char name[], float a[],int rows) {//读取情感概率
	fin.open(name);
	string sen,tmp;
	getline(fin,sen);

	for(int i=0;i<rows;i++){
		getline(fin,sen);
		tmp=sen.substr(sen.length()-4,4);
		a[i]=to_float(tmp);
		cout<<a[i]<<endl;
	}
	fin.close();
}





void print(){
	for(int row=0;row<row_of_trains;row++){
		int col=0;
		while(trains[row][col]!=""){
			cout<<trains[row][col++]<<" ";
		}
		cout<<endl;
	}
}

int main() {

	ifstream fin;
	read(fin,Dataset_words);
	read_probability(fin,Dataset_words_anger, anger,row_of_trains);
//	read_probability(fin,Dataset_words_disgust,disgust,row_of_trains);
//	read_probability(fin,Dataset_words_fear,fear,row_of_trains);
//	read_probability(fin,Dataset_words_joy, joy,row_of_trains);
//	read_probability(fin,Dataset_words_sad, sad,row_of_trains);
//	read_probability(fin,Dataset_words_surprise,surprise,row_of_trains);





	return 0;
}

