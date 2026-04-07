// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TemplateManifest _$TemplateManifestFromJson(Map<String, dynamic> json) =>
    _TemplateManifest(
      appName: json['appName'] as String,
      brandName: json['brandName'] as String,
      packageName: json['packageName'] as String,
      apiBaseUrl: json['apiBaseUrl'] as String,
      environment: json['environment'] as String,
      supportedPlatforms: (json['supportedPlatforms'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      nextSteps: (json['nextSteps'] as List<dynamic>)
          .map((e) => TemplateChecklistItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TemplateManifestToJson(_TemplateManifest instance) =>
    <String, dynamic>{
      'appName': instance.appName,
      'brandName': instance.brandName,
      'packageName': instance.packageName,
      'apiBaseUrl': instance.apiBaseUrl,
      'environment': instance.environment,
      'supportedPlatforms': instance.supportedPlatforms,
      'nextSteps': instance.nextSteps,
    };

_TemplateChecklistItem _$TemplateChecklistItemFromJson(
  Map<String, dynamic> json,
) => _TemplateChecklistItem(
  title: json['title'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$TemplateChecklistItemToJson(
  _TemplateChecklistItem instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
};
