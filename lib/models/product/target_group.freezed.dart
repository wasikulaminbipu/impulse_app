// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'target_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TargetGroup {

 int get id; String get nameEn; String? get nameBn; String? get iconName;
/// Create a copy of TargetGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TargetGroupCopyWith<TargetGroup> get copyWith => _$TargetGroupCopyWithImpl<TargetGroup>(this as TargetGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TargetGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.iconName, iconName) || other.iconName == iconName));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn,iconName);

@override
String toString() {
  return 'TargetGroup(id: $id, nameEn: $nameEn, nameBn: $nameBn, iconName: $iconName)';
}


}

/// @nodoc
abstract mixin class $TargetGroupCopyWith<$Res>  {
  factory $TargetGroupCopyWith(TargetGroup value, $Res Function(TargetGroup) _then) = _$TargetGroupCopyWithImpl;
@useResult
$Res call({
 int id, String nameEn, String? nameBn, String? iconName
});




}
/// @nodoc
class _$TargetGroupCopyWithImpl<$Res>
    implements $TargetGroupCopyWith<$Res> {
  _$TargetGroupCopyWithImpl(this._self, this._then);

  final TargetGroup _self;
  final $Res Function(TargetGroup) _then;

/// Create a copy of TargetGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,Object? iconName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,iconName: freezed == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TargetGroup].
extension TargetGroupPatterns on TargetGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TargetGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TargetGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TargetGroup value)  $default,){
final _that = this;
switch (_that) {
case _TargetGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TargetGroup value)?  $default,){
final _that = this;
switch (_that) {
case _TargetGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nameEn,  String? nameBn,  String? iconName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TargetGroup() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn,_that.iconName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nameEn,  String? nameBn,  String? iconName)  $default,) {final _that = this;
switch (_that) {
case _TargetGroup():
return $default(_that.id,_that.nameEn,_that.nameBn,_that.iconName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nameEn,  String? nameBn,  String? iconName)?  $default,) {final _that = this;
switch (_that) {
case _TargetGroup() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn,_that.iconName);case _:
  return null;

}
}

}

/// @nodoc


class _TargetGroup implements TargetGroup {
  const _TargetGroup({required this.id, required this.nameEn, this.nameBn, this.iconName});
  

@override final  int id;
@override final  String nameEn;
@override final  String? nameBn;
@override final  String? iconName;

/// Create a copy of TargetGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TargetGroupCopyWith<_TargetGroup> get copyWith => __$TargetGroupCopyWithImpl<_TargetGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TargetGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.iconName, iconName) || other.iconName == iconName));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn,iconName);

@override
String toString() {
  return 'TargetGroup(id: $id, nameEn: $nameEn, nameBn: $nameBn, iconName: $iconName)';
}


}

/// @nodoc
abstract mixin class _$TargetGroupCopyWith<$Res> implements $TargetGroupCopyWith<$Res> {
  factory _$TargetGroupCopyWith(_TargetGroup value, $Res Function(_TargetGroup) _then) = __$TargetGroupCopyWithImpl;
@override @useResult
$Res call({
 int id, String nameEn, String? nameBn, String? iconName
});




}
/// @nodoc
class __$TargetGroupCopyWithImpl<$Res>
    implements _$TargetGroupCopyWith<$Res> {
  __$TargetGroupCopyWithImpl(this._self, this._then);

  final _TargetGroup _self;
  final $Res Function(_TargetGroup) _then;

/// Create a copy of TargetGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,Object? iconName = freezed,}) {
  return _then(_TargetGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,iconName: freezed == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
