import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class  Environment {

  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiURL = Platform.isAndroid ? dotenv.env['API_URL_DEV_ANDROID']! : 'http://${dotenv.env['WSS_API_URL']}:3000';
  static String socketURL = '${dotenv.env['WSS_API_URL']}';
}