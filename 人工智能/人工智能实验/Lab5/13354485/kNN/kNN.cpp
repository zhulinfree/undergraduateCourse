/* Created on: 2015年10月26日
 * Author: 朱琳
 */
#include<bits/stdc++.h>
#include<fstream>
using namespace std;
char data[] = "Datac_all.csv";
char result[] = "result.txt";
vector<vector<float> > trains, tests;
int row_of_trains = 0, row_of_tests = 0;
float dis[12000][28000];

void read();
void vector_to_one();
void get_dis();
void kNN();
void print();

int main() {
	cout << "begin for kNN" << endl;
	read();
	vector_to_one();
	cout<<"end for to one"<<endl;
	get_dis();
	cout<<"end for dis"<<endl;
	kNN();
	cout<<"end for calkNN"<<endl;
	print();
	cout << "end for kNN" << endl;
}

void read() {
	ifstream fin(data);
	if (fin == NULL)
		cout << "cannot read file";
	string line;
	getline(fin, line); //读取一行
	while (!fin.eof()) {
		getline(fin, line); //读取一行
		if (line.length() == 0)
			break;
		if (line.substr(line.length() - 1, 1) == "?") {
			stringstream rfloat; //read float
			line = line.substr(0, line.length() - 1);
			rfloat << line;
			vector<float> testVec;
			while (!rfloat.eof()) {
				float n;
				char dot;
				rfloat >> n >> dot;
				testVec.push_back(n);
			}
			tests.push_back(testVec);
			row_of_tests++;
		} else {
			line += ",";
			stringstream rfloat; //read float
			rfloat << line;
			vector<float> trainVec;
			while (!rfloat.eof()) {
				float n;
				char dot;
				rfloat >> n >> dot;
				trainVec.push_back(n);
			}
			trains.push_back(trainVec);
			row_of_trains++;
		}
	}

	cout << "row_of_trains=" << row_of_trains << endl;
	cout << "row_of_tests =" << row_of_tests << endl;
}

//进行向量列归一化
void vector_to_one() {
	int cols = trains[0].size() - 1;
	for (int col = 0; col < cols; col++) { //对于每一列来说，除去最后一列
		float max = -999999, min = 999999;
		for (int row = 0; row < row_of_trains; row++) { //for each row
			max = trains[row][col] > max ? trains[row][col] : max;
			min = trains[row][col] < min ? trains[row][col] : min;
		}
		for (int row = 0; row < row_of_tests; row++) { //for each row
			max = tests[row][col] > max ? tests[row][col] : max;
			min = tests[row][col] < min ? tests[row][col] : min;
		}
		for (int row = 0; row < row_of_trains; row++) { //for each row
			trains[row][col] = (trains[row][col] - min) / (max - min);
		}
		for (int row = 0; row < row_of_tests; row++) { //for each row
			tests[row][col] = (tests[row][col] - min) / (max - min);
		}
	}
}

void get_dis() {
	for (int ttRow = 0; ttRow < row_of_tests; ttRow++) { //每个测试文本
		for (int tnRow = 0; tnRow < row_of_trains; tnRow++) { //每个训练文本
			float distance = 0;
			int cols = trains[tnRow].size();
			for (int k = 0; k < cols; k++) {
				distance += abs(trains[tnRow][k] - tests[ttRow][k]);
			}
			dis[ttRow][tnRow] = distance;
		}
	}
}

void kNN() {
	for (int ttRow = 0; ttRow < row_of_tests; ttRow++) { //对于每个测试文本
		float min = INT_MAX;
		for (int tnRow = 0; tnRow < row_of_trains; tnRow++) {
			if (dis[ttRow][tnRow] < min) {
				int cols = trains[tnRow].size();
				int shares = trains[tnRow][cols - 1];
				min = dis[ttRow][tnRow];
				tests[ttRow].push_back(shares);
			}
		}
	}
}
void print() {
	fstream fout;
	fout.open(result);
	if (fout == NULL)
		cout << "Can not open result.txt" << endl;
	fout.clear();

	for (int ttRow = 0; ttRow < row_of_tests; ttRow++) {
		int cols = tests[ttRow].size();
		fout << tests[ttRow][cols - 1] << endl;
	}
	fout.close();
}
