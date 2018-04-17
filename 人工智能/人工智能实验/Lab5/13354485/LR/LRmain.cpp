/* Created on: 2015年12月21日
 * Author: 朱琳
 */
#include<bits/stdc++.h>
using namespace std;
char data[] = "Datac_all.csv";
char result[] = "result.txt";
vector<vector<double> > Trains, Tests;
stack<vector<double> > w_store;
int row_of_trains = 0, row_of_tests = 0;
int final_count = 0;
vector<double> w;
const int times = 1000;
double step = 0.0001;
void read();
void vector_to_one();
void initial();
void LR();
int predict(vector<double> testRow,vector<double> w);
void print();

int main() {
	cout << "begin for LR" << endl << endl;
	read();
	vector_to_one();
	initial();
	cout << "initial end" << endl;
	LR();
	print();
	cout << endl << "end for LR" << endl;
	return 0;
}

void initial() {
	int cols = Trains[0].size() - 1;
	cout << "cols=" << cols << endl;
	for (int i = 0; i < cols; i++) {
		w.push_back(1.0);
	}
	w_store.push(w);
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
	cout << "row_of_trains=" << row_of_trains << endl;
	cout << "row_of_tests =" << row_of_tests << endl;
}

//进行向量列归一化
void vector_to_one() {
	int cols = Trains[0].size() - 1;
	for (int col = 0; col < cols; col++) { //对于每一列来说，除去最后一列
		float max = -999999, min = 999999;
		for (int row = 0; row < row_of_trains; row++) { //for each row
			max = Trains[row][col] > max ? Trains[row][col] : max;
			min = Trains[row][col] < min ? Trains[row][col] : min;
		}
		for (int row = 0; row < row_of_tests; row++) { //for each row
			max = Tests[row][col] > max ? Tests[row][col] : max;
			min = Tests[row][col] < min ? Tests[row][col] : min;
		}
		for (int row = 0; row < row_of_trains; row++) { //for each row
			Trains[row][col] = (Trains[row][col] - min) / (max - min);
		}
		for (int row = 0; row < row_of_tests; row++) { //for each row
			Tests[row][col] = (Tests[row][col] - min) / (max - min);
		}
	}
}

void LR() {
	for (int c = 0; c < times; c++) {
		int wcol = w.size();
		double error[wcol];
		for (int i = 0; i < wcol; i++)
			error[i] = 0;
		for (int row = 0; row <row_of_trains ; row++) { //y=w0+(sigma(1->n))Wj*Xj
			double wx = 0;
			int num_of_cols = Trains[row].size();
			for (int col = 0; col < num_of_cols - 1; col++) { //-1是去掉结果的那一列
				wx += w[col] * Trains[row][col]; //Wj*Xj;
			}
			double diff = 1.0 / (exp(-wx) + 1) - Trains[row][num_of_cols - 1]; //(  -Yi)*Xi
			for (int col = 0; col < num_of_cols - 1; col++) {
				error[col] += diff * Trains[row][col]; //*Xi部分
			}
		}
		for (int wc = 0; wc < wcol; wc++)
			w[wc] -=step * error[wc];
		//if(c>100) step=0.0001;
	}
}


int predict(vector<double> testRow,vector<double> w) {
	int wCol = w.size();
	double res = 0;
	for (int col = 0; col < wCol; col++) {
		res += testRow[col] * w[col];
	}
	int result = 1.0 / (1.0 + exp(-res)) >= 0.5 ? 1 : 0;
	return result;
}
void print() {
	fstream fout(result);
	vector<double> w_final = w_store.top();
	for (int tr = 0; tr < row_of_tests; tr++) {
		fout<<predict(Tests[tr],w)<<endl;
	}
}

