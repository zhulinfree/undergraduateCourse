/* Created on: 2015年10月15日
 * Author: 朱琳
 */
#include<iostream>
#include<bits/stdc++.h>
#include<map>

using namespace std;

void clearMap(map<string, int> &map, string *word, int count) {
	for (int i = 0; i < count; i++)
		map[word[i]] = 0;
}

int checkString(string W1) {
	if (W1 == "训练文本1" || W1 == "训练文本2" || W1 == "训练文本3" || W1 == "训练文本4"
			|| W1 == "训练文本5" || W1 == "训练文本6" || W1 == "训练文本7" || W1 == "训练文本8"
			|| W1 == "训练文本9" || W1 == "训练文本10")
		return 1;

	if (W1 == "测试文本1" || W1 == "测试文本2" || W1 == "测试文本3" || W1 == "测试文本4"
			|| W1 == "测试文本5" || W1 == "测试文本6" || W1 == "测试文本7" || W1 == "测试文本8"
			|| W1 == "测试文本9" || W1 == "测试文本10")
		return 2;

	if (W1 == "文本编号" || W1 == "词列表（以空格分隔）" || W1 == "EOF")
		return 3;
	return 0;

}


int main() {
	float moved[10] = { 1, 0.9, 0.5, 0.5, 0.4, 0.1, 0.02, 0, 0, 0 };
	int num1 = 0, num2 = 0;
	map<string, int> map;
	float v[100][100];
	fstream fin("E:/Desktop/人工智能/人工智能实验/Lab_1/Dataset_words.txt");
	string W1[300], W2[300]; //W1是所有的词，包括重复的。W2是不重复的词，并且不包含title

	while (fin >> W1[num1])
		num1++;
	W1[num1++] = "EOF"; //增加冗余以确定文本的末端
	fin.close();

	//查找没有重复的单词
	clearMap(map, W1, num1);
	for (int j = 2; j < num1; j++) {
		int check = checkString(W1[j]);
		if (check == 0 && map[W1[j]] == 0) {
			W2[num2++] = W1[j];
			map[W1[j]] = 1;
		}
	}

	//输出不重复的单词
	cout << "没有重复的单词数=" << num2 << endl<<endl;
	for (int i = 0; i < num2; i++)
		cout << W2[i] << " ";
	cout << endl;

	//生成关系向量
	int numText = 0;//numText指的是文本的数量即10+10=20
	for (int i = 2; i < num1; i++) {
		int checkNow = checkString(W1[i]), checkNext = checkString(W1[i + 1]);
		if (checkNow == 0) {
			map[W1[i]]++;
		} else {
			clearMap(map, W2, num2);
		}

		if (checkNext != 0) { //读到下一个文本或者文件结束
			for (int j = 0; j < num2; j++) {
				v[numText][j] = map[W2[j]]; //第numText个文本对应第j个词的向量
			}
			numText++;
		}
	}


	//将关系向量进行归一化
	for (int i = 0; i < numText; i++) {
		int num=0;
		for (int j = 0; j < num2; j++)
			num+=v[i][j];
		for(int j=0;j<num2;j++)
			v[i][j]/=num;
	}


	//输出关系向量
	for (int i = 0; i < numText; i++) {
		cout << (i < 10 ? "训练文本" : "测试文本") << i % 10 + 1 << "=(";
		for (int j = 0; j < num2; j++)
			//printf("%.4f ",v[i][j]);
			cout << v[i][j] << " ";
		cout << ")" << endl<<endl;
	}

	float preMoved[100]={0};
	for (int i = 10; i < 20; i++) { //每个测试文本
		cout<<"测试文本"<<i-10<<": ";
		float dis[100],weight[100];//训练文本和测试文本的对应欧氏距离，以及距离的倒数
		int NoTexts=0;
		float num=0;
		float max_weight1=0,max_weght2=0;
		for (int j = 0; j < 10; j++) { //各个训练文本
			dis[NoTexts] = 0;
			for (int k = 0; k < num2; k++){
				dis[NoTexts] += (v[i][k] - v[j][k])* (v[i][k] - v[j][k]);
			}
			dis[NoTexts]=sqrt(dis[NoTexts]);//计算得出欧氏距离
			weight[NoTexts]=1.0/dis[NoTexts];

			num+=abs(weight[NoTexts]);//将每个训练文本权重相加，为归一化做准备
			NoTexts++;
		}
		//对于每个欧式距离的权重进行归一化
		cout<<"weight: ";
		for(int j=0;j<10;j++){//将本身权重/总权重
			weight[j]/=num;
			cout<<weight[j]<<" ";
		}
		cout<<endl;

		//对于每个测试文本，将加权之后的感动值算出
		for(int c=0;c<NoTexts;c++){
			cout<<preMoved[i]<<" ";
			preMoved[i]+=weight[c]*moved[c];
		}
		cout<<endl;
		cout<<"move: "<<preMoved[i]<<endl;
	}

	fstream fout("E:/Desktop/人工智能/人工智能实验/Lab_1/result.txt");
	cout<<endl<<"以上测试文本的预测感动值为:"<<endl;
	for (int i = 10; i < 20; i++) {
		fout << preMoved[i] << " ";
		cout << preMoved[i] << " ";
	}
	fout.close();

	return 0;
}

