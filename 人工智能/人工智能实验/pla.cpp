#include<bits/stdc++.h>
using namespace std;
char data[] = "Datac_all.csv";
vector<vector<double> > Trains, Tests;
int row_of_trains = 0, row_of_tests = 0;
vector<double> w;
void w0_initial();
int sign(double s);
void read();
void PLA();
//vector<int> predict();
void predict_and_print();
int main() {
	cout<<"begin for PLA"<<endl<<endl;

	read();
	cout<<"read end"<<endl;
	w0_initial();
	cout<<"initail end"<<endl;
	PLA();
	predict_and_print();
	cout<<endl<<"end for PLA"<<endl;
	return 0;
}
void w0_initial(){
//	w.push_back(1);
//	w.push_back(1);
//	w.push_back(1);
	int cols=Trains[0].size()-1;
	for(int i=0;i<cols;i++){
		w.push_back(1);
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
	while (!fin.eof()) {
		getline(fin, line); //读取一行
		if (line.substr(line.length() - 1, 1) == "?") {
			stringstream rdouble; //read double
			line = line.substr(0, line.length() - 2);
			rdouble << line;
			vector<double> testVec;
			while (!rdouble.eof()) {
				double n;
				rdouble >> n;
				testVec.push_back(n);
			}
			Tests.push_back(testVec);
			row_of_tests++;
		} else {
			stringstream rdouble; //read double
			rdouble << line;
			vector<double> trainVec;
			while (!rdouble.eof()) {
				double n;
				rdouble >> n;
				trainVec.push_back(n);
			}
			Trains.push_back(trainVec);
			row_of_trains++;
		}
	}
	cout<<"row_of_tests ="<<row_of_tests<<endl;
	cout<<"row_of_trains="<<row_of_trains<<endl;
}
void PLA(){
	for(int row=0;row<row_of_trains;row++){//共有row_of_trains个训练样本
		double y=0;
		int num_of_cols=Trains[row].size()-1;
		for(int col=0;col<num_of_cols;col++){
			y+=Trains[row][col]*w[col];//计算此刻对于文本的预测值
		}
		int real_sign=sign(Trains[row][Trains[row].size()-1]);
		if(sign(y)!=real_sign){//若预测失败
			int col=0;
			int row_of_w=w.size();
			for(int rw=0;rw<row_of_w;rw++,col++){
				w[rw]+=real_sign*Trains[row][col];
			}
			PLA();
			break;
		}
	}
}


void predict_and_print(){

	vector<int> res;
	int Wsize=w.size();
	cout<<endl<<"W[ ";
	for(int rw=0;rw<Wsize;rw++){
		cout<<w[rw]<<" ";
	}
	cout<<"]"<<endl<<endl<<"The result is:"<<endl;
	for(int row=0;row<row_of_tests;row++){
		double tmp=0;
		for(int col=0;col<Wsize;col++){
			tmp+=Tests[row][col]*w[col];
		}
		cout<<"t"<<row<<": "<<sign(tmp)<<endl;
		//res.push_back(sign(tmp));
	}
	//return res;
}

