import 'package:hive/hive.dart';
import 'package:reco_restaurant/core/constants/hive_type_ids.dart';
import '../../domain/entities/user_entity.dart';

part 'user_mode.g.dart';

@HiveType(typeId: HiveTypeId.authUser)
class UserModel {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String email;

  const UserModel({required this.uid, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(uid: map['uid'] ?? '', email: map['email'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email};
  }

  UserEntity toEntity() => UserEntity(uid: uid, email: email);

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(uid: entity.uid, email: entity.email);
  }
}
