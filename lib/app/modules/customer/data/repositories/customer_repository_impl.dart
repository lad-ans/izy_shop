import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../domain/entities/logged_user.dart';
import '../../domain/repositories/customer_repository.dart';
import '../models/customer_model.dart';

part 'customer_repository_impl.g.dart';

@Injectable()
class CustomerRepositoryImpl implements CustomerRepository {
  FirebaseFirestore firestore;
  CustomerRepositoryImpl({
    this.firestore,
  });
  @override
  Stream<CustomerModel> getLoggedCustomer() {
    try {
      return firestore
          .collection('customers')
          .doc(LoggedUser.instance.loggedUserUid)
          .snapshots()
          .map(
            (snap) => CustomerModel.fromDocument(snap),
          );
    } catch (e) {
      print(e.toString());
      return e;
    }
  }
}
