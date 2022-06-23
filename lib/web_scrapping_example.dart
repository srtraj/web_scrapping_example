import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

int calculate() {
  return 6 * 7;
}

Future<dynamic> extractData() async {
//Getting the response from the targeted url
  final response = await http.Client().get(Uri.parse(
      'https://news.google.com/topics/CAAqJQgKIh9DQkFTRVFvSUwyMHZNRE55YXpBU0JXVnVMVWRDS0FBUAE?hl=en-IN&gl=IN&ceid=IN%3Aen'));
  //Status Code 200 means response has been received successfully
  if (response.statusCode == 200) {
    //Getting the html document from the response
    var document = parser.parse(response.body);

    try {
      final articleList = document.getElementsByTagName('article');

      final h3List = [];
      for (var element in articleList) {
        final h3 = element.getElementsByTagName('h3');
        for (var ele in h3) {
          h3List.add(ele);
        }
      }

      final aTagsList = [];
      for (var element in h3List) {
        aTagsList.add(element.getElementsByTagName('a')[0]);
      }

      final hrefs =
          aTagsList.where((e) => e.attributes.containsKey('href')).map((e) {
        return e.attributes['href']
            .replaceFirst("./", "https://news.google.com/");
      }).toList();

      for (var element in hrefs) {
        print("$element\n");
      }
    } catch (e) {
      print(e);
      return ['', '', 'ERROR!'];
    }
  } else {
    return ['', '', 'ERROR: ${response.statusCode}.'];
  }
}
