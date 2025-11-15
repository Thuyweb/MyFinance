import '../models/user.dart';

class UserService {
  // Giả lập dữ liệu
  List<User> getUsers() {
    return [
      User(id: '1', name: 'Alice'),
      User(id: '2', name: 'Bob'),
      User(id: '3', name: 'Charlie'),
    ];
  }
}
