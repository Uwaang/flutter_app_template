import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_manifest.freezed.dart';
part 'template_manifest.g.dart';

@freezed
abstract class TemplateManifest with _$TemplateManifest {
  const factory TemplateManifest({
    required String appName,
    required String brandName,
    required String packageName,
    required String apiBaseUrl,
    required String environment,
    required List<String> supportedPlatforms,
    required List<TemplateChecklistItem> nextSteps,
  }) = _TemplateManifest;

  factory TemplateManifest.fromJson(Map<String, dynamic> json) =>
      _$TemplateManifestFromJson(json);
}

@freezed
abstract class TemplateChecklistItem with _$TemplateChecklistItem {
  const factory TemplateChecklistItem({
    required String title,
    required String description,
  }) = _TemplateChecklistItem;

  factory TemplateChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$TemplateChecklistItemFromJson(json);
}
