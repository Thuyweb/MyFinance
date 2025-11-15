import '../models/user.dart';
import '../services/user_service.dart';

class UserController {
  final UserService _service = UserService();

  List<User> fetchUsers() {
    return _service.getUsers();
  }
}
