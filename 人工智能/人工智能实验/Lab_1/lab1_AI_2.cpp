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
		cout << ")" << endl;
	}

	//计算欧式距离
	float dis, min; //训练文本和测试文本的关系
	int pre[21] = { 0 }; //预测文本与训练文本最相关的文本编号
	cout<<endl<<"训练文本和测试文本的欧氏距离表格:"<<endl;
	cout<<"训练文本:  1    2     3     4     5     6     7     8     9     10"<<endl;
	for (int i = 10; i < 20; i++) { //测试文本
		min = 9999999;
		cout<<"测试文本:";
		for (int j = 0; j < 10; j++) { //各个训练文本
			dis = 0;
			for (int k = 0; k < num2; k++)
				dis += (v[i][k] - v[j][k]) * (v[i][k] - v[j][k]);
			dis=sqrt(dis);
			printf("%.2f  ",dis);
			//cout<<setw(3)<<dis<<" ";
			if (min > dis) {
				min = dis;
				pre[i] = j;
			} else if (min == dis && moved[j] > moved[pre[i]]) {
				pre[i] = j;//遇到欧式距离相同的时候，取感动值大的那个作为预测值
			}
		}
		cout<<endl;
	}
	fstream fout("E:/Desktop/人工智能/人工智能实验/Lab_1/result.txt");
	cout<<endl<<"以上测试文本的预测感动值为:"<<endl;
	for (int i = 10; i < 20; i++) {
		cout << moved[pre[i]] << " ";
		fout << moved[pre[i]] << " ";
	}
	fout.close();

	return 0;
}

