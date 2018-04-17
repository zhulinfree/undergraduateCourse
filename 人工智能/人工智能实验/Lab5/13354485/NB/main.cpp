/* Created on: 2015��10��26��
 * Author: ����
 */
#include<bits/stdc++.h>
#include<fstream>
using namespace std;

string data[]={"Dataset_words.txt","Dataset_words_anger.txt","Dataset_words_disgust.txt","Dataset_words_fear.txt","Dataset_words_joy.txt","Dataset_words_sad.txt","Dataset_words_surprise.txt"};
string result[]={"anger_predict.txt","disgust_predict.txt","fear_predict.txt","joy_predict.txt","sad_predict.txt","surprise_predict.txt"};
char stopwords[40] = "E:/Desktop/Lab2/stopwords.txt";

enum feeling {
	anger, disgust, fear, joy, sad, surprise
};

struct Files { //ÿ��ѵ���ı�
	string words[100]; //�ı����������ĵ���
	float vector[5000]; //�벻��ͬ�ĵ��ʶ�Ӧ���ɵ�����
	float feel[10]; //����������ֵ�ĸ���
	float num; //����Vector�Ĺ�һ����vector��allά������֮�͡�
	int Dim[10000]; //��¼file�ڵ�ÿ��words���ڵ�ά�ȡ�
	int numDim; //һ��test�Ĵʵ�������
};
const int num_of_feel = 6;
const float nb_number = 0.1;
Files trains[300], tests[2000];
string unique_words[10000];
int num_of_trains = -1, num_of_tests = -1, num_of_unique = 0;

map<string, bool> check_stop_words;
map<string, int> check_map;
map<string, int> map_train[500], map_test[2000];

float to_float(string s);
void read_stopwords();
void read_words();
void read_probability();
void get_vector();
void vector_to_one();
void NB();
void feel_to_one();
void initial();
void print();

int main() {
	cout << "NB begin" << endl;
	initial();
	NB();
	print();
	cout << "end for NB" << endl;
	return 0;
}
void read_stopwords() {
	ifstream fin;
	fin.open(stopwords);
	if(fin==NULL) cout<<"stopwords not exist"<<endl;
	string words;
	while (fin >> words) {
		check_stop_words[words] = true;
	}
}

void read_words() { //��ȡ�ı����ʣ������ɲ��ظ��ĵ���
	ifstream fin;
	fin.open(data[0].c_str());
	if(fin==NULL) cout<<"Datawords not exist"<<endl;
	string words;
	int col = 0, flag = 0; //��������trains��test
	getline(fin, words); //���Ե���һ�б�����
	while (fin >> words) {
		string tmp = words + "xxxxx"; //��ֹ�жϵ��ʳ��Ȳ�������bug
		if (tmp.substr(0, 5) == "train" && tmp.substr(5, 1) <= "9"
				&& tmp.substr(5, 1) > "0") {
			flag = 0;
			num_of_trains++;
			col = 0;
		} else if (tmp.substr(0, 4) == "test" && tmp.substr(4, 1) <= "9"
				&& tmp.substr(4, 1) > "0") {
			flag = 1;
			num_of_tests++;
			col = 0;
		} else if (check_stop_words[words] == false) {
			if (!flag) {
				trains[num_of_trains].words[col++] = words;
				if (check_map[words] == 0) {
					check_map[words] = 1;
					unique_words[num_of_unique++] = words;
				}
				map_train[num_of_trains][words]++;

			} else {
				tests[num_of_trains].words[col++] = words;
				map_test[num_of_tests][words]++;
				if (check_map[words] == 0) {
					check_map[words] = 1;
					unique_words[num_of_unique++] = words;
				}
			}
		}
	}
	num_of_trains++;
	num_of_tests++;
	cout << "num_of_trains=" << num_of_trains << endl;
	cout << "num_of_tests= " << num_of_tests << endl;
	cout << "num_of_unique=" << num_of_unique << endl;
	fin.close();
}

