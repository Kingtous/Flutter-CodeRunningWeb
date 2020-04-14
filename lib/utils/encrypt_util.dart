import 'dart:convert';
import 'package:code_running_front/application/application.dart';
import 'package:encrypt/encrypt.dart';

class EncryptUtil {
  var iv = IV.fromLength(16);
  Key b64key;

  // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
  Fernet fernet;
  Encrypter encrypter;

  EncryptUtil() {
    iv = IV.fromLength(16);
    b64key = Key.fromUtf8(base64Url.encode(Application.encryptKey.bytes));
    // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
    fernet = Fernet(b64key);
    encrypter = Encrypter(fernet);
  }

  Encrypted encrypt(String input) {
    return encrypter.encrypt(input, iv: iv);
  }

  String decrypt(Encrypted encrypted) {
    return encrypter.decrypt(encrypted, iv: iv);
  }
}
