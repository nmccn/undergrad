#ifndef _Queue_h
#define _Queue_h



#include <string>
#include <iostream>
#include <cstdlib>

/*
    Queue.h

    A working implementation of a fixed-size circular queue
    meeting the requirements of the Queue, part 1 lab.  Use
    or replace as you wish.
*/

template <class T>
class Queue {
public:
	// constructor
	Queue() {
		_front = 0;
		_back = 0;
		_size = 0;
		_capacity = 2;
		_data = new T[_capacity];
	}

	// enqueue: add a char to the end of the queue if room and return true;
	// if not enough room, return false
	bool enqueue(T c) {
		if (_size == _capacity) {
			//double capacity
			_capacity = _capacity * 2;
			//reset front index
			//_front = 0;
			//create new array with this size
			_tempData = new T[_capacity];
			//for each value in the array
			for(int i = 0; i < _size; i++){
				//copy the values over to the newly sized array
				_tempData[i] = _data[i];
			}
			//delete the old array
			delete[] _data;
			//make the pointer go to the new array
			_data = _tempData;


			//normal behavior
			_data[_back] = c;
			_back++;
			_back = _back % _capacity;
			_size++;
			return true;
		}
		else {
			_data[_back] = c;
			_back++;
			_size++;
			return true;
		}
	}

	// dequeue: if queue is not empty, remove the front element from the queue;
	// if queue is empty, return false and do nothing.
	bool dequeue()  {
		if (is_empty()) {
			return false;
		}
		else {
			_front++;
			_size--;
			return true;
		}
	}

	// front: return the front element in the queue
	char front(){
		return _data[_front];
	}

	// is_empty: return whether or not the queue is empty
	bool is_empty() {
		return _size == 0;
	}

	int size() {
		return _size;
	}

	////BIG THREE////
	//destructor
	~Queue(){
		delete[] _data;
	}
	//copy constructor
	Queue(const Queue& q){
		//copy / set all member variables
		_capacity = q._capacity;
		_size = q._size;
		_front = q._front;
		_back = q._back;

		//allocate new memory
		_data = new T[_capacity];

		//copy the values
		for(int i = 0; i < _size; i++){
			_data[i] = q._data[i];
		}
	}
	//assignment operator
	Queue& operator=(const Queue& q){
		//self assignment check
		if(this == &q) return *this;
		//clean up old memory
		delete[] _data;
		//copy all non pointer member variables
		_capacity = q._capacity;
		_size = q._size;
		_front = q._front;
		_back = q._back;

		//allocate new memory
		_data = new T[_capacity];

		//copy the old array
		for(int i = 0; i < _size; i++){
			_data[i] = q._data[i];
		}

		//return this
		return *this;
	}


private:
	T* _data;
	T* _tempData;
	int  _size;
	int  _front;
	int  _back;
	int  _capacity;
};

#endif

