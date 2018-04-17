#include<bits/stdc++.h>
using namespace std;
char data[] = "Dataset.txt";
typedef vector<string> Vector;
typedef vector<vector<string> > nestVec;
typedef map<string, vector<string> > vMap;
typedef map<string, int> StrIntMap;

int row_of_tests = 0, row_of_trains = 0;
StrIntMap word_to_int, attr_to_int, is_used;
nestVec Trains, Tests; //用于记录每一行的文本
Vector attrName; //用于记录属性的名字
vMap node;

struct Node {
	string s;
	map<string, Node*> child;
};

void read_file(char *FileName);
void change();
int C4_5(nestVec data, StrIntMap is_used);
string judge_leaf(nestVec data);
void build(Node* &root, nestVec data, StrIntMap is_used);
string predict(Vector data, Node *root);
void print(Node *root);
void printTree(Node* root);
int main() {
	cout << "begin for DT_C4.5" << endl;
	change();
	Node *root;
	build(root, Trains, is_used);
	print(root);
	printTree(root);
	cout << "end for DT_C4.5" << endl;
	return 0;
}

void read_file(char *FileName) {
	ifstream fin(FileName);
	stringstream sin;
	string line, attribute;
	getline(fin, line);
	sin << line;
	while (!sin.eof()) {
		sin >> attribute;
		attrName.push_back(attribute);
	}
	while (!fin.eof()) { //一行一行读取文本
		getline(fin, line);
		stringstream ssin;
		ssin << line;
		Vector tmpV;
		Vector::iterator it = attrName.begin();
		while (!ssin.eof()) {
			ssin >> attribute;
			tmpV.push_back(attribute);
			if (!ssin.eof()) { //将文本的属性值进行学习出来
				if (find(node[*it].begin(), node[*it].end(), attribute)
						== node[*it].end()) {
					node[*it].push_back(attribute);
				}
				it++;
			} else {
				if (attribute == "?") {
					Tests.push_back(tmpV);
					row_of_tests++;
				} else {
					Trains.push_back(tmpV);
					row_of_trains++;
				}
			}
		}
	}
	cout << "row_of_trains=" << row_of_trains << endl;
	cout << "row_of_tests=" << row_of_tests << endl;
}

void change() {
	read_file(data);
	Vector::iterator it = attrName.begin();
	int i = 0;
	for (; it != attrName.end(); it++) {
		attr_to_int[*it] = i++;
		is_used[*it] = 0;
	}
}

