import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ludisy/src/di/locator.dart';

class Auth {
  final GoogleSignIn _googleSignIn = locator<GoogleSignIn>();
  final FirebaseAuth _auth = locator<FirebaseAuth>();

  GoogleSignInAccount googleUser;

  Future<FirebaseUser> registerUserWithGoogle() async {
    googleUser = await _googleSignIn.signIn();
    var googleAuth = await googleUser.authentication;

    String authCode = googleAuth.serverAuthCode;

    print("auth  ${googleAuth.toString()}");
    print("serverAuthCode  $authCode");

    var credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var user = (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  Future<FirebaseUser> finishRegistrationAndSignIn() async {
    var googleAuth = await googleUser.authentication;
    var credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    var user = (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  Future<FirebaseUser> isSignedIn() async {
    print("isSignedIn ${_auth.currentUser()}");
    return _auth.currentUser();
  }

  Future<void> signOutOnyFirebase() async {
    await _auth.signOut();
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
