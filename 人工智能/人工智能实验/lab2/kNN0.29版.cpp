/* Created on: 2015年10月26日
 * Author: 朱琳
 */
#include<bits/stdc++.h>
#include<fstream>
using namespace std;

char Dataset_words[40] = "E:/Desktop/Lab2/Dataset_words.txt";
char Dataset_words_anger[40] = "E:/Desktop/Lab2/Dataset_words_anger.txt";
char Dataset_words_disgust[50] = "E:/Desktop/Lab2/Dataset_words_disgust.txt";
char Dataset_words_fear[40] = "E:/Desktop/Lab2/Dataset_words_fear.txt";
char Dataset_words_joy[40] = "E:/Desktop/Lab2/Dataset_words_joy.txt";
char Dataset_words_sad[40] = "E:/Desktop/Lab2/Dataset_words_sad.txt";
char Dataset_words_surprise[50] = "E:/Desktop/Lab2/Dataset_words_surprise.txt";
char stopwords[40] = "E:/Desktop/Lab2/stopwords.txt";

char name1[60] = "E:/Desktop/lab2/AILab/predict_test/anger_predict.txt";
char name2[60] = "E:/Desktop/lab2/AILab/predict_test/disgust_predict.txt";
char name3[60] = "E:/Desktop/lab2/AILab/predict_test/fear_predict.txt";
char name4[60] = "E:/Desktop/lab2/AILab/predict_test/joy_predict.txt";
char name5[60] = "E:/Desktop/lab2/AILab/predict_test/sad_predict.txt";
char name6[60] = "E:/Desktop/lab2/AILab/predict_test/surprise_predict.txt";

enum feeling {
	anger, disgust, fear, joy, sad, surprise
};

struct Files { //每个训练文本
	string words[100]; //文本的所包含的单词
	float vector[5000]; //与不相同的单词对应生成的向量
	float feel[10];
	float dis[2000]; //每个测试文本与各个训练文本的距离。训练文本不需要这个。
	float num;
};
struct k_th {
	float dis;
	float probability;
	float weight;
};
const int num_of_feel = 6;
Files trains[300], tests[2000];
string unique_words[10000];
int num_of_trains = -1, num_of_tests = -1, num_of_unique = 0;
map<string, bool> check_stop_words;
map<string, int> check_map;
map<string, int> map_train[500], map_test[2000];
void read_stopwords();
void read_words();
float to_float(string s);
void read_probability();
void get_vector();
void vector_to_one();
void get_dis();
void print();
void caculate(int k, k_th v[], int f, Files &test);
void kNN(int k);
void initial();

int main() {
	cout << "kNN算法" << endl;
	initial();
	int k;
	cout << "Please input k=";
	cin >> k;
	kNN(k);
	print();
	cout << "end for kNN" << endl;
	return 0;
}

void read_stopwords() {
	ifstream fin;
	fin.open(stopwords);
	string words;
	while (fin >> words) {
		check_stop_words[words] = true;
	}
}