int C4_5(nestVec data, StrIntMap is_used) {
	int row = data.size();
	int select_col = -1;
	int col = data[0].size();
	map<string, double> D;
	//计算d的熵值
	for (int i = 0; i < row; i++) {
		if (D.find(data[i][col - 1]) != D.end()) {
			D[data[i][col - 1]]++; //若之前存在这个属性，直接++；
		} else {
			D[data[i][col - 1]] = 1; //初始化属性值。
		}
	}
	double HD = 0; //H(D)
	map<string, double>::iterator it;
	for (it = D.begin(); it != D.end(); it++) {
		HD += -1 * D[it->first] * 1.0 / row * log2(D[it->first] * 1.0 / row);
	}
	//计算Gain(D;A);
	double GainDA = 0;
	for (int i = 0; i < col - 1; i++) {
		if (is_used[attrName[i]] == 1)
			continue;
		map<string, double> A;
		for (int j = 0; j < row; j++) {
			if (A.find(data[j][i]) != A.end()) {
				A[data[j][i]]++;
			} else {
				A[data[j][i]] = 1;
			}
		}
		double HDA = 0; //计算条件熵值
		for (map<string, double>::iterator it = A.begin(); it != A.end();
				it++) {
			map<string, double> AD;
			double rowA_sum = 0;
			for (int j = 0; j < row; j++) {
				if (data[j][i] == it->first) {
					if (AD.find(data[j][col - 1]) != AD.end()) {
						AD[data[j][col - 1]]++;
					} else {
						AD[data[j][col - 1]] = 1;
					}
					rowA_sum++;
				}
			}
			for (map<string, double>::iterator it_AD = AD.begin();
					it_AD != AD.end(); it_AD++) {
				HDA += A[it->first] / row * (-1 * AD[it_AD->first] / rowA_sum)
						* log2(AD[it_AD->first] / rowA_sum);
			}
		}

		//A的熵值
		double HA = 0;
		for (map<string, double>::iterator it = A.begin(); it != A.end();
				it++) {
			HA += -1 * (it->second) / row * log2((it->second) / row);
		}
		double ratio = (HD - HDA) / HA;
		cout<<"GainRatio="<<ratio<<endl;
		//选择ratio最大的那个数作为节点
		if (GainDA < ratio) {
			GainDA = HD - HDA;
			select_col = i;
			//cout<<"GainRatio="<<ratio<<endl;
		}
	}
	return select_col;
}
string judge_leaf(nestVec data) {
	int row = data.size();
	int col = data[0].size();
	StrIntMap D_num;
	for (int i = 0; i < row; i++) {
		if (D_num.find(data[i][col - 1]) != D_num.end()) {
			D_num[data[i][col - 1]]++;
		} else {
			D_num[data[i][col - 1]] = 1;
		}
	}
	string res;
	int max_num = -1;
	for (StrIntMap::iterator it = D_num.begin(); it != D_num.end(); it++) {
		if (it->second > max_num) {
			res = it->first;
			max_num = it->second;
		}
	}
	return res;
}
void build(Node * &root, nestVec data, StrIntMap is_used) {
	StrIntMap res;
	int col = data[0].size();
	int rows = data.size();
	for (int i = 0; i < rows; i++) {
		if (res.find(data[i][col - 1]) != res.end()) {
			res[data[i][col - 1]]++;
		} else
			res[data[i][col - 1]] = 1;
	}
	if (res.size() == 1) {
		root = new Node;
		root->s = data[0][col - 1];
		return;
	}
	int select_col = C4_5(data, is_used);
	if (select_col == -1) {
		root = new Node;
		root->s = judge_leaf(data);
		return;
	} else {
		string selected_attribute = attrName[select_col];
		is_used[selected_attribute] = 1;
		root = new Node;
		root->s = selected_attribute;
		int child_size = node[selected_attribute].size();
		nestVec temp_data[child_size];
		int j = 0;
		for (Vector::iterator it2 = node[selected_attribute].begin();
				it2 != node[selected_attribute].end(); it2++, j++) {
			int rows = data.size();
			for (int i = 0; i < rows; i++) {
				if (data[i][select_col] == *it2) {
					temp_data[j].push_back(data[i]);
				}
			}
		}
		int real_child = 0;
		for (j = 0; j < child_size; j++) {
			if (temp_data[j].size() != 0) {
				real_child++;
			}
		}
		if (real_child > 1) {
			j = 0;
			for (Vector::iterator it2 = node[selected_attribute].begin();
					it2 != node[selected_attribute].end(); it2++, j++) {
				if (temp_data[j].size() == 0) {
					root->child[*it2] = new Node;
					root->child[*it2]->s = judge_leaf(data);
				} else {
					root->child[*it2] = NULL;
					build(root->child[*it2], temp_data[j], is_used);
				}
			}
		} else {
			root->s = judge_leaf(data);
		}
		is_used[selected_attribute] = 0;
	}
}

string predict(Vector data, Node *root) {
	if (root->child.size() == 0) {
		return root->s;
	} else {
		string s1 = data[attr_to_int[root->s]];
		return predict(data, root->child[s1]);
	}
}
void print(Node * root) {
	for (int i = 0; i < row_of_tests; i++) {
		cout << "t" << i << ": " << predict(Tests[i], root) << endl;
	}
}

void printTree(Node * root) {
	if (root->child.size() == 0) {
		cout << root->s << endl;
	} else {
		cout << root->s << endl;
		for (vector<string>::iterator it = node[root->s].begin();
				it != node[root->s].end(); it++) {
			cout << *it << "-";
			printTree(root->child[*it]);
		}
	}
}
