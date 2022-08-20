import 'package:hive/hive.dart';

part 'NewThing.g.dart';

@HiveType(typeId: 0)
class NewThing extends HiveObject {
  @HiveField(0)
  late String thingMyTitle;
  @HiveField(1)
  late String thingMySubTitle;
  @HiveField(2)
  late String thingMyCount;
}
