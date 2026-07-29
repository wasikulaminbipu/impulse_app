// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_maintenance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoriteEntry implements DiagnosticableTreeMixin {

 int get id; DateTime get addedAt;
/// Create a copy of FavoriteEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteEntryCopyWith<FavoriteEntry> get copyWith => _$FavoriteEntryCopyWithImpl<FavoriteEntry>(this as FavoriteEntry, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FavoriteEntry'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('addedAt', addedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,addedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FavoriteEntry(id: $id, addedAt: $addedAt)';
}


}

/// @nodoc
abstract mixin class $FavoriteEntryCopyWith<$Res>  {
  factory $FavoriteEntryCopyWith(FavoriteEntry value, $Res Function(FavoriteEntry) _then) = _$FavoriteEntryCopyWithImpl;
@useResult
$Res call({
 int id, DateTime addedAt
});




}
/// @nodoc
class _$FavoriteEntryCopyWithImpl<$Res>
    implements $FavoriteEntryCopyWith<$Res> {
  _$FavoriteEntryCopyWithImpl(this._self, this._then);

  final FavoriteEntry _self;
  final $Res Function(FavoriteEntry) _then;

/// Create a copy of FavoriteEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? addedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteEntry].
extension FavoriteEntryPatterns on FavoriteEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteEntry value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteEntry value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime addedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteEntry() when $default != null:
return $default(_that.id,_that.addedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime addedAt)  $default,) {final _that = this;
switch (_that) {
case _FavoriteEntry():
return $default(_that.id,_that.addedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime addedAt)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteEntry() when $default != null:
return $default(_that.id,_that.addedAt);case _:
  return null;

}
}

}

/// @nodoc


class _FavoriteEntry extends FavoriteEntry with DiagnosticableTreeMixin {
  const _FavoriteEntry({required this.id, required this.addedAt}): super._();
  

@override final  int id;
@override final  DateTime addedAt;

/// Create a copy of FavoriteEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteEntryCopyWith<_FavoriteEntry> get copyWith => __$FavoriteEntryCopyWithImpl<_FavoriteEntry>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FavoriteEntry'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('addedAt', addedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,addedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FavoriteEntry(id: $id, addedAt: $addedAt)';
}


}

/// @nodoc
abstract mixin class _$FavoriteEntryCopyWith<$Res> implements $FavoriteEntryCopyWith<$Res> {
  factory _$FavoriteEntryCopyWith(_FavoriteEntry value, $Res Function(_FavoriteEntry) _then) = __$FavoriteEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime addedAt
});




}
/// @nodoc
class __$FavoriteEntryCopyWithImpl<$Res>
    implements _$FavoriteEntryCopyWith<$Res> {
  __$FavoriteEntryCopyWithImpl(this._self, this._then);

  final _FavoriteEntry _self;
  final $Res Function(_FavoriteEntry) _then;

/// Create a copy of FavoriteEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? addedAt = null,}) {
  return _then(_FavoriteEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$AppSetting implements DiagnosticableTreeMixin {

 String get key; String? get value;
/// Create a copy of AppSetting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingCopyWith<AppSetting> get copyWith => _$AppSettingCopyWithImpl<AppSetting>(this as AppSetting, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AppSetting'))
    ..add(DiagnosticsProperty('key', key))..add(DiagnosticsProperty('value', value));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSetting&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,key,value);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AppSetting(key: $key, value: $value)';
}


}

/// @nodoc
abstract mixin class $AppSettingCopyWith<$Res>  {
  factory $AppSettingCopyWith(AppSetting value, $Res Function(AppSetting) _then) = _$AppSettingCopyWithImpl;
@useResult
$Res call({
 String key, String? value
});




}
/// @nodoc
class _$AppSettingCopyWithImpl<$Res>
    implements $AppSettingCopyWith<$Res> {
  _$AppSettingCopyWithImpl(this._self, this._then);

  final AppSetting _self;
  final $Res Function(AppSetting) _then;

/// Create a copy of AppSetting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? value = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSetting].
extension AppSettingPatterns on AppSetting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSetting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSetting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSetting value)  $default,){
final _that = this;
switch (_that) {
case _AppSetting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSetting value)?  $default,){
final _that = this;
switch (_that) {
case _AppSetting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSetting() when $default != null:
return $default(_that.key,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String? value)  $default,) {final _that = this;
switch (_that) {
case _AppSetting():
return $default(_that.key,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String? value)?  $default,) {final _that = this;
switch (_that) {
case _AppSetting() when $default != null:
return $default(_that.key,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _AppSetting extends AppSetting with DiagnosticableTreeMixin {
  const _AppSetting({required this.key, this.value}): super._();
  

@override final  String key;
@override final  String? value;

/// Create a copy of AppSetting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingCopyWith<_AppSetting> get copyWith => __$AppSettingCopyWithImpl<_AppSetting>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AppSetting'))
    ..add(DiagnosticsProperty('key', key))..add(DiagnosticsProperty('value', value));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSetting&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,key,value);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AppSetting(key: $key, value: $value)';
}


}

/// @nodoc
abstract mixin class _$AppSettingCopyWith<$Res> implements $AppSettingCopyWith<$Res> {
  factory _$AppSettingCopyWith(_AppSetting value, $Res Function(_AppSetting) _then) = __$AppSettingCopyWithImpl;
@override @useResult
$Res call({
 String key, String? value
});




}
/// @nodoc
class __$AppSettingCopyWithImpl<$Res>
    implements _$AppSettingCopyWith<$Res> {
  __$AppSettingCopyWithImpl(this._self, this._then);

  final _AppSetting _self;
  final $Res Function(_AppSetting) _then;

/// Create a copy of AppSetting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? value = freezed,}) {
  return _then(_AppSetting(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
