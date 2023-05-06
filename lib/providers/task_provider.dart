import 'package:get/get.dart';
import 'package:stream/db/db_helper.dart';
import 'package:stream/models/task.dart';

class TaskProvider extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }
}
