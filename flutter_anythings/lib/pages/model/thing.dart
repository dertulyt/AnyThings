final String tableThings = 'things';

class ThingFields {
  static final List<String> values = [
    id,
    title,
    subtitle,
    count,
    category,
    time,
    choose
  ];

  static final String id = '_id';
  static final String title = "title";
  static final String subtitle = "subtitle";
  static final String count = "count";
  static final String category = "category";
  static final String time = "time";
  static final String choose = "choose";
}

class Thing {
  final int? id;
  final String title;
  final String? subtitle;
  final int? count;
  final String? category;
  final DateTime createdTime;
  final String? choose;

  const Thing({
    this.id,
    required this.title,
    required this.subtitle,
    this.count,
    this.category,
    required this.createdTime,
    required this.choose,
  });

  Thing copy({
    int? id,
    String? title,
    int? count,
    String? subtitle,
    String? category,
    DateTime? createdTime,
    String? choose,
  }) =>
      Thing(
        id: id ?? this.id,
        title: title ?? this.title,
        count: count ?? this.count,
        subtitle: subtitle ?? this.subtitle,
        category: category ?? this.category,
        createdTime: createdTime ?? this.createdTime,
        choose: choose ?? this.choose,
      );

  static Thing fromJson(Map<String, Object?> json) => Thing(
        id: json[ThingFields.id] as int?,
        title: json[ThingFields.title] as String,
        subtitle: json[ThingFields.subtitle] as String,
        count: json[ThingFields.count] as int?,
        category: json[ThingFields.category] as String?,
        createdTime: DateTime.parse(json[ThingFields.time] as String),
        choose: json[ThingFields.choose] as String?,
      );
  Map<String, Object?> toJson() => {
        ThingFields.id: id,
        ThingFields.title: title,
        ThingFields.subtitle: subtitle,
        ThingFields.category: category,
        ThingFields.count: count,
        ThingFields.time: createdTime.toIso8601String(),
        ThingFields.choose: choose,
      };
}
