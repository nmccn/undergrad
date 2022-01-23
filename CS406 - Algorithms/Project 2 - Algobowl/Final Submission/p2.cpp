#include <iostream>
#include <vector>
#include <queue>
#include <set>
#include <fstream>
using namespace std;

set<uint64_t> readInput(char* input, vector<uint64_t>* c);
vector<uint64_t> calculate(set<uint64_t>* values, vector<uint64_t> computed);

int main(int argc, char* argv[]) {

    vector<uint64_t> computed;
    set<uint64_t> values = readInput(argv[1], &computed);
    values.insert(1);
    set<uint64_t> available;
    available.insert(1);

    if (computed[computed.size() - 1] != 2) {
        computed.push_back(2);
    }

    vector<uint64_t> nums = calculate(&values, computed);
    cout << nums.size() << endl;

    cout << 1 << " + " << 1 << " = " << 1 + 1 << endl;
    available.insert(2);

    for (int i = nums.size() - 2; i >= 0; i--) {
        for (set<uint64_t>::iterator j = available.begin(); j != available.end(); j++) {
            uint64_t temp = nums[i] - *j;
            if (available.count(temp)) {
                cout << *j << " + " << temp << " = " << *j + temp << endl;
                available.insert((*j + temp));
                break;
            }
        }
    }
}

set<uint64_t> readInput(char* input, vector<uint64_t>* computed) {
    set<uint64_t> values;
    ifstream file(input);
    uint64_t temp;

    while (file >> temp) {
        values.insert(temp);
        computed->insert(computed->begin(), temp);
    }

    return values;
}

vector<uint64_t> calculate(set<uint64_t>* values, vector<uint64_t> c) {
    int i = 0;
    uint64_t value;
    vector<uint64_t> computed = c;
    bool extra = false;
    int amount = 0;

    while (true) {
        if (i == computed.size() - 1) {
            break;
        }

        if (computed[i] % 2 == 0 && values->count(computed[i] / 2)) {
            i++;
            continue;
        }

        if ((computed[i] % 2 && computed[i]/2 == computed[i + 1]) || computed[i]/2 > computed[i + 1]) {
            value = computed[i]/2;
            if (computed[i] % 2 == 1) {
                value += 1;
                amount = 1;
                extra = true;
            }
        }
        else if (computed[i]/2 < computed[i + 1]) {
            for (int j = i + 1; j < computed.size(); j++) {
                if (values->count(computed[i] - computed[j])) {
                    value = computed[i] - computed[j];
                    break;
                }
                else if (!values->count(computed[i] - computed[j]) && j == computed.size() - 1) {
                    value = computed[i] - computed[i + 1];
                }
            }
        }

        // if (!values->count(value) && computed[i] % 3 == 0) {
        //     value = 2 * computed[i] / 3;
        //     if (values->count(computed[i] / 3)){
        //         extra = false;
        //     }
        //     else {
        //         extra = true;
        //         amount = computed[i] / 3;
        //     }
        // }

        if (!values->count(value)) {
            for (int j = i + 1; j < computed.size(); j++) {
                if (value > computed[j]) {
                    computed.insert(computed.begin() + j, value);
                    if (!extra) {
                        break;
                    }
                    values->insert(value);
                    value -= amount;
                    if (values->count(value)) {
                        break;
                    }
                    extra = false;
                }
                else if ((value < computed[j]) && (j == computed.size() - 1)) {
                    computed.push_back(value);
                    if (!extra) {
                        break;
                    }
                    values->insert(value);
                    value -= amount;
                    if (values->count(value)) {
                        break;
                    }
                    extra = false;
                }
            }
            values->insert(value);
        }
        i++;
    }
    return computed;
}