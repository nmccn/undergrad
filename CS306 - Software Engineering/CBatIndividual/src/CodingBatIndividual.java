//Author: Nicholas McClellan
//Date: January 16th, 2020
public class CodingBatIndividual {
	//Problem "AP-1" scoresIncreasing SOLUTION:
	public boolean scoresIncreasing(int[] scores) {
  		//for each number in the array (accounting for the last number with -1)
		for(int i = 0; i < scores.length-1; i++) {
			//if the number is lower -> return false
			if(scores[i] > scores[i+1]) {
				return false;
			}
		}
		return true;
	}
	//RESULTS:
	/*
	Expected	Run		
	scoresIncreasing([1, 3, 4]) → true	true	OK	
	scoresIncreasing([1, 3, 2]) → false	false	OK	
	scoresIncreasing([1, 1, 4]) → true	true	OK	
	scoresIncreasing([1, 1, 2, 4, 4, 7]) → true	true	OK	
	scoresIncreasing([1, 1, 2, 4, 3, 7]) → false false	OK	
	scoresIncreasing([-5, 4, 11]) → true true	OK
	*/
	
	//Problem "Array-2" tenRun SOLUTION:
	public int[] tenRun(int[] nums) {
		//int to hold the current multiple of 10 to us
		int multOfTen = -1;
		//for each number in the array
		for(int i = 0; i < nums.length; i ++) {
			//if the number isn't a multiple of 10
			if(nums[i] % 10 == 0) {
				multOfTen = nums[i];
			}
			//if the number isn't a multiple of 10, and there hasn't been one prior.
			else if(nums[i] % 10 != 0 && multOfTen == -1){
				continue;
			}
			//no *10 found yet an 
			else {
				nums[i] = multOfTen;
			}
		}
		return nums;
	}
	//RESULTS:
	/*
	tenRun([2, 10, 3, 4, 20, 5]) → [2, 10, 10, 10, 20, 20]	[2, 10, 10, 10, 20, 20]	OK	
	tenRun([10, 1, 20, 2]) → [10, 10, 20, 20]	[10, 10, 20, 20]	OK	
	tenRun([10, 1, 9, 20]) → [10, 10, 10, 20]	[10, 10, 10, 20]	OK	
	tenRun([1, 2, 50, 1]) → [1, 2, 50, 50]	[1, 2, 50, 50]	OK	
	tenRun([1, 20, 50, 1]) → [1, 20, 50, 50]	[1, 20, 50, 50]	OK	
	tenRun([10, 10]) → [10, 10]	[10, 10]	OK	
	tenRun([10, 2]) → [10, 10]	[10, 10]	OK	
	tenRun([0, 2]) → [0, 0]	[0, 0]	OK	
	tenRun([1, 2]) → [1, 2]	[1, 2]	OK	
	tenRun([1]) → [1]	[1]	OK	
	tenRun([]) → []	[]	OK	
	other tests
	OK
	*/
	
	//Problem "String-2" repeatEnd SOLUTION:
	public String repeatEnd(String str, int n) {
		//create a substring of the amount of characters needed
		String strRepeated = str.substring(str.length()-n);
		//replace the input str with a new blank string.
		str = "";
		//concatenate n times
		for(int i = 0; i < n; i++) {
			str += strRepeated;
		}
		return str;
	}
	//RESULTS:
	/*
	repeatEnd("Hello", 3) → "llollollo"	"llollollo"	OK	
	repeatEnd("Hello", 2) → "lolo"	"lolo"	OK	
	repeatEnd("Hello", 1) → "o"	"o"	OK	
	repeatEnd("Hello", 0) → ""	""	OK	
	repeatEnd("abc", 3) → "abcabcabc"	"abcabcabc"	OK	
	repeatEnd("1234", 2) → "3434"	"3434"	OK	
	repeatEnd("1234", 3) → "234234234"	"234234234"	OK	
	repeatEnd("", 0) → ""	""	OK	
	other tests
	OK
	*/
	
	//Problem "Array-3" canBalance SOLUTION:
	public boolean canBalance(int[] nums) {
		//variables for the left and right hand sides of the array
		int LHS = 0;
		//nested loops to check every different "cut" so to speak
		//outer loop will calculate the sum from the left
		for(int i = 0; i < nums.length; i++) {
			//add the current index
			LHS += nums[i];
			int RHS = 0;
			//find the sum from the right
			for(int j = nums.length-1; j > i; j--) {
				RHS += nums[j];
			}
			if(LHS == RHS) {
				return true;
			}
		}
		return false;
	}
	//RESULTS:
	/*
	canBalance([1, 1, 1, 2, 1]) → true	true	OK	
	canBalance([2, 1, 1, 2, 1]) → false	false	OK	
	canBalance([10, 10]) → true	true	OK	
	canBalance([10, 0, 1, -1, 10]) → true	true	OK	
	canBalance([1, 1, 1, 1, 4]) → true	true	OK	
	canBalance([2, 1, 1, 1, 4]) → false	false	OK	
	canBalance([2, 3, 4, 1, 2]) → false	false	OK	
	canBalance([1, 2, 3, 1, 0, 2, 3]) → true	true	OK	
	canBalance([1, 2, 3, 1, 0, 1, 3]) → false	false	OK	
	canBalance([1]) → false	false	OK	
	canBalance([1, 1, 1, 2, 1]) → true	true	OK	
	other tests
	OK
	*/
}
	


