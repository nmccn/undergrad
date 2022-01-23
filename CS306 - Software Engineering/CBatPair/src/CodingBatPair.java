//Authors: Nicholas McClellan & Benjamin Jessing
import java.util.*;


public class CodingBatPair {

	public static boolean evenlySpaced(int a, int b, int c) {

		// x y z is ordered a b c
		ArrayList<Integer> orderedList = new ArrayList<Integer>();
		orderedList.add(a);
		orderedList.add(b);
		orderedList.add(c);
		Collections.sort(orderedList);

		Integer x = orderedList.get(0);
		Integer y = orderedList.get(1);
		Integer z = orderedList.get(2);


		if (y-x == z-y) {
			return true;
		} else return false;
	}
	
	/*
	evenlySpaced(2, 4, 6) → true	true	OK	
	evenlySpaced(4, 6, 2) → true	true	OK	
	evenlySpaced(4, 6, 3) → false	false	OK	
	evenlySpaced(6, 2, 4) → true	true	OK	
	evenlySpaced(6, 2, 8) → false	false	OK	
	evenlySpaced(2, 2, 2) → true	true	OK	
	evenlySpaced(2, 2, 3) → false	false	OK	
	evenlySpaced(9, 10, 11) → true	true	OK	
	evenlySpaced(10, 9, 11) → true	true	OK	
	evenlySpaced(10, 9, 9) → false	false	OK	
	evenlySpaced(2, 4, 4) → false	false	OK	
	evenlySpaced(2, 2, 4) → false	false	OK	
	evenlySpaced(3, 6, 12) → false	false	OK	
	evenlySpaced(12, 3, 6) → false	false	OK	
	*/

	public String plusOut(String str, String word) {
		//char to store first letter;
		char first = word.charAt(0);
		//int for word length (to reduce repetitive code)
		int wordLength = word.length();
		
		//go from string to char array
		char[] charArray = str.toCharArray();
		//iterate thru the array in search of word
		for(int i = 0; i < charArray.length; i++) {
			//if the first letter of word is found, keep checking
			if(charArray[i] == first) {
				//check that the rest is there
				for(int j = 1; j < wordLength; j++) {
					//check if at the last letter and a match
					if(charArray[i+j] == word.charAt(j) && j == wordLength - 1) {
						i = i + wordLength-1;
						break;
					}
					//if the next letter is there keep going
					else if(charArray[i+j] == word.charAt(j)) {
						continue;
					}
					//this isnt the word and as such should be +
					else {
						charArray[i] = '+';
						break;
					}
				}

			}
			//all other letters (not found in the upper loop) will result in a +
			else {
				charArray[i] = '+';
			}
		}
		str = new String(charArray);
		return str;
	}
	
	/*
	plusOut("12xy34", "xy") → "++xy++"	"++xy++"	OK	
	plusOut("12xy34", "1") → "1+++++"	"1+++++"	OK	
	plusOut("12xy34xyabcxy", "xy") → "++xy++xy+++xy"	"++xy++xy+++xy"	OK	
	plusOut("abXYabcXYZ", "ab") → "ab++ab++++"	"ab++ab++++"	OK	
	plusOut("abXYabcXYZ", "abc") → "++++abc+++"	"++++abc+++"	OK	
	plusOut("abXYabcXYZ", "XY") → "++XY+++XY+"	"++XY+++XY+"	OK	
	plusOut("abXYxyzXYZ", "XYZ") → "+++++++XYZ"	"+++++++XYZ"	OK	
	plusOut("--++ab", "++") → "++++++"	"++++++"	OK	
	plusOut("aaxxxxbb", "xx") → "++xxxx++"	"++xxxx++"	OK	
	plusOut("123123", "3") → "++3++3"	"++3++3"	OK	
	other tests OK
	*/

