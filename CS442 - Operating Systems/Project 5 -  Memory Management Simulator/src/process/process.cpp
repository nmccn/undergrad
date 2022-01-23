/**
 * This file contains implementations for methods in the Process class.
 *
 * You'll need to add code here to make the corresponding tests pass.
 */

#include "process/process.h"

using namespace std;


Process* Process::read_from_input(std::istream& in) {
    size_t num_bytes = 0;

    Page* page;
    vector<Page*> pages;

    while ((page = Page::read_from_input(in)) != nullptr) {
        pages.push_back(page);
        num_bytes += page->size();
    }

    return new Process(num_bytes, pages);
}


size_t Process::size() const
{
    // TODO
    return this->num_bytes;
}


bool Process::is_valid_page(size_t index) const
{
    // TODO
    if (index >= pages.size()) {
        return false;
    }
    return true;
}


size_t Process::get_rss() const
{
    // TODO
    size_t rss = 0;
    for (size_t i = 0; i < page_table.rows.size(); i++) {
        if (page_table.rows[i].present) {
            rss++;
        }
    }
    return rss;
}


double Process::get_fault_percent() const
{
    // TODO
    double ratio = 0.0;
    if (this->memory_accesses == 0) {
        return 0.0;
    }
    else {
        double num = this->page_faults; double den = this->memory_accesses;
        ratio = (num / den) * 100.0;
        return ratio;
    }
}
