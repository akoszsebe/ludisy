import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/data/persitance/dao/base_dao.dart';

abstract class UserDao {
  Future<void> insertUser(User user);

  Future<void> insertOrUpdateUser(User user);

  Future<void> deleteUser(User user);

  Future<User> getUser();
}

class UserDaoImpl extends BaseDao implements UserDao {
  @override
  Future<User> getUser() async {
    var result = await appDatabase.findFirst({});
    if (result != null) {
      return User.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<void> insertUser(User user) async {
    await appDatabase.insert(user.toJson());
  }

  @override
  Future<void> deleteUser(User user) async {
    await appDatabase.delete(user.toJsonJustUserId());
  }

  @override
  Future<void> insertOrUpdateUser(User user) async {
    var savedUser = await getUser();
    if (savedUser != null) {
      if (savedUser.userId == user.userId) {
        await appDatabase.update(
            user.toJsonJustUserId(), user.toJsonWithoutUserId());
        return;
      } else {
        await deleteUser(user);
      }
    }
    await insertUser(user);
  }
}
