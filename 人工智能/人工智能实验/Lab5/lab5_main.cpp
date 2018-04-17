/* Created on: 2015��10��26��
 * Author: ����
 */
#include<bits/stdc++.h>
#include<fstream>
using namespace std;

const char trainData[20] = "Datac_train.csv";
const char testData[20] = "Datac_test.csv";
const int TRAIN = 28000, TEST = 12000, COL = 70; //���ڿ�����
const int num_of_col = 58;

struct Files { //ÿ���ı�������
	float vector[COL];
	int shares; //ÿ���ı�������Ĵ���
};
float dis[TEST][TRAIN];

Files trains[TRAIN], tests[TEST];
int num_of_trains = 0, num_of_tests = 0;

void readTrain() {
	ifstream fin(trainData);
	float v;
	char ch;
	string w;
	getline(fin, w);
	int col = 0;
	while (fin >> v) {
		if (col < num_of_col) {
			trains[num_of_trains].vector[col++] = v;
			fin >> ch;
		} else {
			trains[num_of_trains].shares = v;
			col = 0;
			num_of_trains++;
		}
	}
	cout << "num_of_trains=" << num_of_trains << endl;
	fin.close();
}

void readTest() {
	ifstream fin;
	fin.open(testData);
	if (fin == NULL)
		cout << "read test failed" << endl;
	float v;
	char ch;
	string w;
	getline(fin, w);
	int col = 0;
	while (fin >> v >> ch) {
		tests[num_of_tests].vector[col++] = v;
		if (col >= num_of_col) {
			col = 0;
			num_of_tests++;
		}
	}
	cout << "num_of_tests=" << num_of_tests << endl;
	fin.close();
}

void get_dis() {
	for (int ttRow = 0; ttRow < num_of_tests; ttRow++) { //ÿ�������ı�
		for (int tnRow = 0; tnRow < num_of_trains; tnRow++) { //ÿ��ѵ���ı�
			dis[ttRow][tnRow] = 0;
			float distance = 0;
			for (int k = 0; k < num_of_col; k++) {
				distance += abs(
						trains[tnRow].vector[k]*tests[ttRow].vector[k]);
			}
			dis[ttRow][tnRow] = distance;
		}
	}
}

void oneNN() {
	for (int ttRow = 0; ttRow < num_of_tests; ttRow++) { //����ÿ�������ı�
		//float min = INT_MAX;
		float max=INT_MIN;
		for (int tnRow = 0; tnRow < num_of_trains; tnRow++) {
			if (dis[ttRow][tnRow]>max) {
				max = dis[ttRow][tnRow];
				tests[ttRow].shares=trains[tnRow].shares;
			}
		}
	}
}
void print(){
	fstream fout;
	fout.open("E:/Desktop/result.txt");
	if(fout==NULL) cout<<"Can not open result.txt"<<endl;
	fout.clear();
	for(int ttRow=0;ttRow<num_of_tests;ttRow++){
		fout<<tests[ttRow].shares<<endl;
	}
	fout.close();
}
int main() {
	readTrain();
	readTest();
	get_dis();
	oneNN();
	print();
}
