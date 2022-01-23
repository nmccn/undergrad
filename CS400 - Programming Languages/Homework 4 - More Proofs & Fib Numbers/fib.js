// This code was what I used to validate that the inline if statement worked, not super familiar with javascript. Nothing was printed when I run
// the program, but I am fairly confident that it is correct?
/*function fib(x) {
    var b = 0;
    x > 2 ? b = (fib(x-1) + fib(x-2)) : b = 1
    return b;
}

console.log(fib(30)) */

// The code that I would build to match the same type of 'format' as Task 2 would be the following:
(function fib(x) {
    return x > 2 ? (fib(x-1) + fib(x-2)) : 1
})(30)