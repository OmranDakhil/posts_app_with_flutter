import 'package:hive/hive.dart';
part 'post.g.dart';
@HiveType(typeId: 0)
class Post extends HiveObject{
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;

  Post({ this.id, required this.title, required this.body});
}