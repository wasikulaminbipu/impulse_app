// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'direction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Direction {

 int get id; int get productId; int get contentTypeId; int get speciesId; double get doseValueMin; double? get doseValueMax; int get doseUnitId; int get doseBasisId; int? get durationDaysMin; int? get durationDaysMax; String? get administrationEn; String? get administrationBn; String? get dosageEn; String? get dosageBn; int get displayOrder;
/// Create a copy of Direction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DirectionCopyWith<Direction> get copyWith => _$DirectionCopyWithImpl<Direction>(this as Direction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Direction&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.contentTypeId, contentTypeId) || other.contentTypeId == contentTypeId)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.doseValueMin, doseValueMin) || other.doseValueMin == doseValueMin)&&(identical(other.doseValueMax, doseValueMax) || other.doseValueMax == doseValueMax)&&(identical(other.doseUnitId, doseUnitId) || other.doseUnitId == doseUnitId)&&(identical(other.doseBasisId, doseBasisId) || other.doseBasisId == doseBasisId)&&(identical(other.durationDaysMin, durationDaysMin) || other.durationDaysMin == durationDaysMin)&&(identical(other.durationDaysMax, durationDaysMax) || other.durationDaysMax == durationDaysMax)&&(identical(other.administrationEn, administrationEn) || other.administrationEn == administrationEn)&&(identical(other.administrationBn, administrationBn) || other.administrationBn == administrationBn)&&(identical(other.dosageEn, dosageEn) || other.dosageEn == dosageEn)&&(identical(other.dosageBn, dosageBn) || other.dosageBn == dosageBn)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,contentTypeId,speciesId,doseValueMin,doseValueMax,doseUnitId,doseBasisId,durationDaysMin,durationDaysMax,administrationEn,administrationBn,dosageEn,dosageBn,displayOrder);

