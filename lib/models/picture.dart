class Picture {
  final String title;
  final String imageUrl;
  final String date;

  Picture({required this.title, required this.imageUrl, required this.date});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      title: json['title'],
      imageUrl: json['url'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'date': date,
    };
  }
}
