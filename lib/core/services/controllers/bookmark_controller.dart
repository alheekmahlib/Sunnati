import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../features/books/data/models/bookmark_model.dart';
import '../../utils/constants/assets_data.dart';

class BookmarkController extends GetxController {
  var bookmark = <Bookmark>[].obs;
  var box;

  @override
  void onInit() async {
    super.onInit();
    fetchPersons();
    if (!Hive.isBoxOpen('bookmark')) {
      box = await Hive.openBox<Bookmark>('bookmark');
    } else {
      box = Hive.box<Bookmark>('bookmark');
    }
  }

  void fetchPersons() {
    final box = Hive.box<Bookmark>(AssetsData.bookmarkBox);
    bookmark.value = box.values.toList();
    // Listen for changes and update the persons list accordingly
    box.watch().listen((event) {
      bookmark.value = box.values.toList();
    });
  }
}
