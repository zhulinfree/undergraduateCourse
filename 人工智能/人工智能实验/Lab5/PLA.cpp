#include<bits/stdc++.h>
using namespace std;
char data[] = "Datac_all.csv";
char result[] = "result.txt";
vector<vector<double> > Trains, Tests;
int row_of_trains = 0, row_of_tests = 0;
int Train_row_4_5=0;
vector<double> w;
const int times=100;
const int count_times=100;

void w0_initial();
int sign(double s);
void read();
void PLA();
void print();


int main() {
	cout << "begin for PLA" << endl << endl;
	read();
	w0_initial();
	cout << "initail end" << endl;
	PLA();
	print();
	cout << endl << "end for PLA" << endl;
	return 0;
}
void w0_initial() {
	int cols = Trains[0].size() - 1;
	cout << "cols=" << cols << endl;
	for (int i = 0; i < cols; i++) {
		w.push_back(0);
	}
}
int sign(double s) {
	if (s < 0)
		return -1;
	if (s == 0)
		return 0;
	if (s > 0)
		return 1;
	return 0;
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
			stringstream rdouble; //read double
			line = line.substr(0, line.length() - 1);
			rdouble << line;
			vector<double> testVec;
			while (!rdouble.eof()) {
				double n;
				char dot;
				rdouble >> n >> dot;
				testVec.push_back(n);
			}
			Tests.push_back(testVec);
			row_of_tests++;
		} else {
			line += ",";
			stringstream rdouble; //read double
			rdouble << line;
			vector<double> trainVec;
			while (!rdouble.eof()) {
				double n;
				char dot;
				rdouble >> n >> dot;
				trainVec.push_back(n);
			}
			Trains.push_back(trainVec);
			row_of_trains++;
		}
	}
	Train_row_4_5=0.8*row_of_trains;
	cout << "row_of_trains=" << row_of_trains << endl;
	cout << "row_of_tests =" << row_of_tests << endl;
}

void PLA() {
	for (int c = 0; c <times; c++) {
		if(c%1000==0) cout<<"c="<<c<<endl;
		for (int row = 0; row < Train_row_4_5; row++) { //共有row_of_trains个训练样本
			double y = 0;
			int num_of_cols = Trains[row].size() - 1;
			for (int col = 0; col < num_of_cols; col++) {
				y += Trains[row][col] * w[col]; //计算此刻对于文本的预测值
			}
			int real_sign = sign(Trains[row][Trains[row].size() - 1]);
			if (sign(y) != real_sign) { //若预测失败
				int col = 0;
				int row_of_w = w.size();
				for (int rw = 0; rw < row_of_w; rw++, col++) {
					w[rw] += real_sign * Trains[row][col];
				}
				break;
			}

		}
	}

}

void print() {
	fstream fout(result);
	if(fout==NULL) cout<<"cannot open result file!"<<endl;
	fout.clear();
	vector<int> res;
	int Wsize = w.size();
	cout << endl << "W[ ";
	for (int rw = 0; rw < Wsize; rw++) {
		cout << w[rw] << " ";
	}
	cout << "]" << endl << endl;
	for (int row = 0; row < row_of_tests; row++) {
		double tmp = 0;
		for (int col = 0; col < Wsize; col++) {
			tmp += Tests[row][col] * w[col];
		}
		//cout << "t" << row << ": " << sign(tmp) << endl;
		fout<<sign(tmp)<<endl;
	}
}

