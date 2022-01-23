/**
 * This file contains implementations for methods in the Frame class.
 *
 * You'll need to add code here to make the corresponding tests pass.
 */

#include "frame/frame.h"

using namespace std;

void Frame::set_page(Process* process, size_t page_number) {
    // TODO: implement me
    this->page_number = page_number;
    this->process = process;
    // Do I need more logic here, or is this always the case (?)
    this->contents = process->pages[1];
}
