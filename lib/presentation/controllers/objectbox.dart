import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../objectbox.g.dart';
import '../screens/books/data/models/ar_hadith_model.dart';
import '../screens/books/data/models/bn_hadith_model.dart';
import '../screens/books/data/models/collection_model.dart';
import '../screens/books/data/models/en_hadith_model.dart';
import '../screens/books/data/models/ur_hadith_model.dart';

class ObjBox {
  late final Store store;

  late final Box<Collection> collectionsBox;

  late final Box<ARHadithModel> arHadithsBox;
  late final Box<ENHadithModel> enHadithsBox;
  late final Box<URHadithModel> urHadithsBox;
  late final Box<BNHadithModel> bnHadithsBox;

  ObjBox._create(this.store) {
    collectionsBox = Box<Collection>(store);
    arHadithsBox = Box<ARHadithModel>(store);
    enHadithsBox = Box<ENHadithModel>(store);
    urHadithsBox = Box<URHadithModel>(store);
    bnHadithsBox = Box<BNHadithModel>(store);
  }

  static Future<ObjBox> create() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final finalPath = join(dir.path, 'objectbox');
    final opendStore = openStore(directory: finalPath);
    return ObjBox._create(opendStore);
  }
}
