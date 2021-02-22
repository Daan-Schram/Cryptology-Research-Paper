import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profielwerkstuk_cryptologie/aes_cbc_page.dart';
import 'package:profielwerkstuk_cryptologie/cryptanalysis_page.dart';
import 'package:profielwerkstuk_cryptologie/gcd_page.dart';
import 'package:profielwerkstuk_cryptologie/md-245_page.dart';
import 'package:profielwerkstuk_cryptologie/millerrabin_test_page.dart';
import 'package:profielwerkstuk_cryptologie/prime_factors_page.dart';
import 'package:profielwerkstuk_cryptologie/qr_code_page.dart';
import 'package:profielwerkstuk_cryptologie/vigenere_page.dart';
import 'home_page.dart';
import 'constants.dart';
import 'package:profielwerkstuk_cryptologie/info_page.dart';
import 'package:profielwerkstuk_cryptologie/caesar_page.dart';
import 'package:profielwerkstuk_cryptologie/constants.dart';
import 'package:profielwerkstuk_cryptologie/historic_ciphers.dart';
import 'package:profielwerkstuk_cryptologie/home_page.dart';
import 'package:profielwerkstuk_cryptologie/pdf_viewer_page.dart';
import 'package:profielwerkstuk_cryptologie/settings_page.dart';
import 'package:profielwerkstuk_cryptologie/paper_page.dart';
import 'modern_ciphers_page.dart';
import 'hashing_tools_page.dart';
import 'mathematics_tools_page.dart';
import 'encoding_tools_page.dart';
import 'secure_encryption_tools_page.dart';
import 'sha-1_page.dart';
import 'sha-2_page.dart';
import 'sha-3_page.dart';
import 'package:profielwerkstuk_cryptologie/binary.dart';
import 'package:profielwerkstuk_cryptologie/Hexadecimal.dart';
import 'package:profielwerkstuk_cryptologie/primality_test_page.dart';
import 'prime_list_page.dart';
import 'aes_ctr_page.dart';
import 'aes_gcm_page.dart';
import 'brute_force_caesar.dart';
import 'chacha20_page.dart';
import 'mac.dart';
import 'hmac_sha2_page.dart';
import 'hmac_sha1_page.dart';
import 'hmac_blake_page.dart';
import 'gcd_page.dart';


void main() => runApp(CryptologyProfilePaper());

class CryptologyProfilePaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: kTextColor,
        fontFamily: 'Quicksand',
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/info': (context) => InfoPage(),
        '/paper': (context) => PaperPage(),
        '/pdfviewer': (context) => PdfViewerPage(),
        '/settings': (context) => SettingsPage(),
        '/historic': (context) => HistoricCiphers(),
        '/modern': (context) => ModernCiphersPage(),
        '/cryptanalysis': (context) => CryptanalysisPage(),
        '/hashing': (context) => HashingToolsPage(),
        '/mathematics': (context) => MathematicsToolsPage(),
        '/encoding': (context) => EncodingToolsPage(),
        '/secure encryption': (context) => SecureEncryptionToolsPage(),
        '/mac': (context) => MAC(),
        '/hmacsha2': (context) => HmacSha2(),
        '/hmacsha1': (context) => HmacSha1(),
        '/hmacblake': (context) => HmacBlake(),
        '/caesar': (context) => CaesarPage(),
        '/vigenere': (context) => VigenerePage(),
        '/SHA1': (context) => SHA1Page(),
        '/SHA2': (context) => SHA2Page(),
        '/SHA3': (context) => SHA3Page(),
        '/MD': (context) => MDPage(),
        '/QRCode': (context) => QRCodePage(),
        '/aesCBC': (context) => AESPageCBC(),
        '/aesCTR': (context) => AESPageCTR(),
        '/aesGCM': (context) => AESPageGCM(),
        '/binary': (context) => Binary(),
        '/hexadecimal': (context) => Hexadecimal(),
        '/primetest': (context) => PrimeTestPage(),
        '/primelist': (context) => PrimeListPage(),
        '/primefactors': (context) => PrimeFactorsPage(),
        '/millerrabintest': (context) => MillerRabinTestPage(),
        '/gcd': (context) => GCDPage(),
        '/bruteforce': (context) => CaesarBruteForcePage(),
        '/chacha20': (context) => ChaCha20Page(),
      },
    );
  }
}