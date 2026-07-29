// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dosage_basis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DosageBasis {

 int get id; String get nameEn; String? get nameBn;
/// Create a copy of DosageBasis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DosageBasisCopyWith<DosageBasis> get copyWith => _$DosageBasisCopyWithImpl<DosageBasis>(this as DosageBasis, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DosageBasis&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn);

@override
String toString() {
  return 'DosageBasis(id: $id, nameEn: $nameEn, nameBn: $nameBn)';
}


}

/// @nodoc
abstract mixin class $DosageBasisCopyWith<$Res>  {
  factory $DosageBasisCopyWith(DosageBasis value, $Res Function(DosageBasis) _then) = _$DosageBasisCopyWithImpl;
@useResult
$Res call({
 int id, String nameEn, String? nameBn
});




}
/// @nodoc
class _$DosageBasisCopyWithImpl<$Res>
    implements $DosageBasisCopyWith<$Res> {
  _$DosageBasisCopyWithImpl(this._self, this._then);

  final DosageBasis _self;
  final $Res Function(DosageBasis) _then;

/// Create a copy of DosageBasis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DosageBasis].
extension DosageBasisPatterns on DosageBasis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DosageBasis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DosageBasis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DosageBasis value)  $default,){
final _that = this;
switch (_that) {
case _DosageBasis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DosageBasis value)?  $default,){
final _that = this;
switch (_that) {
case _DosageBasis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nameEn,  String? nameBn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DosageBasis() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nameEn,  String? nameBn)  $default,) {final _that = this;
switch (_that) {
case _DosageBasis():
return $default(_that.id,_that.nameEn,_that.nameBn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nameEn,  String? nameBn)?  $default,) {final _that = this;
switch (_that) {
case _DosageBasis() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn);case _:
  return null;

}
}

}

/// @nodoc


class _DosageBasis implements DosageBasis {
  const _DosageBasis({required this.id, required this.nameEn, this.nameBn});
  

@override final  int id;
@override final  String nameEn;
@override final  String? nameBn;

/// Create a copy of DosageBasis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DosageBasisCopyWith<_DosageBasis> get copyWith => __$DosageBasisCopyWithImpl<_DosageBasis>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DosageBasis&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn);

@override
String toString() {
  return 'DosageBasis(id: $id, nameEn: $nameEn, nameBn: $nameBn)';
}


}

/// @nodoc
abstract mixin class _$DosageBasisCopyWith<$Res> implements $DosageBasisCopyWith<$Res> {
  factory _$DosageBasisCopyWith(_DosageBasis value, $Res Function(_DosageBasis) _then) = __$DosageBasisCopyWithImpl;
@override @useResult
$Res call({
 int id, String nameEn, String? nameBn
});




}
/// @nodoc
class __$DosageBasisCopyWithImpl<$Res>
    implements _$DosageBasisCopyWith<$Res> {
  __$DosageBasisCopyWithImpl(this._self, this._then);

  final _DosageBasis _self;
  final $Res Function(_DosageBasis) _then;

/// Create a copy of DosageBasis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,}) {
  return _then(_DosageBasis(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
