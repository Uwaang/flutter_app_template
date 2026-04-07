// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TemplateManifest {

 String get appName; String get brandName; String get packageName; String get apiBaseUrl; String get environment; List<String> get supportedPlatforms; List<TemplateChecklistItem> get nextSteps;
/// Create a copy of TemplateManifest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplateManifestCopyWith<TemplateManifest> get copyWith => _$TemplateManifestCopyWithImpl<TemplateManifest>(this as TemplateManifest, _$identity);

  /// Serializes this TemplateManifest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateManifest&&(identical(other.appName, appName) || other.appName == appName)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.packageName, packageName) || other.packageName == packageName)&&(identical(other.apiBaseUrl, apiBaseUrl) || other.apiBaseUrl == apiBaseUrl)&&(identical(other.environment, environment) || other.environment == environment)&&const DeepCollectionEquality().equals(other.supportedPlatforms, supportedPlatforms)&&const DeepCollectionEquality().equals(other.nextSteps, nextSteps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appName,brandName,packageName,apiBaseUrl,environment,const DeepCollectionEquality().hash(supportedPlatforms),const DeepCollectionEquality().hash(nextSteps));

@override
String toString() {
  return 'TemplateManifest(appName: $appName, brandName: $brandName, packageName: $packageName, apiBaseUrl: $apiBaseUrl, environment: $environment, supportedPlatforms: $supportedPlatforms, nextSteps: $nextSteps)';
}


}

