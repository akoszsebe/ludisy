import 'package:firebase_database/firebase_database.dart';
import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/data/persitance/dao/base_dao.dart';

abstract class UserDao {
  void setKeepSync(String userId);

  Future<void> insertUser(User user);

  Future<void> insertOrUpdateUser(User user);

  Future<User> getUser(String userId);

  Future<void> updateUser(User userData);
}

class UserDaoImpl extends BaseDao implements UserDao {
  void setKeepSync(String userId){
      // need te be set to make sync only for current user not for all 
  }

  @override
  Future<User> getUser(String userId) async {
    DataSnapshot snapshot = await userRef.child(userId).once();
    userRef.child(userId).keepSynced(true);
    if (snapshot.value != null) {
      return User.fromSnapshot(snapshot);
    } else {
      return null;
    }
  }

  @override
  Future<void> insertUser(User user) async {
    await userRef.child(user.userId).update(user.toJson());
  }

  @override
  Future<void> insertOrUpdateUser(User user) async {
    var savedUser = await getUser(user.userId);
    if (savedUser != null) {
      if (savedUser.userId == user.userId) {
        updateUser(user);
        return;
      }
    }
    await insertUser(user);
  }

  @override
  Future<void> updateUser(User user) async {
    await userRef.child(user.userId).update(user.toJsonWithoutUserId());
  }
}
