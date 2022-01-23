#include "types/burst/burst.hpp"

#include <cassert>
#include <stdexcept>

Burst::Burst(BurstType type, int length)
{
    // TODO
    this->burst_type = type;
    this->length = length;
}

void Burst::update_time(int delta_t)
{
    // TODO
    this->length -= delta_t;
}
