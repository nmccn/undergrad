/**
 * This file contains implementations for methods in the PageTable class.
 *
 * You'll need to add code here to make the corresponding tests pass.
 */

#include "page_table/page_table.h"

using namespace std;


size_t PageTable::get_present_page_count() const {
    // TODO: implement me
    int count = 0;
    for (int i = 0; i < rows.size(); i++) {
        if (rows[i].present) {
            count++;
        }
    }
    return count;
}


size_t PageTable::get_oldest_page() const {
    // TODO: implement me
    size_t index = -1; size_t time = 0;
    for (size_t i = 0; i < rows.size(); i++) {
        if (rows[i].present && index == -1) {
            index = i;
            time = rows[i].loaded_at;
        }
        else if (rows[i].present && rows[i].loaded_at <= time) {
            index = i;
            time = rows[i].loaded_at;
        }
    }
    return index;
}


size_t PageTable::get_least_recently_used_page() const {
    // TODO: implement me
    size_t index = -1; size_t time = 0;
    for (size_t i = 0; i < rows.size(); i++) {
        if (rows[i].present && index == -1) {
            index = i;
            time = rows[i].last_accessed_at;
        }
        else if (rows[i].present && rows[i].last_accessed_at <= time) {
            index = i;
            time = rows[i].last_accessed_at;
        }
    }
    return index;
}
