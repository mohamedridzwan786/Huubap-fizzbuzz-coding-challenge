import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Listed all the numbers from 1 to 1000 and replaced numbers divisible by 3 with Fizz, numbers divisible by 5 with Buzz and numbers divisible by both 3 & 5 with FizzBuzz.", () {
    for (var i = 1; i <= 1000; i ++) {
      if (i % 15 == 0) {
        print("FizzBuzz");
      }
      else if (i % 3 == 0) {
        print("Fizz");
      }
      else if (i % 5 == 0) {
        print("Buzz");
      }
      else {
        print(i);
      }
    }
  });
}