void read_words() { //读取文本单词，并生成不重复的单词
	ifstream fin;
	fin.open(Dataset_words);
	string words;
	int col = 0, flag = 0; //用于区分trains和test
	getline(fin, words); //忽略掉第一行标题行
	while (fin >> words) {
		string tmp = words + "xxxxx"; //防止判断单词长度不够导致bug
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

void read_probability() { //读取情感概率
	for (int feel = 0; feel < num_of_feel; feel++) {
		ifstream fin;
		switch (feel) {
		case 0:
			fin.open(Dataset_words_anger);
			break;
		case 1:
			fin.open(Dataset_words_disgust);
			break;
		case 2:
			fin.open(Dataset_words_fear);
			break;
		case 3:
			fin.open(Dataset_words_joy);
			break;
		case 4:
			fin.open(Dataset_words_sad);
			break;
		default:
			fin.open(Dataset_words_surprise);
		}
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
	for (int row = 0; row < num_of_trains; row++) { //对于每个训练文本
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

	for (int row = 0; row < num_of_tests; row++) { //对于每个测试文本
		tests[row].num = 0;
		for (int col = 0; col < num_of_unique; col++) {
			if (map_test[row][(unique_words[col])]) {
				tests[row].vector[col] = map_test[row][(unique_words[col])];
				tests[row].num++;
			} else
				tests[row].vector[col] = 0;
		}
	}
}

void vector_to_one() {
	for (int row = 0; row < num_of_trains; row++) {
		for (int col = 0; col < num_of_unique; col++) {
			trains[row].vector[col] /= trains[row].num;
		}
	}

	for (int row = 0; row < num_of_tests; row++) {
		for (int col = 0; col < num_of_unique; col++) {
			tests[row].vector[col] /= tests[row].num;
		}
	}
}

void get_dis() {
	for (int t_row = 0; t_row < num_of_tests; t_row++) { //每个测试文本
		for (int train_row = 0; train_row < num_of_trains; train_row++) { //每个训练文本
			tests[t_row].dis[train_row] = 0;
			float distance = 0;
			for (int k = 0; k < num_of_unique; k++) {
				distance +=
						(trains[train_row].vector[k] - tests[t_row].vector[k])
								* (trains[train_row].vector[k]
										- tests[t_row].vector[k]);

			}
			tests[t_row].dis[train_row] = sqrt(distance);
		}
	}
}
void get_dis() {
	for (int t_row = 0; t_row < num_of_tests; t_row++) { //每个测试文本
		for (int train_row = 0; train_row < num_of_trains; train_row++) { //每个训练文本
			tests[t_row].dis[train_row] = 0;
			float distance = 0;
			for (int k = 0; k < num_of_unique; k++) {
				distance += abs(trains[train_row].vector[k] - tests[t_row].vector[k]);
			}
			tests[t_row].dis[train_row] = distance;
		}
	}
}

void caculate(int k, k_th v[], int f, Files &test) { //取倒数，算权重，权重归一化，计算anger等值
//	float num_dis = 0;
	test.feel[f] = 0;
//	for (int i = 0; i < k; i++) {
//		num_dis += v[i].dis;
//	}
	float num = 0;
	for (int i = 0; i < k; i++) {
		//v[i].dis /= num_dis; //先进行向量的归一化
		v[i].weight =pow( 1.0 / v[i].dis,3);
		num += v[i].weight;
	}
	for (int i = 0; i < k; i++) {
		v[i].weight /= num;
		test.feel[f] += v[i].weight * v[i].probability;
	}
}

void kNN(int k) {
	for (int f = 0; f < num_of_feel; f++) {//对于每种情感。0=anger，1=disgust...见enum
		for (int t_row = 0; t_row < num_of_tests; t_row++) { //对于每个测试文本
			//得到距离此test最近的k个向量。
			k_th v[300];		//距离此test最近的文本。
			int number[300];
			for (int count = 0; count < k; count++) {		//计算距离测试文本最近的k个文本；
				float min = INT_MAX;
				for (int train_row = 0; train_row < num_of_trains;
						train_row++) {
					if (tests[t_row].dis[train_row] < min) {
						min = tests[t_row].dis[train_row];
						number[count] = train_row;		//第trains_row个训练文本
					}
				}		//循环找到最小值。
				v[count].dis = min;
				v[count].probability = trains[(number[count])].feel[f];
				tests[t_row].dis[(number[count])] = INT_MAX;//将此轮找到的那个最小距离置为最大，不再参与比较。共有k轮比较
			}
			for (int count = 0; count < k; count++) {
				tests[t_row].dis[(number[count])] = v[count].dis;		//数据恢复
			}
			//至此已得到距离此test最近的k个向量。
			caculate(k, v, f, tests[t_row]);
		}
	}
}

void initial() {
	read_stopwords();
	read_words();
	get_vector(); //得到训练集和测试集的向量。
	vector_to_one();
	get_dis();
	read_probability();
}

void print() {
	for (int feel = 0; feel < 6; feel++) {
		fstream fout;
		switch (feel) {
		case 0:
			fout.open(name1);
			break;
		case 1:
			fout.open(name2);
			break;
		case 2:
			fout.open(name3);
			break;
		case 3:
			fout.open(name4);
			break;
		case 4:
			fout.open(name5);
			break;
		default:
			fout.open(name6);
		}
		fout.clear();
		for (int row = 0; row < num_of_tests; row++) {
			fout << tests[row].feel[feel] << endl;
		}
		fout.close();
	}
}
