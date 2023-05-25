import 'dart:io';

void main() {
  performTasks();
}

void performTasks()  async{
  task1();
  String task2Result =await task2(); //wait task2 to bring the answer
  task3 (task2Result);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2() async {
  String result="";
  Duration threeSeconds = const Duration(seconds: 3);
  // sleep(threeSeconds); //sleep 3 seconds then excute next line

  await Future.delayed(threeSeconds,(){
     result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;

}

void task3(String task2Data) {
  String result = 'task 3 data';
  print('Task 3 complete with $task2Data');
}