@override
String toString() {
  return 'Direction(id: $id, productId: $productId, contentTypeId: $contentTypeId, speciesId: $speciesId, doseValueMin: $doseValueMin, doseValueMax: $doseValueMax, doseUnitId: $doseUnitId, doseBasisId: $doseBasisId, durationDaysMin: $durationDaysMin, durationDaysMax: $durationDaysMax, administrationEn: $administrationEn, administrationBn: $administrationBn, dosageEn: $dosageEn, dosageBn: $dosageBn, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class $DirectionCopyWith<$Res>  {
  factory $DirectionCopyWith(Direction value, $Res Function(Direction) _then) = _$DirectionCopyWithImpl;
@useResult
$Res call({
 int id, int productId, int contentTypeId, int speciesId, double doseValueMin, double? doseValueMax, int doseUnitId, int doseBasisId, int? durationDaysMin, int? durationDaysMax, String? administrationEn, String? administrationBn, String? dosageEn, String? dosageBn, int displayOrder
});




}
/// @nodoc
class _$DirectionCopyWithImpl<$Res>
    implements $DirectionCopyWith<$Res> {
  _$DirectionCopyWithImpl(this._self, this._then);

  final Direction _self;
  final $Res Function(Direction) _then;

/// Create a copy of Direction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? contentTypeId = null,Object? speciesId = null,Object? doseValueMin = null,Object? doseValueMax = freezed,Object? doseUnitId = null,Object? doseBasisId = null,Object? durationDaysMin = freezed,Object? durationDaysMax = freezed,Object? administrationEn = freezed,Object? administrationBn = freezed,Object? dosageEn = freezed,Object? dosageBn = freezed,Object? displayOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,contentTypeId: null == contentTypeId ? _self.contentTypeId : contentTypeId // ignore: cast_nullable_to_non_nullable
as int,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as int,doseValueMin: null == doseValueMin ? _self.doseValueMin : doseValueMin // ignore: cast_nullable_to_non_nullable
as double,doseValueMax: freezed == doseValueMax ? _self.doseValueMax : doseValueMax // ignore: cast_nullable_to_non_nullable
as double?,doseUnitId: null == doseUnitId ? _self.doseUnitId : doseUnitId // ignore: cast_nullable_to_non_nullable
as int,doseBasisId: null == doseBasisId ? _self.doseBasisId : doseBasisId // ignore: cast_nullable_to_non_nullable
as int,durationDaysMin: freezed == durationDaysMin ? _self.durationDaysMin : durationDaysMin // ignore: cast_nullable_to_non_nullable
as int?,durationDaysMax: freezed == durationDaysMax ? _self.durationDaysMax : durationDaysMax // ignore: cast_nullable_to_non_nullable
as int?,administrationEn: freezed == administrationEn ? _self.administrationEn : administrationEn // ignore: cast_nullable_to_non_nullable
as String?,administrationBn: freezed == administrationBn ? _self.administrationBn : administrationBn // ignore: cast_nullable_to_non_nullable
as String?,dosageEn: freezed == dosageEn ? _self.dosageEn : dosageEn // ignore: cast_nullable_to_non_nullable
as String?,dosageBn: freezed == dosageBn ? _self.dosageBn : dosageBn // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Direction].
extension DirectionPatterns on Direction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Direction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Direction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Direction value)  $default,){
final _that = this;
switch (_that) {
case _Direction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Direction value)?  $default,){
final _that = this;
switch (_that) {
case _Direction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int productId,  int contentTypeId,  int speciesId,  double doseValueMin,  double? doseValueMax,  int doseUnitId,  int doseBasisId,  int? durationDaysMin,  int? durationDaysMax,  String? administrationEn,  String? administrationBn,  String? dosageEn,  String? dosageBn,  int displayOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Direction() when $default != null:
return $default(_that.id,_that.productId,_that.contentTypeId,_that.speciesId,_that.doseValueMin,_that.doseValueMax,_that.doseUnitId,_that.doseBasisId,_that.durationDaysMin,_that.durationDaysMax,_that.administrationEn,_that.administrationBn,_that.dosageEn,_that.dosageBn,_that.displayOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int productId,  int contentTypeId,  int speciesId,  double doseValueMin,  double? doseValueMax,  int doseUnitId,  int doseBasisId,  int? durationDaysMin,  int? durationDaysMax,  String? administrationEn,  String? administrationBn,  String? dosageEn,  String? dosageBn,  int displayOrder)  $default,) {final _that = this;
switch (_that) {
case _Direction():
return $default(_that.id,_that.productId,_that.contentTypeId,_that.speciesId,_that.doseValueMin,_that.doseValueMax,_that.doseUnitId,_that.doseBasisId,_that.durationDaysMin,_that.durationDaysMax,_that.administrationEn,_that.administrationBn,_that.dosageEn,_that.dosageBn,_that.displayOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int productId,  int contentTypeId,  int speciesId,  double doseValueMin,  double? doseValueMax,  int doseUnitId,  int doseBasisId,  int? durationDaysMin,  int? durationDaysMax,  String? administrationEn,  String? administrationBn,  String? dosageEn,  String? dosageBn,  int displayOrder)?  $default,) {final _that = this;
switch (_that) {
case _Direction() when $default != null:
return $default(_that.id,_that.productId,_that.contentTypeId,_that.speciesId,_that.doseValueMin,_that.doseValueMax,_that.doseUnitId,_that.doseBasisId,_that.durationDaysMin,_that.durationDaysMax,_that.administrationEn,_that.administrationBn,_that.dosageEn,_that.dosageBn,_that.displayOrder);case _:
  return null;

}
}

}

/// @nodoc


class _Direction implements Direction {
  const _Direction({required this.id, required this.productId, required this.contentTypeId, required this.speciesId, required this.doseValueMin, this.doseValueMax, required this.doseUnitId, required this.doseBasisId, this.durationDaysMin, this.durationDaysMax, this.administrationEn, this.administrationBn, this.dosageEn, this.dosageBn, this.displayOrder = 0});
  

@override final  int id;
@override final  int productId;
@override final  int contentTypeId;
@override final  int speciesId;
@override final  double doseValueMin;
@override final  double? doseValueMax;
@override final  int doseUnitId;
@override final  int doseBasisId;
@override final  int? durationDaysMin;
@override final  int? durationDaysMax;
@override final  String? administrationEn;
@override final  String? administrationBn;
@override final  String? dosageEn;
@override final  String? dosageBn;
@override@JsonKey() final  int displayOrder;

/// Create a copy of Direction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DirectionCopyWith<_Direction> get copyWith => __$DirectionCopyWithImpl<_Direction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Direction&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.contentTypeId, contentTypeId) || other.contentTypeId == contentTypeId)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.doseValueMin, doseValueMin) || other.doseValueMin == doseValueMin)&&(identical(other.doseValueMax, doseValueMax) || other.doseValueMax == doseValueMax)&&(identical(other.doseUnitId, doseUnitId) || other.doseUnitId == doseUnitId)&&(identical(other.doseBasisId, doseBasisId) || other.doseBasisId == doseBasisId)&&(identical(other.durationDaysMin, durationDaysMin) || other.durationDaysMin == durationDaysMin)&&(identical(other.durationDaysMax, durationDaysMax) || other.durationDaysMax == durationDaysMax)&&(identical(other.administrationEn, administrationEn) || other.administrationEn == administrationEn)&&(identical(other.administrationBn, administrationBn) || other.administrationBn == administrationBn)&&(identical(other.dosageEn, dosageEn) || other.dosageEn == dosageEn)&&(identical(other.dosageBn, dosageBn) || other.dosageBn == dosageBn)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,contentTypeId,speciesId,doseValueMin,doseValueMax,doseUnitId,doseBasisId,durationDaysMin,durationDaysMax,administrationEn,administrationBn,dosageEn,dosageBn,displayOrder);

@override
String toString() {
  return 'Direction(id: $id, productId: $productId, contentTypeId: $contentTypeId, speciesId: $speciesId, doseValueMin: $doseValueMin, doseValueMax: $doseValueMax, doseUnitId: $doseUnitId, doseBasisId: $doseBasisId, durationDaysMin: $durationDaysMin, durationDaysMax: $durationDaysMax, administrationEn: $administrationEn, administrationBn: $administrationBn, dosageEn: $dosageEn, dosageBn: $dosageBn, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class _$DirectionCopyWith<$Res> implements $DirectionCopyWith<$Res> {
  factory _$DirectionCopyWith(_Direction value, $Res Function(_Direction) _then) = __$DirectionCopyWithImpl;
@override @useResult
$Res call({
 int id, int productId, int contentTypeId, int speciesId, double doseValueMin, double? doseValueMax, int doseUnitId, int doseBasisId, int? durationDaysMin, int? durationDaysMax, String? administrationEn, String? administrationBn, String? dosageEn, String? dosageBn, int displayOrder
});




}
/// @nodoc
class __$DirectionCopyWithImpl<$Res>
    implements _$DirectionCopyWith<$Res> {
  __$DirectionCopyWithImpl(this._self, this._then);

  final _Direction _self;
  final $Res Function(_Direction) _then;

/// Create a copy of Direction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? contentTypeId = null,Object? speciesId = null,Object? doseValueMin = null,Object? doseValueMax = freezed,Object? doseUnitId = null,Object? doseBasisId = null,Object? durationDaysMin = freezed,Object? durationDaysMax = freezed,Object? administrationEn = freezed,Object? administrationBn = freezed,Object? dosageEn = freezed,Object? dosageBn = freezed,Object? displayOrder = null,}) {
  return _then(_Direction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,contentTypeId: null == contentTypeId ? _self.contentTypeId : contentTypeId // ignore: cast_nullable_to_non_nullable
as int,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as int,doseValueMin: null == doseValueMin ? _self.doseValueMin : doseValueMin // ignore: cast_nullable_to_non_nullable
as double,doseValueMax: freezed == doseValueMax ? _self.doseValueMax : doseValueMax // ignore: cast_nullable_to_non_nullable
as double?,doseUnitId: null == doseUnitId ? _self.doseUnitId : doseUnitId // ignore: cast_nullable_to_non_nullable
as int,doseBasisId: null == doseBasisId ? _self.doseBasisId : doseBasisId // ignore: cast_nullable_to_non_nullable
as int,durationDaysMin: freezed == durationDaysMin ? _self.durationDaysMin : durationDaysMin // ignore: cast_nullable_to_non_nullable
as int?,durationDaysMax: freezed == durationDaysMax ? _self.durationDaysMax : durationDaysMax // ignore: cast_nullable_to_non_nullable
as int?,administrationEn: freezed == administrationEn ? _self.administrationEn : administrationEn // ignore: cast_nullable_to_non_nullable
as String?,administrationBn: freezed == administrationBn ? _self.administrationBn : administrationBn // ignore: cast_nullable_to_non_nullable
as String?,dosageEn: freezed == dosageEn ? _self.dosageEn : dosageEn // ignore: cast_nullable_to_non_nullable
as String?,dosageBn: freezed == dosageBn ? _self.dosageBn : dosageBn // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
