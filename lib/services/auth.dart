import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User> get user => _auth.authStateChanges();

  Future<UserCredential> signInWithGoogle() async{
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // obtain auth details
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // create new credentials
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, 
      idToken: googleAuth.idToken
    );
    UserCredential result = await _auth.signInWithCredential(credential);
    User user = result.user;
    updateUserData(user);
    // return User 
    return result;
  }

    /// Anonymous Firebase login
  Future<User> anonLogin() async {
    UserCredential result = await _auth.signInAnonymously();
    User user = result.user;

    updateUserData(user);
    return user;
  }

  Future<User> getUser() async {
    return _auth.currentUser;
  }

  void updateUserData(User user) async {
  }

  Future<void> signOut(){
    return _auth.signOut();
  }

}

final AuthService authService = AuthService();