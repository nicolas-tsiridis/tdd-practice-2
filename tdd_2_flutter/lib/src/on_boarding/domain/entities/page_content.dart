import 'package:equatable/equatable.dart';
import 'package:tdd_2_flutter/core/res/descriptions.dart';
import 'package:tdd_2_flutter/core/res/media_resources.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  factory PageContent.first() {
    return const PageContent(
      image: MediaResources.carRed, //use MediaResources when attained
      title: Descriptions.startUpPage1Title,
      description: Descriptions.startUpPage1Description,
    );
  }

  factory PageContent.second() {
    return const PageContent(
      image: MediaResources.carBlue, //use MediaResources when attained
      title: Descriptions.startUpPage2Title,
      description: Descriptions.startUpPage2Description,
    );
  }

  factory PageContent.third() {
    return const PageContent(
      image: MediaResources.carYellow, //use MediaResources when attained
      title: Descriptions.startUpPage3Title,
      description: Descriptions.startUpPage3Description,
    );
  }

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
