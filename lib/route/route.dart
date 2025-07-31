import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:task_qrcode/features/ocr_scan/models/ocr_task.dart';

class AppRoute {
  static String ocrTask = "/ocrTask";

  static String getOcrTask() => ocrTask;
  static List<GetPage> routes = [GetPage(name: ocrTask, page: () => OCRTask())];
}
