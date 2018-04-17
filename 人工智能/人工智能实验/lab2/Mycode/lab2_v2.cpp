/* Created on: 2015年10月26日
 * Author: 朱琳
 */
#include<bits/stdc++.h>
#include<fstream>
using namespace std;
const char Dataset_words[40] = "E:/Desktop/Lab2/Dataset_words.txt";
const char Dataset_words_anger[40] = "E:/Desktop/Lab2/Dataset_words_anger.txt";
const char Dataset_words_disgust[50] =
		"E:/Desktop/Lab2/Dataset_words_disgust.txt";
const char Dataset_words_fear[40] = "E:/Desktop/Lab2/Dataset_words_fear.txt";
const char Dataset_words_joy[40] = "E:/Desktop/Lab2/Dataset_words_joy.txt";
const char Dataset_words_sad[40] = "E:/Desktop/Lab2/Dataset_words_sad.txt";
const char Dataset_words_surprise[50] =
		"E:/Desktop/Lab2/Dataset_words_surprise.txt";
const char vector_name[30]="E:/Desktop/lab2/vector.txt";
const char distance_name[30]="E:/Desktop/lab2/distance.txt";
fstream fout;

enum feeling {
	anger, disgust, fear, joy, sad, surprise
};

struct Files { //每个训练文本
	string words[100]; //文本的所包含的单词
	int vector[2000]; //与不相同的单词对应生成的向量
	float feel[10];
	float dis[2000]; //每个测试文本与各个训练文本的距离。训练文本不需要这个。
};
struct k_th{
	float dis;
	float probability;
	float weight;
};

Files trains[300], tests[2000];
string unique_words[100000];
int num_of_trains = -1, num_of_tests = -1, num_of_unique = 0;

map<string, int> check_map;
map<string, int> map_train[500], map_test[2000];

