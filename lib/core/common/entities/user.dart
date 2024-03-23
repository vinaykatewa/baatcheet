// ignore_for_file: public_member_api_docs, sort_constructors_first

//this was previously in auth domain,
//but we want to use it in cubit of core and core can't use other class
//but other class in the app can use core, so we moved this entities folder in the core
class User {
  final String id;
  final String email;
  final String name;

  User({
    required this.id,
    required this.email,
    required this.name,
  });
}