	public int countClumps(int[] nums) {
		if(nums.length == 0) return 0;
		int clumpCount = 0;
		int newElem = nums[0];
		int newElemIndex = 0;
		for(int i = 0; i < nums.length; i++) {
			if(nums[i] != newElem) {
				newElem = nums[i];
				newElemIndex = i;
			} else if(nums[i] == newElem) {
				if(i-1 == newElemIndex) clumpCount++;
			}
		} return clumpCount;
	}

	/*	
	countClumps([1, 2, 2, 3, 4, 4]) → 2	2	OK	
	countClumps([1, 1, 2, 1, 1]) → 2	2	OK	
	countClumps([1, 1, 1, 1, 1]) → 1	1	OK	
	countClumps([1, 2, 3]) → 0	0	OK	
	countClumps([2, 2, 1, 1, 1, 2, 1, 1, 2, 2]) → 4	4	OK	
	countClumps([0, 2, 2, 1, 1, 1, 2, 1, 1, 2, 2]) → 4	4	OK	
	countClumps([0, 0, 2, 2, 1, 1, 1, 2, 1, 1, 2, 2]) → 5	5	OK	
	countClumps([0, 0, 0, 2, 2, 1, 1, 1, 2, 1, 1, 2, 2]) → 5	5	OK	
	countClumps([]) → 0	0	OK	
	other tests OK		
	*/

	public int[] fix34(int[] nums) {
		//integer to do the swapping
		int temp;
		//loop thru the array
		for(int i = 0; i < nums.length; i++) {
			//if the number at index i is a 3, and the following number is not a 4
			if(nums[i] == 3 && nums[i+1] != 4) {
				//find an available 4 and swap.
				for(int j = 0; j < nums.length; j++) {
					if(nums[j] == 4 && nums[j-1] != 3) {
						//set temp
						temp = nums[i+1];
						//set i->j
						nums[i+1] = nums[j];
						//set j->i (temp)
						nums[j] = temp;		  
					}
				}

			}
			//all other numbers
			else {
				continue;
			}
		}
	}
}
	/*
	fix34([1, 3, 1, 4]) → [1, 3, 4, 1]	[1, 3, 4, 1]	OK	
	fix34([1, 3, 1, 4, 4, 3, 1]) → [1, 3, 4, 1, 1, 3, 4]	[1, 3, 4, 1, 1, 3, 4]	OK	
	fix34([3, 2, 2, 4]) → [3, 4, 2, 2]	[3, 4, 2, 2]	OK	
	fix34([3, 2, 3, 2, 4, 4]) → [3, 4, 3, 4, 2, 2]	[3, 4, 3, 4, 2, 2]	OK	
	fix34([2, 3, 2, 3, 2, 4, 4]) → [2, 3, 4, 3, 4, 2, 2]	[2, 3, 4, 3, 4, 2, 2]	OK	
	fix34([5, 3, 5, 4, 5, 4, 5, 4, 3, 5, 3, 5]) → [5, 3, 4, 5, 5, 5, 5, 5, 3, 4, 3, 4]	[5, 3, 4, 5, 5, 5, 5, 5, 3, 4, 3, 4]	OK	
	fix34([3, 1, 4]) → [3, 4, 1]	[3, 4, 1]	OK	
	fix34([3, 4, 1]) → [3, 4, 1]	[3, 4, 1]	OK	
	fix34([1, 1, 1]) → [1, 1, 1]	[1, 1, 1]	OK	
	fix34([1]) → [1]	[1]	OK	
	fix34([]) → []	[]	OK	
	fix34([7, 3, 7, 7, 4]) → [7, 3, 4, 7, 7]	[7, 3, 4, 7, 7]	OK	
	fix34([3, 1, 4, 3, 1, 4]) → [3, 4, 1, 3, 4, 1]	[3, 4, 1, 3, 4, 1]	OK	
	fix34([3, 1, 1, 3, 4, 4]) → [3, 4, 1, 3, 4, 1]	[3, 4, 1, 3, 4, 1]	OK	
	other tests OK
	*/
