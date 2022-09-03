import 'package:hive/hive.dart';
part 'db.g.dart';

@HiveType(typeId: 0)
class NamesBillard extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String isdone;
  NamesBillard({required this.name, required this.isdone});
}

@HiveType(typeId: 1)
class pesPost extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String numberofplayers;
  pesPost({required this.name, required this.numberofplayers});
}

@HiveType(typeId: 2)
class credit extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String amount;
  @HiveField(2)
  late String date;

  credit({required this.name, required this.amount, required this.date});
}
