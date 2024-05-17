import 'dart:math';

double genRandomNumber(){
  Random random = Random();
  int min = -5000;
  int max = 5000;
  int randomNumber = min + random.nextInt(max - min + 1);

  return randomNumber.toDouble();
}