float to_float(string s) {
	int x = 0;
	x = (int) (s[0] - '0') * 1000 + (int) (s[1] - '0') * 100
			+ (int) (s[2] - '0') * 10 + (int) (s[3] - '0');
	return x * 1.0 / 10000.0;
}

void read_probability() { //��ȡ��и���
	for (int feel = 0; feel < num_of_feel; feel++) {
		ifstream fin;
		fin.open(data[feel+1].c_str());
		if(fin==NULL) cout<<"probability file not exist"<<endl;
		string sen, tmp;
		getline(fin, sen);
		for (int i = 0; i < num_of_trains; i++) {
			getline(fin, sen);
			tmp = sen.substr(sen.length() - 4, 4);
			trains[i].feel[feel] = to_float(tmp);
		}
		fin.close();

	}
}

void get_vector() {
	for (int row = 0; row < num_of_trains; row++) { //����ÿ��ѵ���ı�
		trains[row].num = 0;
		for (int col = 0; col < num_of_unique; col++) {
			if (map_train[row][(unique_words[col])]) {
				trains[row].vector[col] = map_train[row][(unique_words[col])];
				trains[row].num++;
			} else {
				trains[row].vector[col] = 0;
			}

		}
	}

	for (int row = 0; row < num_of_tests; row++) { //����ÿ�������ı�
		tests[row].num = 0;
		for (int col = 0; col < num_of_unique; col++) {
			if (map_test[row][(unique_words[col])]) {
				tests[row].vector[col] =map_test[row][(unique_words[col])];
				tests[row].num++;
			} else
				tests[row].vector[col] = 0;
		}
	}
}

void vector_to_one() {
	for (int row = 0; row < num_of_trains; row++) {
		trains[row].num += num_of_unique;
		for (int col = 0; col < num_of_unique; col++) {
			trains[row].vector[col] += 1.0;
			trains[row].vector[col] /= trains[row].num; //����ÿ��ά�ȵĴʶ����ȳ��ֹ�һ�Ρ�
		}
	}

	for (int row = 0; row < num_of_tests; row++) {
		int num_dim = 0;
		for (int col = 0; col < num_of_unique; col++) {
			if (tests[row].vector[col] == 1) {
				tests[row].vector[col] /= tests[row].num;
				tests[row].Dim[num_dim++] = col;
			}
		}
		tests[row].numDim = num_dim;
	}
}

void NB() { //�������feel��NB
	for (int feel = 0; feel < num_of_feel; feel++) {
		for (int test_row = 0; test_row < num_of_tests; test_row++) { //����ÿ�������ı���
			int nDim = tests[test_row].numDim; //��tests����dim����Чά�ȡ�
			tests[test_row].feel[feel] = 0;
			for (int train_row = 0; train_row < num_of_trains; train_row++) { //����ÿ��ѵ���ı�
				float tmp = trains[train_row].feel[feel];
				for (int d = 0; d < nDim; d++) {
					int Dim = tests[test_row].Dim[d]; //test�ڵ�Dim��ά���ϵĴʡ�
					tmp *= trains[train_row].vector[Dim];
				}
				tests[test_row].feel[feel] += tmp;
			}
		}
	}
	feel_to_one(); //ÿ��test�ı�����������й�һ��
}

void feel_to_one() {
	for (int t_row = 0; t_row < num_of_tests; t_row++) {
		float num_feel = 0;
		for (int feel = 0; feel < 6; feel++) {
			num_feel += tests[t_row].feel[feel];
		}
		for (int feel = 0; feel < 6; feel++) {
			tests[t_row].feel[feel] /= num_feel;
		}
	}
}

void initial() {
	read_stopwords();
	read_words();
	get_vector(); //�õ�ѵ�����Ͳ��Լ���������
	vector_to_one();
	read_probability();
}

void print() {
	for (int feel = 0; feel < num_of_feel; feel++) {
		fstream fout;
		fout.open(result[feel].c_str());
		if(fout==NULL) cout<<"Cannot open predict file"<<endl;
		fout.clear();
		for (int row = 0; row < num_of_tests; row++) {
			fout << tests[row].feel[feel] << endl;
		}
		fout.close();
	}
}