void read(ifstream &fin, const char name[]) { //读取文本单词，并生成不重复的单词
	fin.open(name);
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
		} else {
			if (!flag) {
				trains[num_of_trains].words[col++] = words;
				map_train[num_of_trains][words]++;
				if (check_map[words] == 0) {
					check_map[words] = 1;
					unique_words[num_of_unique++] = words;
				} else {
					check_map[words]++;
				}
			} else {
				tests[num_of_trains].words[col++] = words;
				map_train[num_of_tests][words]++;
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

void read_probability(ifstream &fin, const char name[], int a) { //读取情感概率
	fin.open(name);
	string sen, tmp;
	getline(fin, sen);
	for (int i = 0; i < num_of_trains; i++) {
		getline(fin, sen);
		tmp = sen.substr(sen.length() - 4, 4);
		trains[i].feel[a] = to_float(tmp);
		cout << trains[i].feel[a] << endl;
	}
	fin.close();
}

void get_vector() {
	fout.open(vector_name);
	for (int row = 0; row < num_of_trains; row++) { //对于每个训练文本
		for (int col = 0; col < num_of_unique; col++) {
			trains[row].vector[col] = map_train[row][(unique_words[col])];
			fout<<trains[row].vector[col]<<" ";
		}
		fout<<endl;
	}

	for (int row = 0; row < num_of_tests; row++) { //对于每个测试文本
		for (int col = 0; col < num_of_unique; col++) {
			tests[row].vector[col] = map_test[row][(unique_words[col])];
			fout<<tests[row].vector[col]<<" ";
		}
		fout<<endl;
	}
	fout.close();
}

void get_dis() {
	fout.open(distance_name);
	for (int t_row = 0; t_row < num_of_tests; t_row++) { //每个测试文本
		for (int train_row = 0; train_row < num_of_trains; train_row++) { //每个训练文本
			tests[t_row].dis[train_row] = 0;
			for (int k = 0; k < num_of_unique; k++) {
				tests[t_row].dis[train_row] += pow(
						(trains[train_row].vector[k] - tests[t_row].vector[k]),
						2);
			}
			tests[t_row].dis[train_row] = sqrt(tests[t_row].dis[train_row]);
			fout<<tests[t_row].dis[train_row]<<" ";
		}
		fout<<endl;
	}
	fout.close();
}


void caculate(int k,k_th v[],int f,Files &test){//归一化，去倒数，算权重，计算anger等值
	float num_dis=0;
	test.feel[f]=0;
	for(int i=0;i<k;i++){
		num_dis+=v[i].dis;
	}
	for(int i=0;i<k;i++){
		v[i].dis/=num_dis;//归一化
		v[i].weight=1.0/v[i].dis;
		test.feel[f]+=v[i].weight*v[i].probability;
	}
}

void kNN(int k,int f) {
	fstream out("E:/Desktop/lab2/AILab/predict_test/anger_predict.txt");
	for (int t_row = 0; t_row < num_of_tests; t_row++) { //对于每个测试文本
		//得到距离此test最近的k个向量。
		k_th v[300];//距离此test最近的文本。
		int number[300];
		for (int count = 0; count < k; count++) {//计算距离测试文本最近的k个文本；
			float min=INT_MAX;
			for (int train_row = 0; train_row < num_of_trains; train_row++) {
				if(tests[t_row].dis[train_row]<min){
					min=tests[t_row].dis[train_row];
					number[count]=train_row;//第trains_row个训练文本
				}
			}//循环找到最小值。
			v[count].dis=min;
			v[count].probability=trains[(number[count])].feel[f];
			tests[t_row].dis[(number[count])]=INT_MAX;//将此轮找到的那个最小距离置为最大，不再参与比较。共有k轮比较
		}
		for(int count=0;count<k;count++){
			tests[t_row].dis[(number[count])]=v[count].dis;//数据恢复
		}
		//至此已得到距离此test最近的k个向量。
		caculate(k,v,f,tests[t_row]);
		cout<<tests[t_row].feel[f]<<" ";//输出预测值。
		out<<tests[t_row].feel[f]<<endl;//输出预测值。
	}
}

void print() {
	for (int row = 0; row < num_of_trains; row++) {
		int col = 0;
		while (trains[row].words[col] != "") {
			cout << trains[row].words[col++] << " ";
		}
		cout << endl;
	}
}

void initial() {
	get_vector(); //得到训练集和测试集的向量。
	get_dis();
}

void read_V_and_D(){
	ifstream fin;
	fin.open(vector_name);
	int x;
	for(int train_row=0;train_row<num_of_trains;train_row++){
		for(int i=0;i<num_of_unique;i++){//总共有num_of_unique个维度
			fin>>x;
			trains[train_row].vector[i]=x;
		}
	}

	for(int t_row=0;t_row<num_of_tests;t_row++){
		for(int i=0;i<num_of_unique;i++){//总共有num_of_unique个维度
			fin>>x;
			tests[t_row].vector[i]=x;
		}
	}
	fin.close();
	//distance向量初始化
	float f;
	fin.open(distance_name);
	for(int t_row=0;t_row<num_of_tests;t_row++){
		for(int train_row=0;train_row<num_of_unique;train_row++){//共有train_row个训练文本
			fin>>f;
			tests[t_row].dis[train_row]=f;
		}
	}
}

int main() {
	ifstream fin;
	read(fin, Dataset_words);
	initial();
	//read_V_and_D();
	read_probability(fin, Dataset_words_anger, anger);
//	read_probability(fin,Dataset_words_disgust,disgust);
//	read_probability(fin,Dataset_words_fear,fear);
//	read_probability(fin,Dataset_words_joy, joy);
//	read_probability(fin,Dataset_words_sad, sad);
//	read_probability(fin,Dataset_words_surprise,surprise);

//	for(int row=0;row<num_of_trains;row++){
//		cout<<row<<"."<<tests[0].dis[row]<<" ";
//	}
	int k;
	cout << "Now please input the value k=" ;
	cin>>k;
	kNN(k,anger);

	return 0;
}

