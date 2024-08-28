import 'package:monopoli/models/home/section.dart';

class HomeModel {
  final Section sections;

  HomeModel.fromJSON(Map<String, dynamic> json)
      : sections = Section.fromJSON(
          json['sections'],
        );

  HomeModel({
    required this.sections,
  });
}