/// @nodoc
abstract mixin class $TemplateManifestCopyWith<$Res>  {
  factory $TemplateManifestCopyWith(TemplateManifest value, $Res Function(TemplateManifest) _then) = _$TemplateManifestCopyWithImpl;
@useResult
$Res call({
 String appName, String brandName, String packageName, String apiBaseUrl, String environment, List<String> supportedPlatforms, List<TemplateChecklistItem> nextSteps
});




}
/// @nodoc
class _$TemplateManifestCopyWithImpl<$Res>
    implements $TemplateManifestCopyWith<$Res> {
  _$TemplateManifestCopyWithImpl(this._self, this._then);

  final TemplateManifest _self;
  final $Res Function(TemplateManifest) _then;

/// Create a copy of TemplateManifest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appName = null,Object? brandName = null,Object? packageName = null,Object? apiBaseUrl = null,Object? environment = null,Object? supportedPlatforms = null,Object? nextSteps = null,}) {
  return _then(_self.copyWith(
appName: null == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,packageName: null == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String,apiBaseUrl: null == apiBaseUrl ? _self.apiBaseUrl : apiBaseUrl // ignore: cast_nullable_to_non_nullable
as String,environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as String,supportedPlatforms: null == supportedPlatforms ? _self.supportedPlatforms : supportedPlatforms // ignore: cast_nullable_to_non_nullable
as List<String>,nextSteps: null == nextSteps ? _self.nextSteps : nextSteps // ignore: cast_nullable_to_non_nullable
as List<TemplateChecklistItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [TemplateManifest].
extension TemplateManifestPatterns on TemplateManifest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemplateManifest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemplateManifest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemplateManifest value)  $default,){
final _that = this;
switch (_that) {
case _TemplateManifest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemplateManifest value)?  $default,){
final _that = this;
switch (_that) {
case _TemplateManifest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String appName,  String brandName,  String packageName,  String apiBaseUrl,  String environment,  List<String> supportedPlatforms,  List<TemplateChecklistItem> nextSteps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemplateManifest() when $default != null:
return $default(_that.appName,_that.brandName,_that.packageName,_that.apiBaseUrl,_that.environment,_that.supportedPlatforms,_that.nextSteps);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String appName,  String brandName,  String packageName,  String apiBaseUrl,  String environment,  List<String> supportedPlatforms,  List<TemplateChecklistItem> nextSteps)  $default,) {final _that = this;
switch (_that) {
case _TemplateManifest():
return $default(_that.appName,_that.brandName,_that.packageName,_that.apiBaseUrl,_that.environment,_that.supportedPlatforms,_that.nextSteps);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String appName,  String brandName,  String packageName,  String apiBaseUrl,  String environment,  List<String> supportedPlatforms,  List<TemplateChecklistItem> nextSteps)?  $default,) {final _that = this;
switch (_that) {
case _TemplateManifest() when $default != null:
return $default(_that.appName,_that.brandName,_that.packageName,_that.apiBaseUrl,_that.environment,_that.supportedPlatforms,_that.nextSteps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TemplateManifest implements TemplateManifest {
  const _TemplateManifest({required this.appName, required this.brandName, required this.packageName, required this.apiBaseUrl, required this.environment, required final  List<String> supportedPlatforms, required final  List<TemplateChecklistItem> nextSteps}): _supportedPlatforms = supportedPlatforms,_nextSteps = nextSteps;
  factory _TemplateManifest.fromJson(Map<String, dynamic> json) => _$TemplateManifestFromJson(json);

@override final  String appName;
@override final  String brandName;
@override final  String packageName;
@override final  String apiBaseUrl;
@override final  String environment;
 final  List<String> _supportedPlatforms;
@override List<String> get supportedPlatforms {
  if (_supportedPlatforms is EqualUnmodifiableListView) return _supportedPlatforms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supportedPlatforms);
}

 final  List<TemplateChecklistItem> _nextSteps;
@override List<TemplateChecklistItem> get nextSteps {
  if (_nextSteps is EqualUnmodifiableListView) return _nextSteps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nextSteps);
}


/// Create a copy of TemplateManifest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplateManifestCopyWith<_TemplateManifest> get copyWith => __$TemplateManifestCopyWithImpl<_TemplateManifest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TemplateManifestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplateManifest&&(identical(other.appName, appName) || other.appName == appName)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.packageName, packageName) || other.packageName == packageName)&&(identical(other.apiBaseUrl, apiBaseUrl) || other.apiBaseUrl == apiBaseUrl)&&(identical(other.environment, environment) || other.environment == environment)&&const DeepCollectionEquality().equals(other._supportedPlatforms, _supportedPlatforms)&&const DeepCollectionEquality().equals(other._nextSteps, _nextSteps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appName,brandName,packageName,apiBaseUrl,environment,const DeepCollectionEquality().hash(_supportedPlatforms),const DeepCollectionEquality().hash(_nextSteps));

@override
String toString() {
  return 'TemplateManifest(appName: $appName, brandName: $brandName, packageName: $packageName, apiBaseUrl: $apiBaseUrl, environment: $environment, supportedPlatforms: $supportedPlatforms, nextSteps: $nextSteps)';
}


}

/// @nodoc
abstract mixin class _$TemplateManifestCopyWith<$Res> implements $TemplateManifestCopyWith<$Res> {
  factory _$TemplateManifestCopyWith(_TemplateManifest value, $Res Function(_TemplateManifest) _then) = __$TemplateManifestCopyWithImpl;
@override @useResult
$Res call({
 String appName, String brandName, String packageName, String apiBaseUrl, String environment, List<String> supportedPlatforms, List<TemplateChecklistItem> nextSteps
});




}
/// @nodoc
class __$TemplateManifestCopyWithImpl<$Res>
    implements _$TemplateManifestCopyWith<$Res> {
  __$TemplateManifestCopyWithImpl(this._self, this._then);

  final _TemplateManifest _self;
  final $Res Function(_TemplateManifest) _then;

/// Create a copy of TemplateManifest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appName = null,Object? brandName = null,Object? packageName = null,Object? apiBaseUrl = null,Object? environment = null,Object? supportedPlatforms = null,Object? nextSteps = null,}) {
  return _then(_TemplateManifest(
appName: null == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,packageName: null == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String,apiBaseUrl: null == apiBaseUrl ? _self.apiBaseUrl : apiBaseUrl // ignore: cast_nullable_to_non_nullable
as String,environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as String,supportedPlatforms: null == supportedPlatforms ? _self._supportedPlatforms : supportedPlatforms // ignore: cast_nullable_to_non_nullable
as List<String>,nextSteps: null == nextSteps ? _self._nextSteps : nextSteps // ignore: cast_nullable_to_non_nullable
as List<TemplateChecklistItem>,
  ));
}


}


/// @nodoc
mixin _$TemplateChecklistItem {

 String get title; String get description;
/// Create a copy of TemplateChecklistItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplateChecklistItemCopyWith<TemplateChecklistItem> get copyWith => _$TemplateChecklistItemCopyWithImpl<TemplateChecklistItem>(this as TemplateChecklistItem, _$identity);

  /// Serializes this TemplateChecklistItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateChecklistItem&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description);

@override
String toString() {
  return 'TemplateChecklistItem(title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class $TemplateChecklistItemCopyWith<$Res>  {
  factory $TemplateChecklistItemCopyWith(TemplateChecklistItem value, $Res Function(TemplateChecklistItem) _then) = _$TemplateChecklistItemCopyWithImpl;
@useResult
$Res call({
 String title, String description
});




}
/// @nodoc
class _$TemplateChecklistItemCopyWithImpl<$Res>
    implements $TemplateChecklistItemCopyWith<$Res> {
  _$TemplateChecklistItemCopyWithImpl(this._self, this._then);

  final TemplateChecklistItem _self;
  final $Res Function(TemplateChecklistItem) _then;

/// Create a copy of TemplateChecklistItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TemplateChecklistItem].
extension TemplateChecklistItemPatterns on TemplateChecklistItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemplateChecklistItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemplateChecklistItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemplateChecklistItem value)  $default,){
final _that = this;
switch (_that) {
case _TemplateChecklistItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemplateChecklistItem value)?  $default,){
final _that = this;
switch (_that) {
case _TemplateChecklistItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemplateChecklistItem() when $default != null:
return $default(_that.title,_that.description);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description)  $default,) {final _that = this;
switch (_that) {
case _TemplateChecklistItem():
return $default(_that.title,_that.description);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description)?  $default,) {final _that = this;
switch (_that) {
case _TemplateChecklistItem() when $default != null:
return $default(_that.title,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TemplateChecklistItem implements TemplateChecklistItem {
  const _TemplateChecklistItem({required this.title, required this.description});
  factory _TemplateChecklistItem.fromJson(Map<String, dynamic> json) => _$TemplateChecklistItemFromJson(json);

@override final  String title;
@override final  String description;

/// Create a copy of TemplateChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplateChecklistItemCopyWith<_TemplateChecklistItem> get copyWith => __$TemplateChecklistItemCopyWithImpl<_TemplateChecklistItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TemplateChecklistItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplateChecklistItem&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description);

@override
String toString() {
  return 'TemplateChecklistItem(title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$TemplateChecklistItemCopyWith<$Res> implements $TemplateChecklistItemCopyWith<$Res> {
  factory _$TemplateChecklistItemCopyWith(_TemplateChecklistItem value, $Res Function(_TemplateChecklistItem) _then) = __$TemplateChecklistItemCopyWithImpl;
@override @useResult
$Res call({
 String title, String description
});




}
/// @nodoc
class __$TemplateChecklistItemCopyWithImpl<$Res>
    implements _$TemplateChecklistItemCopyWith<$Res> {
  __$TemplateChecklistItemCopyWithImpl(this._self, this._then);

  final _TemplateChecklistItem _self;
  final $Res Function(_TemplateChecklistItem) _then;

/// Create a copy of TemplateChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,}) {
  return _then(_TemplateChecklistItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
