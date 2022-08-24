part of searchbar;

class GtsModelPage {
  final String page;
  final String text;
  final String chapterName;
  final List<String> type;

  GtsModelPage(
    this.page,
    this.text,
    this.chapterName,
    this.type,
  );

  factory GtsModelPage.fromJson(Map<String, dynamic> json) {
    return GtsModelPage(json['page'], json['text'], json['chapterName'],
        json['type'] != null ? json['type'].cast<String>() : []);
  }
}
