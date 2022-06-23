import 'dart:developer';

import 'package:web_scrapping_example/web_scrapping_example.dart'
    as web_scrapping_example;

Future<void> main(List<String> arguments) async {
  print('Hello world: ${web_scrapping_example.calculate()}!');
await web_scrapping_example.extractData();
}
