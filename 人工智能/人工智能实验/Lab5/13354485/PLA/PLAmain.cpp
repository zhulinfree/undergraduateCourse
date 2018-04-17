#include<bits/stdc++.h>
using namespace std;
char data[] = "Datac_all.csv";
char result[] = "result.txt";
vector<vector<double> > Trains, Tests;
stack<vector<double> > w_store;
int row_of_trains = 0, row_of_tests = 0;
int Train_row_4_5 = 0;
vector<double> w;
const int times = 1000;
float last_count = 0;
int lastC = 0;
void w0_initial();
int sign(double s);
void read();
void vector_to_one();
void PLA();
void print();
void printW(vector<double>);
int main() {
	cout << "begin for PLA" << endl << endl;
	read();
	vector_to_one();
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
	if(s==0) return 0;
	if (s >0)
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
	for(int it=0;it<row_of_trains;it++){
		int end=Trains[it].size();
		if(Trains[it][end-1]==0) Trains[it][end-1]=-1;
	}


	Train_row_4_5 = row_of_trains/5*4;
	cout<<Train_row_4_5<<endl;
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

void PLA() {
	for (int c = 0; c < times; c++) {
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
				//break;
			}
		}
		//交叉验证
		if (c > 100 && c % 5 == 0) {
			int count = 0;
			for (int r = Train_row_4_5; r < row_of_trains; r++) {
				int wsize = w.size();
				int tsize = Trains[r].size();
				double tmp = 0;
				for (int i = 0; i < wsize; i++) {
					tmp += Trains[r][i] * w[i];
				}
				if (sign(tmp) == Trains[r][tsize - 1]) {
					count++;
				}
			}
			//若正确率比之前的都高，那么就将w放到w_store队列里面去。
			if (count > last_count) {
				last_count=count;
				w_store.push(w);
				printW(w);
			}
		}

	}

}


void print() {
	fstream fout(result);
	fout.clear();
	vector<double> ww = w_store.top();
	int Wsize = ww.size();
	for (int row = 0; row < row_of_tests; row++) {
		double t=0;
		for (int col = 0; col < Wsize; col++) {
			t += Tests[row][col] * ww[col];
		}
		cout<<t<<endl;
		int sign_=sign(t)>0?1:0;
		fout << sign_ << endl;
	}
}

void printW(vector<double> w) {
	int Wsize = w.size();
	cout << endl << "W=[ ";
	for (int rw = 0; rw < Wsize; rw++) {
		cout << w[rw] << " ";
	}
	cout << "]" << endl << endl;
}

