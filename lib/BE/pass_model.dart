import 'package:hive/hive.dart';

part 'pass_model.g.dart';

@HiveType(typeId: 1)
class pass{
  @HiveField(0)
  String subject;

  @HiveField(1)
  String username;

  @HiveField(2)
  String password;

  pass(this.subject,this.username,this.password);
}