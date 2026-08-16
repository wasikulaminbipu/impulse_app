// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'distributor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Region implements DiagnosticableTreeMixin {

 int get id; String get nameEn; String? get nameBn;
/// Create a copy of Region
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionCopyWith<Region> get copyWith => _$RegionCopyWithImpl<Region>(this as Region, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Region'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Region&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Region(id: $id, nameEn: $nameEn, nameBn: $nameBn)';
}


}

/// @nodoc
abstract mixin class $RegionCopyWith<$Res>  {
  factory $RegionCopyWith(Region value, $Res Function(Region) _then) = _$RegionCopyWithImpl;
@useResult
$Res call({
 int id, String nameEn, String? nameBn
});




}
/// @nodoc
class _$RegionCopyWithImpl<$Res>
    implements $RegionCopyWith<$Res> {
  _$RegionCopyWithImpl(this._self, this._then);

  final Region _self;
  final $Res Function(Region) _then;

/// Create a copy of Region
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


/// Adds pattern-matching-related methods to [Region].
extension RegionPatterns on Region {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Region value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Region() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Region value)  $default,){
final _that = this;
switch (_that) {
case _Region():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Region value)?  $default,){
final _that = this;
switch (_that) {
case _Region() when $default != null:
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
case _Region() when $default != null:
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
case _Region():
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
case _Region() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn);case _:
  return null;

}
}

}

/// @nodoc


class _Region extends Region with DiagnosticableTreeMixin {
  const _Region({required this.id, required this.nameEn, this.nameBn}): super._();
  

@override final  int id;
@override final  String nameEn;
@override final  String? nameBn;

/// Create a copy of Region
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionCopyWith<_Region> get copyWith => __$RegionCopyWithImpl<_Region>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Region'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Region&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Region(id: $id, nameEn: $nameEn, nameBn: $nameBn)';
}


}

/// @nodoc
abstract mixin class _$RegionCopyWith<$Res> implements $RegionCopyWith<$Res> {
  factory _$RegionCopyWith(_Region value, $Res Function(_Region) _then) = __$RegionCopyWithImpl;
@override @useResult
$Res call({
 int id, String nameEn, String? nameBn
});




}
/// @nodoc
class __$RegionCopyWithImpl<$Res>
    implements _$RegionCopyWith<$Res> {
  __$RegionCopyWithImpl(this._self, this._then);

  final _Region _self;
  final $Res Function(_Region) _then;

/// Create a copy of Region
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,}) {
  return _then(_Region(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$Area implements DiagnosticableTreeMixin {

 int get id; int get regionId; String get nameEn; String? get nameBn;
/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaCopyWith<Area> get copyWith => _$AreaCopyWithImpl<Area>(this as Area, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Area'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('regionId', regionId))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Area&&(identical(other.id, id) || other.id == id)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn));
}


@override
int get hashCode => Object.hash(runtimeType,id,regionId,nameEn,nameBn);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Area(id: $id, regionId: $regionId, nameEn: $nameEn, nameBn: $nameBn)';
}


}

/// @nodoc
abstract mixin class $AreaCopyWith<$Res>  {
  factory $AreaCopyWith(Area value, $Res Function(Area) _then) = _$AreaCopyWithImpl;
@useResult
$Res call({
 int id, int regionId, String nameEn, String? nameBn
});




}
/// @nodoc
class _$AreaCopyWithImpl<$Res>
    implements $AreaCopyWith<$Res> {
  _$AreaCopyWithImpl(this._self, this._then);

  final Area _self;
  final $Res Function(Area) _then;

/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? regionId = null,Object? nameEn = null,Object? nameBn = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Area].
extension AreaPatterns on Area {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Area value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Area() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Area value)  $default,){
final _that = this;
switch (_that) {
case _Area():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Area value)?  $default,){
final _that = this;
switch (_that) {
case _Area() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int regionId,  String nameEn,  String? nameBn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Area() when $default != null:
return $default(_that.id,_that.regionId,_that.nameEn,_that.nameBn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int regionId,  String nameEn,  String? nameBn)  $default,) {final _that = this;
switch (_that) {
case _Area():
return $default(_that.id,_that.regionId,_that.nameEn,_that.nameBn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int regionId,  String nameEn,  String? nameBn)?  $default,) {final _that = this;
switch (_that) {
case _Area() when $default != null:
return $default(_that.id,_that.regionId,_that.nameEn,_that.nameBn);case _:
  return null;

}
}

}

/// @nodoc


class _Area extends Area with DiagnosticableTreeMixin {
  const _Area({required this.id, required this.regionId, required this.nameEn, this.nameBn}): super._();
  

@override final  int id;
@override final  int regionId;
@override final  String nameEn;
@override final  String? nameBn;

/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AreaCopyWith<_Area> get copyWith => __$AreaCopyWithImpl<_Area>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Area'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('regionId', regionId))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Area&&(identical(other.id, id) || other.id == id)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn));
}


@override
int get hashCode => Object.hash(runtimeType,id,regionId,nameEn,nameBn);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Area(id: $id, regionId: $regionId, nameEn: $nameEn, nameBn: $nameBn)';
}


}

/// @nodoc
abstract mixin class _$AreaCopyWith<$Res> implements $AreaCopyWith<$Res> {
  factory _$AreaCopyWith(_Area value, $Res Function(_Area) _then) = __$AreaCopyWithImpl;
@override @useResult
$Res call({
 int id, int regionId, String nameEn, String? nameBn
});




}
/// @nodoc
class __$AreaCopyWithImpl<$Res>
    implements _$AreaCopyWith<$Res> {
  __$AreaCopyWithImpl(this._self, this._then);

  final _Area _self;
  final $Res Function(_Area) _then;

/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? regionId = null,Object? nameEn = null,Object? nameBn = freezed,}) {
  return _then(_Area(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$Division implements DiagnosticableTreeMixin {

 int get id; String get nameEn; String? get nameBn;
/// Create a copy of Division
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DivisionCopyWith<Division> get copyWith => _$DivisionCopyWithImpl<Division>(this as Division, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Division'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Division&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Division(id: $id, nameEn: $nameEn, nameBn: $nameBn)';
}


}

/// @nodoc
abstract mixin class $DivisionCopyWith<$Res>  {
  factory $DivisionCopyWith(Division value, $Res Function(Division) _then) = _$DivisionCopyWithImpl;
@useResult
$Res call({
 int id, String nameEn, String? nameBn
});




}
/// @nodoc
class _$DivisionCopyWithImpl<$Res>
    implements $DivisionCopyWith<$Res> {
  _$DivisionCopyWithImpl(this._self, this._then);

  final Division _self;
  final $Res Function(Division) _then;

/// Create a copy of Division
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


/// Adds pattern-matching-related methods to [Division].
extension DivisionPatterns on Division {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Division value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Division() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Division value)  $default,){
final _that = this;
switch (_that) {
case _Division():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Division value)?  $default,){
final _that = this;
switch (_that) {
case _Division() when $default != null:
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
case _Division() when $default != null:
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
case _Division():
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
case _Division() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn);case _:
  return null;

}
}

}

/// @nodoc


class _Division extends Division with DiagnosticableTreeMixin {
  const _Division({required this.id, required this.nameEn, this.nameBn}): super._();
  

@override final  int id;
@override final  String nameEn;
@override final  String? nameBn;

/// Create a copy of Division
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DivisionCopyWith<_Division> get copyWith => __$DivisionCopyWithImpl<_Division>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Division'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Division&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Division(id: $id, nameEn: $nameEn, nameBn: $nameBn)';
}


}

/// @nodoc
abstract mixin class _$DivisionCopyWith<$Res> implements $DivisionCopyWith<$Res> {
  factory _$DivisionCopyWith(_Division value, $Res Function(_Division) _then) = __$DivisionCopyWithImpl;
@override @useResult
$Res call({
 int id, String nameEn, String? nameBn
});




}
/// @nodoc
class __$DivisionCopyWithImpl<$Res>
    implements _$DivisionCopyWith<$Res> {
  __$DivisionCopyWithImpl(this._self, this._then);

  final _Division _self;
  final $Res Function(_Division) _then;

/// Create a copy of Division
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,}) {
  return _then(_Division(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$District implements DiagnosticableTreeMixin {

 int get id; int get divisionId; String get nameEn; String? get nameBn;
/// Create a copy of District
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DistrictCopyWith<District> get copyWith => _$DistrictCopyWithImpl<District>(this as District, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'District'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('divisionId', divisionId))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is District&&(identical(other.id, id) || other.id == id)&&(identical(other.divisionId, divisionId) || other.divisionId == divisionId)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn));
}


@override
int get hashCode => Object.hash(runtimeType,id,divisionId,nameEn,nameBn);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'District(id: $id, divisionId: $divisionId, nameEn: $nameEn, nameBn: $nameBn)';
}


}

/// @nodoc
abstract mixin class $DistrictCopyWith<$Res>  {
  factory $DistrictCopyWith(District value, $Res Function(District) _then) = _$DistrictCopyWithImpl;
@useResult
$Res call({
 int id, int divisionId, String nameEn, String? nameBn
});




}
/// @nodoc
class _$DistrictCopyWithImpl<$Res>
    implements $DistrictCopyWith<$Res> {
  _$DistrictCopyWithImpl(this._self, this._then);

  final District _self;
  final $Res Function(District) _then;

/// Create a copy of District
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? divisionId = null,Object? nameEn = null,Object? nameBn = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,divisionId: null == divisionId ? _self.divisionId : divisionId // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [District].
extension DistrictPatterns on District {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _District value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _District() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _District value)  $default,){
final _that = this;
switch (_that) {
case _District():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _District value)?  $default,){
final _that = this;
switch (_that) {
case _District() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int divisionId,  String nameEn,  String? nameBn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _District() when $default != null:
return $default(_that.id,_that.divisionId,_that.nameEn,_that.nameBn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int divisionId,  String nameEn,  String? nameBn)  $default,) {final _that = this;
switch (_that) {
case _District():
return $default(_that.id,_that.divisionId,_that.nameEn,_that.nameBn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int divisionId,  String nameEn,  String? nameBn)?  $default,) {final _that = this;
switch (_that) {
case _District() when $default != null:
return $default(_that.id,_that.divisionId,_that.nameEn,_that.nameBn);case _:
  return null;

}
}

}

/// @nodoc


class _District extends District with DiagnosticableTreeMixin {
  const _District({required this.id, required this.divisionId, required this.nameEn, this.nameBn}): super._();
  

@override final  int id;
@override final  int divisionId;
@override final  String nameEn;
@override final  String? nameBn;

/// Create a copy of District
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DistrictCopyWith<_District> get copyWith => __$DistrictCopyWithImpl<_District>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'District'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('divisionId', divisionId))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _District&&(identical(other.id, id) || other.id == id)&&(identical(other.divisionId, divisionId) || other.divisionId == divisionId)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn));
}


@override
int get hashCode => Object.hash(runtimeType,id,divisionId,nameEn,nameBn);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'District(id: $id, divisionId: $divisionId, nameEn: $nameEn, nameBn: $nameBn)';
}


}

/// @nodoc
abstract mixin class _$DistrictCopyWith<$Res> implements $DistrictCopyWith<$Res> {
  factory _$DistrictCopyWith(_District value, $Res Function(_District) _then) = __$DistrictCopyWithImpl;
@override @useResult
$Res call({
 int id, int divisionId, String nameEn, String? nameBn
});




}
/// @nodoc
class __$DistrictCopyWithImpl<$Res>
    implements _$DistrictCopyWith<$Res> {
  __$DistrictCopyWithImpl(this._self, this._then);

  final _District _self;
  final $Res Function(_District) _then;

/// Create a copy of District
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? divisionId = null,Object? nameEn = null,Object? nameBn = freezed,}) {
  return _then(_District(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,divisionId: null == divisionId ? _self.divisionId : divisionId // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$Upazila implements DiagnosticableTreeMixin {

 int get id; int get districtId; String get nameEn; String? get nameBn;
/// Create a copy of Upazila
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpazilaCopyWith<Upazila> get copyWith => _$UpazilaCopyWithImpl<Upazila>(this as Upazila, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Upazila'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('districtId', districtId))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Upazila&&(identical(other.id, id) || other.id == id)&&(identical(other.districtId, districtId) || other.districtId == districtId)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn));
}


@override
int get hashCode => Object.hash(runtimeType,id,districtId,nameEn,nameBn);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Upazila(id: $id, districtId: $districtId, nameEn: $nameEn, nameBn: $nameBn)';
}


}

/// @nodoc
abstract mixin class $UpazilaCopyWith<$Res>  {
  factory $UpazilaCopyWith(Upazila value, $Res Function(Upazila) _then) = _$UpazilaCopyWithImpl;
@useResult
$Res call({
 int id, int districtId, String nameEn, String? nameBn
});




}
/// @nodoc
class _$UpazilaCopyWithImpl<$Res>
    implements $UpazilaCopyWith<$Res> {
  _$UpazilaCopyWithImpl(this._self, this._then);

  final Upazila _self;
  final $Res Function(Upazila) _then;

/// Create a copy of Upazila
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? districtId = null,Object? nameEn = null,Object? nameBn = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,districtId: null == districtId ? _self.districtId : districtId // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Upazila].
extension UpazilaPatterns on Upazila {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Upazila value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Upazila() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Upazila value)  $default,){
final _that = this;
switch (_that) {
case _Upazila():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Upazila value)?  $default,){
final _that = this;
switch (_that) {
case _Upazila() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int districtId,  String nameEn,  String? nameBn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Upazila() when $default != null:
return $default(_that.id,_that.districtId,_that.nameEn,_that.nameBn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int districtId,  String nameEn,  String? nameBn)  $default,) {final _that = this;
switch (_that) {
case _Upazila():
return $default(_that.id,_that.districtId,_that.nameEn,_that.nameBn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int districtId,  String nameEn,  String? nameBn)?  $default,) {final _that = this;
switch (_that) {
case _Upazila() when $default != null:
return $default(_that.id,_that.districtId,_that.nameEn,_that.nameBn);case _:
  return null;

}
}

}

/// @nodoc


class _Upazila extends Upazila with DiagnosticableTreeMixin {
  const _Upazila({required this.id, required this.districtId, required this.nameEn, this.nameBn}): super._();
  

@override final  int id;
@override final  int districtId;
@override final  String nameEn;
@override final  String? nameBn;

/// Create a copy of Upazila
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpazilaCopyWith<_Upazila> get copyWith => __$UpazilaCopyWithImpl<_Upazila>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Upazila'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('districtId', districtId))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Upazila&&(identical(other.id, id) || other.id == id)&&(identical(other.districtId, districtId) || other.districtId == districtId)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn));
}


@override
int get hashCode => Object.hash(runtimeType,id,districtId,nameEn,nameBn);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Upazila(id: $id, districtId: $districtId, nameEn: $nameEn, nameBn: $nameBn)';
}


}

/// @nodoc
abstract mixin class _$UpazilaCopyWith<$Res> implements $UpazilaCopyWith<$Res> {
  factory _$UpazilaCopyWith(_Upazila value, $Res Function(_Upazila) _then) = __$UpazilaCopyWithImpl;
@override @useResult
$Res call({
 int id, int districtId, String nameEn, String? nameBn
});




}
/// @nodoc
class __$UpazilaCopyWithImpl<$Res>
    implements _$UpazilaCopyWith<$Res> {
  __$UpazilaCopyWithImpl(this._self, this._then);

  final _Upazila _self;
  final $Res Function(_Upazila) _then;

/// Create a copy of Upazila
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? districtId = null,Object? nameEn = null,Object? nameBn = freezed,}) {
  return _then(_Upazila(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,districtId: null == districtId ? _self.districtId : districtId // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$Base implements DiagnosticableTreeMixin {

 int get id; int get areaId; String get nameEn; String? get nameBn; List<int> get upazilaIds;
/// Create a copy of Base
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseCopyWith<Base> get copyWith => _$BaseCopyWithImpl<Base>(this as Base, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Base'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('areaId', areaId))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn))..add(DiagnosticsProperty('upazilaIds', upazilaIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Base&&(identical(other.id, id) || other.id == id)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&const DeepCollectionEquality().equals(other.upazilaIds, upazilaIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,areaId,nameEn,nameBn,const DeepCollectionEquality().hash(upazilaIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Base(id: $id, areaId: $areaId, nameEn: $nameEn, nameBn: $nameBn, upazilaIds: $upazilaIds)';
}


}

/// @nodoc
abstract mixin class $BaseCopyWith<$Res>  {
  factory $BaseCopyWith(Base value, $Res Function(Base) _then) = _$BaseCopyWithImpl;
@useResult
$Res call({
 int id, int areaId, String nameEn, String? nameBn, List<int> upazilaIds
});




}
/// @nodoc
class _$BaseCopyWithImpl<$Res>
    implements $BaseCopyWith<$Res> {
  _$BaseCopyWithImpl(this._self, this._then);

  final Base _self;
  final $Res Function(Base) _then;

/// Create a copy of Base
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? areaId = null,Object? nameEn = null,Object? nameBn = freezed,Object? upazilaIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,upazilaIds: null == upazilaIds ? _self.upazilaIds : upazilaIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [Base].
extension BasePatterns on Base {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Base value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Base() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Base value)  $default,){
final _that = this;
switch (_that) {
case _Base():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Base value)?  $default,){
final _that = this;
switch (_that) {
case _Base() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int areaId,  String nameEn,  String? nameBn,  List<int> upazilaIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Base() when $default != null:
return $default(_that.id,_that.areaId,_that.nameEn,_that.nameBn,_that.upazilaIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int areaId,  String nameEn,  String? nameBn,  List<int> upazilaIds)  $default,) {final _that = this;
switch (_that) {
case _Base():
return $default(_that.id,_that.areaId,_that.nameEn,_that.nameBn,_that.upazilaIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int areaId,  String nameEn,  String? nameBn,  List<int> upazilaIds)?  $default,) {final _that = this;
switch (_that) {
case _Base() when $default != null:
return $default(_that.id,_that.areaId,_that.nameEn,_that.nameBn,_that.upazilaIds);case _:
  return null;

}
}

}

/// @nodoc


class _Base extends Base with DiagnosticableTreeMixin {
  const _Base({required this.id, required this.areaId, required this.nameEn, this.nameBn, final  List<int> upazilaIds = const []}): _upazilaIds = upazilaIds,super._();
  

@override final  int id;
@override final  int areaId;
@override final  String nameEn;
@override final  String? nameBn;
 final  List<int> _upazilaIds;
@override@JsonKey() List<int> get upazilaIds {
  if (_upazilaIds is EqualUnmodifiableListView) return _upazilaIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upazilaIds);
}


/// Create a copy of Base
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BaseCopyWith<_Base> get copyWith => __$BaseCopyWithImpl<_Base>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Base'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('areaId', areaId))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn))..add(DiagnosticsProperty('upazilaIds', upazilaIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Base&&(identical(other.id, id) || other.id == id)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&const DeepCollectionEquality().equals(other._upazilaIds, _upazilaIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,areaId,nameEn,nameBn,const DeepCollectionEquality().hash(_upazilaIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Base(id: $id, areaId: $areaId, nameEn: $nameEn, nameBn: $nameBn, upazilaIds: $upazilaIds)';
}


}

/// @nodoc
abstract mixin class _$BaseCopyWith<$Res> implements $BaseCopyWith<$Res> {
  factory _$BaseCopyWith(_Base value, $Res Function(_Base) _then) = __$BaseCopyWithImpl;
@override @useResult
$Res call({
 int id, int areaId, String nameEn, String? nameBn, List<int> upazilaIds
});




}
/// @nodoc
class __$BaseCopyWithImpl<$Res>
    implements _$BaseCopyWith<$Res> {
  __$BaseCopyWithImpl(this._self, this._then);

  final _Base _self;
  final $Res Function(_Base) _then;

/// Create a copy of Base
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? areaId = null,Object? nameEn = null,Object? nameBn = freezed,Object? upazilaIds = null,}) {
  return _then(_Base(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,upazilaIds: null == upazilaIds ? _self._upazilaIds : upazilaIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
mixin _$Distributor implements DiagnosticableTreeMixin {

 int get id; String get nameEn; String? get nameBn; String? get designation; String? get addressEn; String? get addressBn; int? get upazilaId; int? get baseId; int? get areaId; String? get mobile; bool get isActive; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Distributor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DistributorCopyWith<Distributor> get copyWith => _$DistributorCopyWithImpl<Distributor>(this as Distributor, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Distributor'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn))..add(DiagnosticsProperty('designation', designation))..add(DiagnosticsProperty('addressEn', addressEn))..add(DiagnosticsProperty('addressBn', addressBn))..add(DiagnosticsProperty('upazilaId', upazilaId))..add(DiagnosticsProperty('baseId', baseId))..add(DiagnosticsProperty('areaId', areaId))..add(DiagnosticsProperty('mobile', mobile))..add(DiagnosticsProperty('isActive', isActive))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Distributor&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.addressEn, addressEn) || other.addressEn == addressEn)&&(identical(other.addressBn, addressBn) || other.addressBn == addressBn)&&(identical(other.upazilaId, upazilaId) || other.upazilaId == upazilaId)&&(identical(other.baseId, baseId) || other.baseId == baseId)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn,designation,addressEn,addressBn,upazilaId,baseId,areaId,mobile,isActive,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Distributor(id: $id, nameEn: $nameEn, nameBn: $nameBn, designation: $designation, addressEn: $addressEn, addressBn: $addressBn, upazilaId: $upazilaId, baseId: $baseId, areaId: $areaId, mobile: $mobile, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DistributorCopyWith<$Res>  {
  factory $DistributorCopyWith(Distributor value, $Res Function(Distributor) _then) = _$DistributorCopyWithImpl;
@useResult
$Res call({
 int id, String nameEn, String? nameBn, String? designation, String? addressEn, String? addressBn, int? upazilaId, int? baseId, int? areaId, String? mobile, bool isActive, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$DistributorCopyWithImpl<$Res>
    implements $DistributorCopyWith<$Res> {
  _$DistributorCopyWithImpl(this._self, this._then);

  final Distributor _self;
  final $Res Function(Distributor) _then;

/// Create a copy of Distributor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,Object? designation = freezed,Object? addressEn = freezed,Object? addressBn = freezed,Object? upazilaId = freezed,Object? baseId = freezed,Object? areaId = freezed,Object? mobile = freezed,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,addressEn: freezed == addressEn ? _self.addressEn : addressEn // ignore: cast_nullable_to_non_nullable
as String?,addressBn: freezed == addressBn ? _self.addressBn : addressBn // ignore: cast_nullable_to_non_nullable
as String?,upazilaId: freezed == upazilaId ? _self.upazilaId : upazilaId // ignore: cast_nullable_to_non_nullable
as int?,baseId: freezed == baseId ? _self.baseId : baseId // ignore: cast_nullable_to_non_nullable
as int?,areaId: freezed == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Distributor].
extension DistributorPatterns on Distributor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Distributor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Distributor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Distributor value)  $default,){
final _that = this;
switch (_that) {
case _Distributor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Distributor value)?  $default,){
final _that = this;
switch (_that) {
case _Distributor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nameEn,  String? nameBn,  String? designation,  String? addressEn,  String? addressBn,  int? upazilaId,  int? baseId,  int? areaId,  String? mobile,  bool isActive,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Distributor() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn,_that.designation,_that.addressEn,_that.addressBn,_that.upazilaId,_that.baseId,_that.areaId,_that.mobile,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nameEn,  String? nameBn,  String? designation,  String? addressEn,  String? addressBn,  int? upazilaId,  int? baseId,  int? areaId,  String? mobile,  bool isActive,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Distributor():
return $default(_that.id,_that.nameEn,_that.nameBn,_that.designation,_that.addressEn,_that.addressBn,_that.upazilaId,_that.baseId,_that.areaId,_that.mobile,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nameEn,  String? nameBn,  String? designation,  String? addressEn,  String? addressBn,  int? upazilaId,  int? baseId,  int? areaId,  String? mobile,  bool isActive,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Distributor() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn,_that.designation,_that.addressEn,_that.addressBn,_that.upazilaId,_that.baseId,_that.areaId,_that.mobile,_that.isActive,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Distributor extends Distributor with DiagnosticableTreeMixin {
  const _Distributor({required this.id, required this.nameEn, this.nameBn, this.designation, this.addressEn, this.addressBn, this.upazilaId, this.baseId, this.areaId, this.mobile, this.isActive = true, required this.createdAt, required this.updatedAt}): super._();
  

@override final  int id;
@override final  String nameEn;
@override final  String? nameBn;
@override final  String? designation;
@override final  String? addressEn;
@override final  String? addressBn;
@override final  int? upazilaId;
@override final  int? baseId;
@override final  int? areaId;
@override final  String? mobile;
@override@JsonKey() final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Distributor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DistributorCopyWith<_Distributor> get copyWith => __$DistributorCopyWithImpl<_Distributor>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Distributor'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn))..add(DiagnosticsProperty('designation', designation))..add(DiagnosticsProperty('addressEn', addressEn))..add(DiagnosticsProperty('addressBn', addressBn))..add(DiagnosticsProperty('upazilaId', upazilaId))..add(DiagnosticsProperty('baseId', baseId))..add(DiagnosticsProperty('areaId', areaId))..add(DiagnosticsProperty('mobile', mobile))..add(DiagnosticsProperty('isActive', isActive))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Distributor&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.addressEn, addressEn) || other.addressEn == addressEn)&&(identical(other.addressBn, addressBn) || other.addressBn == addressBn)&&(identical(other.upazilaId, upazilaId) || other.upazilaId == upazilaId)&&(identical(other.baseId, baseId) || other.baseId == baseId)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn,designation,addressEn,addressBn,upazilaId,baseId,areaId,mobile,isActive,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Distributor(id: $id, nameEn: $nameEn, nameBn: $nameBn, designation: $designation, addressEn: $addressEn, addressBn: $addressBn, upazilaId: $upazilaId, baseId: $baseId, areaId: $areaId, mobile: $mobile, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DistributorCopyWith<$Res> implements $DistributorCopyWith<$Res> {
  factory _$DistributorCopyWith(_Distributor value, $Res Function(_Distributor) _then) = __$DistributorCopyWithImpl;
@override @useResult
$Res call({
 int id, String nameEn, String? nameBn, String? designation, String? addressEn, String? addressBn, int? upazilaId, int? baseId, int? areaId, String? mobile, bool isActive, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$DistributorCopyWithImpl<$Res>
    implements _$DistributorCopyWith<$Res> {
  __$DistributorCopyWithImpl(this._self, this._then);

  final _Distributor _self;
  final $Res Function(_Distributor) _then;

/// Create a copy of Distributor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,Object? designation = freezed,Object? addressEn = freezed,Object? addressBn = freezed,Object? upazilaId = freezed,Object? baseId = freezed,Object? areaId = freezed,Object? mobile = freezed,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Distributor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,addressEn: freezed == addressEn ? _self.addressEn : addressEn // ignore: cast_nullable_to_non_nullable
as String?,addressBn: freezed == addressBn ? _self.addressBn : addressBn // ignore: cast_nullable_to_non_nullable
as String?,upazilaId: freezed == upazilaId ? _self.upazilaId : upazilaId // ignore: cast_nullable_to_non_nullable
as int?,baseId: freezed == baseId ? _self.baseId : baseId // ignore: cast_nullable_to_non_nullable
as int?,areaId: freezed == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$SalesPersonnel implements DiagnosticableTreeMixin {

 int get id; String get nameEn; String? get nameBn; String? get designation; String? get photoUrl; String? get mobile; String? get email; String? get employeeId; bool get isActive; DateTime get createdAt; DateTime get updatedAt; List<int> get regionIds; List<int> get areaIds; List<int> get baseIds; List<int> get upazilaIds;
/// Create a copy of SalesPersonnel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesPersonnelCopyWith<SalesPersonnel> get copyWith => _$SalesPersonnelCopyWithImpl<SalesPersonnel>(this as SalesPersonnel, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SalesPersonnel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn))..add(DiagnosticsProperty('designation', designation))..add(DiagnosticsProperty('photoUrl', photoUrl))..add(DiagnosticsProperty('mobile', mobile))..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('employeeId', employeeId))..add(DiagnosticsProperty('isActive', isActive))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('regionIds', regionIds))..add(DiagnosticsProperty('areaIds', areaIds))..add(DiagnosticsProperty('baseIds', baseIds))..add(DiagnosticsProperty('upazilaIds', upazilaIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesPersonnel&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.email, email) || other.email == email)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.regionIds, regionIds)&&const DeepCollectionEquality().equals(other.areaIds, areaIds)&&const DeepCollectionEquality().equals(other.baseIds, baseIds)&&const DeepCollectionEquality().equals(other.upazilaIds, upazilaIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn,designation,photoUrl,mobile,email,employeeId,isActive,createdAt,updatedAt,const DeepCollectionEquality().hash(regionIds),const DeepCollectionEquality().hash(areaIds),const DeepCollectionEquality().hash(baseIds),const DeepCollectionEquality().hash(upazilaIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SalesPersonnel(id: $id, nameEn: $nameEn, nameBn: $nameBn, designation: $designation, photoUrl: $photoUrl, mobile: $mobile, email: $email, employeeId: $employeeId, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, regionIds: $regionIds, areaIds: $areaIds, baseIds: $baseIds, upazilaIds: $upazilaIds)';
}


}

/// @nodoc
abstract mixin class $SalesPersonnelCopyWith<$Res>  {
  factory $SalesPersonnelCopyWith(SalesPersonnel value, $Res Function(SalesPersonnel) _then) = _$SalesPersonnelCopyWithImpl;
@useResult
$Res call({
 int id, String nameEn, String? nameBn, String? designation, String? photoUrl, String? mobile, String? email, String? employeeId, bool isActive, DateTime createdAt, DateTime updatedAt, List<int> regionIds, List<int> areaIds, List<int> baseIds, List<int> upazilaIds
});




}
/// @nodoc
class _$SalesPersonnelCopyWithImpl<$Res>
    implements $SalesPersonnelCopyWith<$Res> {
  _$SalesPersonnelCopyWithImpl(this._self, this._then);

  final SalesPersonnel _self;
  final $Res Function(SalesPersonnel) _then;

/// Create a copy of SalesPersonnel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,Object? designation = freezed,Object? photoUrl = freezed,Object? mobile = freezed,Object? email = freezed,Object? employeeId = freezed,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? regionIds = null,Object? areaIds = null,Object? baseIds = null,Object? upazilaIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,employeeId: freezed == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,regionIds: null == regionIds ? _self.regionIds : regionIds // ignore: cast_nullable_to_non_nullable
as List<int>,areaIds: null == areaIds ? _self.areaIds : areaIds // ignore: cast_nullable_to_non_nullable
as List<int>,baseIds: null == baseIds ? _self.baseIds : baseIds // ignore: cast_nullable_to_non_nullable
as List<int>,upazilaIds: null == upazilaIds ? _self.upazilaIds : upazilaIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesPersonnel].
extension SalesPersonnelPatterns on SalesPersonnel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesPersonnel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesPersonnel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesPersonnel value)  $default,){
final _that = this;
switch (_that) {
case _SalesPersonnel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesPersonnel value)?  $default,){
final _that = this;
switch (_that) {
case _SalesPersonnel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nameEn,  String? nameBn,  String? designation,  String? photoUrl,  String? mobile,  String? email,  String? employeeId,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  List<int> regionIds,  List<int> areaIds,  List<int> baseIds,  List<int> upazilaIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesPersonnel() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn,_that.designation,_that.photoUrl,_that.mobile,_that.email,_that.employeeId,_that.isActive,_that.createdAt,_that.updatedAt,_that.regionIds,_that.areaIds,_that.baseIds,_that.upazilaIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nameEn,  String? nameBn,  String? designation,  String? photoUrl,  String? mobile,  String? email,  String? employeeId,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  List<int> regionIds,  List<int> areaIds,  List<int> baseIds,  List<int> upazilaIds)  $default,) {final _that = this;
switch (_that) {
case _SalesPersonnel():
return $default(_that.id,_that.nameEn,_that.nameBn,_that.designation,_that.photoUrl,_that.mobile,_that.email,_that.employeeId,_that.isActive,_that.createdAt,_that.updatedAt,_that.regionIds,_that.areaIds,_that.baseIds,_that.upazilaIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nameEn,  String? nameBn,  String? designation,  String? photoUrl,  String? mobile,  String? email,  String? employeeId,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  List<int> regionIds,  List<int> areaIds,  List<int> baseIds,  List<int> upazilaIds)?  $default,) {final _that = this;
switch (_that) {
case _SalesPersonnel() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn,_that.designation,_that.photoUrl,_that.mobile,_that.email,_that.employeeId,_that.isActive,_that.createdAt,_that.updatedAt,_that.regionIds,_that.areaIds,_that.baseIds,_that.upazilaIds);case _:
  return null;

}
}

}

/// @nodoc


class _SalesPersonnel extends SalesPersonnel with DiagnosticableTreeMixin {
  const _SalesPersonnel({required this.id, required this.nameEn, this.nameBn, this.designation, this.photoUrl, this.mobile, this.email, this.employeeId, this.isActive = true, required this.createdAt, required this.updatedAt, final  List<int> regionIds = const [], final  List<int> areaIds = const [], final  List<int> baseIds = const [], final  List<int> upazilaIds = const []}): _regionIds = regionIds,_areaIds = areaIds,_baseIds = baseIds,_upazilaIds = upazilaIds,super._();
  

@override final  int id;
@override final  String nameEn;
@override final  String? nameBn;
@override final  String? designation;
@override final  String? photoUrl;
@override final  String? mobile;
@override final  String? email;
@override final  String? employeeId;
@override@JsonKey() final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
 final  List<int> _regionIds;
@override@JsonKey() List<int> get regionIds {
  if (_regionIds is EqualUnmodifiableListView) return _regionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regionIds);
}

 final  List<int> _areaIds;
@override@JsonKey() List<int> get areaIds {
  if (_areaIds is EqualUnmodifiableListView) return _areaIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaIds);
}

 final  List<int> _baseIds;
@override@JsonKey() List<int> get baseIds {
  if (_baseIds is EqualUnmodifiableListView) return _baseIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_baseIds);
}

 final  List<int> _upazilaIds;
@override@JsonKey() List<int> get upazilaIds {
  if (_upazilaIds is EqualUnmodifiableListView) return _upazilaIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upazilaIds);
}


/// Create a copy of SalesPersonnel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesPersonnelCopyWith<_SalesPersonnel> get copyWith => __$SalesPersonnelCopyWithImpl<_SalesPersonnel>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SalesPersonnel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn))..add(DiagnosticsProperty('designation', designation))..add(DiagnosticsProperty('photoUrl', photoUrl))..add(DiagnosticsProperty('mobile', mobile))..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('employeeId', employeeId))..add(DiagnosticsProperty('isActive', isActive))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('regionIds', regionIds))..add(DiagnosticsProperty('areaIds', areaIds))..add(DiagnosticsProperty('baseIds', baseIds))..add(DiagnosticsProperty('upazilaIds', upazilaIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesPersonnel&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.email, email) || other.email == email)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._regionIds, _regionIds)&&const DeepCollectionEquality().equals(other._areaIds, _areaIds)&&const DeepCollectionEquality().equals(other._baseIds, _baseIds)&&const DeepCollectionEquality().equals(other._upazilaIds, _upazilaIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn,designation,photoUrl,mobile,email,employeeId,isActive,createdAt,updatedAt,const DeepCollectionEquality().hash(_regionIds),const DeepCollectionEquality().hash(_areaIds),const DeepCollectionEquality().hash(_baseIds),const DeepCollectionEquality().hash(_upazilaIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SalesPersonnel(id: $id, nameEn: $nameEn, nameBn: $nameBn, designation: $designation, photoUrl: $photoUrl, mobile: $mobile, email: $email, employeeId: $employeeId, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, regionIds: $regionIds, areaIds: $areaIds, baseIds: $baseIds, upazilaIds: $upazilaIds)';
}


}

/// @nodoc
abstract mixin class _$SalesPersonnelCopyWith<$Res> implements $SalesPersonnelCopyWith<$Res> {
  factory _$SalesPersonnelCopyWith(_SalesPersonnel value, $Res Function(_SalesPersonnel) _then) = __$SalesPersonnelCopyWithImpl;
@override @useResult
$Res call({
 int id, String nameEn, String? nameBn, String? designation, String? photoUrl, String? mobile, String? email, String? employeeId, bool isActive, DateTime createdAt, DateTime updatedAt, List<int> regionIds, List<int> areaIds, List<int> baseIds, List<int> upazilaIds
});




}
/// @nodoc
class __$SalesPersonnelCopyWithImpl<$Res>
    implements _$SalesPersonnelCopyWith<$Res> {
  __$SalesPersonnelCopyWithImpl(this._self, this._then);

  final _SalesPersonnel _self;
  final $Res Function(_SalesPersonnel) _then;

/// Create a copy of SalesPersonnel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,Object? designation = freezed,Object? photoUrl = freezed,Object? mobile = freezed,Object? email = freezed,Object? employeeId = freezed,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? regionIds = null,Object? areaIds = null,Object? baseIds = null,Object? upazilaIds = null,}) {
  return _then(_SalesPersonnel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,employeeId: freezed == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,regionIds: null == regionIds ? _self._regionIds : regionIds // ignore: cast_nullable_to_non_nullable
as List<int>,areaIds: null == areaIds ? _self._areaIds : areaIds // ignore: cast_nullable_to_non_nullable
as List<int>,baseIds: null == baseIds ? _self._baseIds : baseIds // ignore: cast_nullable_to_non_nullable
as List<int>,upazilaIds: null == upazilaIds ? _self._upazilaIds : upazilaIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
mixin _$VetDoctor implements DiagnosticableTreeMixin {

 int get id; String get nameEn; String? get nameBn; String? get photoUrl; String? get qualification; String? get specialization; String? get bvcRegistrationNo; String? get clinicOrHospitalNameEn; String? get clinicOrHospitalNameBn; String? get addressEn; String? get addressBn; String? get mobile; String? get email; bool get isActive; DateTime get createdAt; DateTime get updatedAt; List<int> get regionIds; List<int> get areaIds; List<int> get baseIds; List<int> get upazilaIds;
/// Create a copy of VetDoctor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VetDoctorCopyWith<VetDoctor> get copyWith => _$VetDoctorCopyWithImpl<VetDoctor>(this as VetDoctor, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VetDoctor'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn))..add(DiagnosticsProperty('photoUrl', photoUrl))..add(DiagnosticsProperty('qualification', qualification))..add(DiagnosticsProperty('specialization', specialization))..add(DiagnosticsProperty('bvcRegistrationNo', bvcRegistrationNo))..add(DiagnosticsProperty('clinicOrHospitalNameEn', clinicOrHospitalNameEn))..add(DiagnosticsProperty('clinicOrHospitalNameBn', clinicOrHospitalNameBn))..add(DiagnosticsProperty('addressEn', addressEn))..add(DiagnosticsProperty('addressBn', addressBn))..add(DiagnosticsProperty('mobile', mobile))..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('isActive', isActive))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('regionIds', regionIds))..add(DiagnosticsProperty('areaIds', areaIds))..add(DiagnosticsProperty('baseIds', baseIds))..add(DiagnosticsProperty('upazilaIds', upazilaIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VetDoctor&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.qualification, qualification) || other.qualification == qualification)&&(identical(other.specialization, specialization) || other.specialization == specialization)&&(identical(other.bvcRegistrationNo, bvcRegistrationNo) || other.bvcRegistrationNo == bvcRegistrationNo)&&(identical(other.clinicOrHospitalNameEn, clinicOrHospitalNameEn) || other.clinicOrHospitalNameEn == clinicOrHospitalNameEn)&&(identical(other.clinicOrHospitalNameBn, clinicOrHospitalNameBn) || other.clinicOrHospitalNameBn == clinicOrHospitalNameBn)&&(identical(other.addressEn, addressEn) || other.addressEn == addressEn)&&(identical(other.addressBn, addressBn) || other.addressBn == addressBn)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.email, email) || other.email == email)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.regionIds, regionIds)&&const DeepCollectionEquality().equals(other.areaIds, areaIds)&&const DeepCollectionEquality().equals(other.baseIds, baseIds)&&const DeepCollectionEquality().equals(other.upazilaIds, upazilaIds));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,nameEn,nameBn,photoUrl,qualification,specialization,bvcRegistrationNo,clinicOrHospitalNameEn,clinicOrHospitalNameBn,addressEn,addressBn,mobile,email,isActive,createdAt,updatedAt,const DeepCollectionEquality().hash(regionIds),const DeepCollectionEquality().hash(areaIds),const DeepCollectionEquality().hash(baseIds),const DeepCollectionEquality().hash(upazilaIds)]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VetDoctor(id: $id, nameEn: $nameEn, nameBn: $nameBn, photoUrl: $photoUrl, qualification: $qualification, specialization: $specialization, bvcRegistrationNo: $bvcRegistrationNo, clinicOrHospitalNameEn: $clinicOrHospitalNameEn, clinicOrHospitalNameBn: $clinicOrHospitalNameBn, addressEn: $addressEn, addressBn: $addressBn, mobile: $mobile, email: $email, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, regionIds: $regionIds, areaIds: $areaIds, baseIds: $baseIds, upazilaIds: $upazilaIds)';
}


}

/// @nodoc
abstract mixin class $VetDoctorCopyWith<$Res>  {
  factory $VetDoctorCopyWith(VetDoctor value, $Res Function(VetDoctor) _then) = _$VetDoctorCopyWithImpl;
@useResult
$Res call({
 int id, String nameEn, String? nameBn, String? photoUrl, String? qualification, String? specialization, String? bvcRegistrationNo, String? clinicOrHospitalNameEn, String? clinicOrHospitalNameBn, String? addressEn, String? addressBn, String? mobile, String? email, bool isActive, DateTime createdAt, DateTime updatedAt, List<int> regionIds, List<int> areaIds, List<int> baseIds, List<int> upazilaIds
});




}
/// @nodoc
class _$VetDoctorCopyWithImpl<$Res>
    implements $VetDoctorCopyWith<$Res> {
  _$VetDoctorCopyWithImpl(this._self, this._then);

  final VetDoctor _self;
  final $Res Function(VetDoctor) _then;

/// Create a copy of VetDoctor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,Object? photoUrl = freezed,Object? qualification = freezed,Object? specialization = freezed,Object? bvcRegistrationNo = freezed,Object? clinicOrHospitalNameEn = freezed,Object? clinicOrHospitalNameBn = freezed,Object? addressEn = freezed,Object? addressBn = freezed,Object? mobile = freezed,Object? email = freezed,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? regionIds = null,Object? areaIds = null,Object? baseIds = null,Object? upazilaIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,qualification: freezed == qualification ? _self.qualification : qualification // ignore: cast_nullable_to_non_nullable
as String?,specialization: freezed == specialization ? _self.specialization : specialization // ignore: cast_nullable_to_non_nullable
as String?,bvcRegistrationNo: freezed == bvcRegistrationNo ? _self.bvcRegistrationNo : bvcRegistrationNo // ignore: cast_nullable_to_non_nullable
as String?,clinicOrHospitalNameEn: freezed == clinicOrHospitalNameEn ? _self.clinicOrHospitalNameEn : clinicOrHospitalNameEn // ignore: cast_nullable_to_non_nullable
as String?,clinicOrHospitalNameBn: freezed == clinicOrHospitalNameBn ? _self.clinicOrHospitalNameBn : clinicOrHospitalNameBn // ignore: cast_nullable_to_non_nullable
as String?,addressEn: freezed == addressEn ? _self.addressEn : addressEn // ignore: cast_nullable_to_non_nullable
as String?,addressBn: freezed == addressBn ? _self.addressBn : addressBn // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,regionIds: null == regionIds ? _self.regionIds : regionIds // ignore: cast_nullable_to_non_nullable
as List<int>,areaIds: null == areaIds ? _self.areaIds : areaIds // ignore: cast_nullable_to_non_nullable
as List<int>,baseIds: null == baseIds ? _self.baseIds : baseIds // ignore: cast_nullable_to_non_nullable
as List<int>,upazilaIds: null == upazilaIds ? _self.upazilaIds : upazilaIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [VetDoctor].
extension VetDoctorPatterns on VetDoctor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VetDoctor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VetDoctor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VetDoctor value)  $default,){
final _that = this;
switch (_that) {
case _VetDoctor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VetDoctor value)?  $default,){
final _that = this;
switch (_that) {
case _VetDoctor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nameEn,  String? nameBn,  String? photoUrl,  String? qualification,  String? specialization,  String? bvcRegistrationNo,  String? clinicOrHospitalNameEn,  String? clinicOrHospitalNameBn,  String? addressEn,  String? addressBn,  String? mobile,  String? email,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  List<int> regionIds,  List<int> areaIds,  List<int> baseIds,  List<int> upazilaIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VetDoctor() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn,_that.photoUrl,_that.qualification,_that.specialization,_that.bvcRegistrationNo,_that.clinicOrHospitalNameEn,_that.clinicOrHospitalNameBn,_that.addressEn,_that.addressBn,_that.mobile,_that.email,_that.isActive,_that.createdAt,_that.updatedAt,_that.regionIds,_that.areaIds,_that.baseIds,_that.upazilaIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nameEn,  String? nameBn,  String? photoUrl,  String? qualification,  String? specialization,  String? bvcRegistrationNo,  String? clinicOrHospitalNameEn,  String? clinicOrHospitalNameBn,  String? addressEn,  String? addressBn,  String? mobile,  String? email,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  List<int> regionIds,  List<int> areaIds,  List<int> baseIds,  List<int> upazilaIds)  $default,) {final _that = this;
switch (_that) {
case _VetDoctor():
return $default(_that.id,_that.nameEn,_that.nameBn,_that.photoUrl,_that.qualification,_that.specialization,_that.bvcRegistrationNo,_that.clinicOrHospitalNameEn,_that.clinicOrHospitalNameBn,_that.addressEn,_that.addressBn,_that.mobile,_that.email,_that.isActive,_that.createdAt,_that.updatedAt,_that.regionIds,_that.areaIds,_that.baseIds,_that.upazilaIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nameEn,  String? nameBn,  String? photoUrl,  String? qualification,  String? specialization,  String? bvcRegistrationNo,  String? clinicOrHospitalNameEn,  String? clinicOrHospitalNameBn,  String? addressEn,  String? addressBn,  String? mobile,  String? email,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  List<int> regionIds,  List<int> areaIds,  List<int> baseIds,  List<int> upazilaIds)?  $default,) {final _that = this;
switch (_that) {
case _VetDoctor() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn,_that.photoUrl,_that.qualification,_that.specialization,_that.bvcRegistrationNo,_that.clinicOrHospitalNameEn,_that.clinicOrHospitalNameBn,_that.addressEn,_that.addressBn,_that.mobile,_that.email,_that.isActive,_that.createdAt,_that.updatedAt,_that.regionIds,_that.areaIds,_that.baseIds,_that.upazilaIds);case _:
  return null;

}
}

}

/// @nodoc


class _VetDoctor extends VetDoctor with DiagnosticableTreeMixin {
  const _VetDoctor({required this.id, required this.nameEn, this.nameBn, this.photoUrl, this.qualification, this.specialization, this.bvcRegistrationNo, this.clinicOrHospitalNameEn, this.clinicOrHospitalNameBn, this.addressEn, this.addressBn, this.mobile, this.email, this.isActive = true, required this.createdAt, required this.updatedAt, final  List<int> regionIds = const [], final  List<int> areaIds = const [], final  List<int> baseIds = const [], final  List<int> upazilaIds = const []}): _regionIds = regionIds,_areaIds = areaIds,_baseIds = baseIds,_upazilaIds = upazilaIds,super._();
  

@override final  int id;
@override final  String nameEn;
@override final  String? nameBn;
@override final  String? photoUrl;
@override final  String? qualification;
@override final  String? specialization;
@override final  String? bvcRegistrationNo;
@override final  String? clinicOrHospitalNameEn;
@override final  String? clinicOrHospitalNameBn;
@override final  String? addressEn;
@override final  String? addressBn;
@override final  String? mobile;
@override final  String? email;
@override@JsonKey() final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
 final  List<int> _regionIds;
@override@JsonKey() List<int> get regionIds {
  if (_regionIds is EqualUnmodifiableListView) return _regionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regionIds);
}

 final  List<int> _areaIds;
@override@JsonKey() List<int> get areaIds {
  if (_areaIds is EqualUnmodifiableListView) return _areaIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaIds);
}

 final  List<int> _baseIds;
@override@JsonKey() List<int> get baseIds {
  if (_baseIds is EqualUnmodifiableListView) return _baseIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_baseIds);
}

 final  List<int> _upazilaIds;
@override@JsonKey() List<int> get upazilaIds {
  if (_upazilaIds is EqualUnmodifiableListView) return _upazilaIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upazilaIds);
}


/// Create a copy of VetDoctor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VetDoctorCopyWith<_VetDoctor> get copyWith => __$VetDoctorCopyWithImpl<_VetDoctor>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VetDoctor'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('nameEn', nameEn))..add(DiagnosticsProperty('nameBn', nameBn))..add(DiagnosticsProperty('photoUrl', photoUrl))..add(DiagnosticsProperty('qualification', qualification))..add(DiagnosticsProperty('specialization', specialization))..add(DiagnosticsProperty('bvcRegistrationNo', bvcRegistrationNo))..add(DiagnosticsProperty('clinicOrHospitalNameEn', clinicOrHospitalNameEn))..add(DiagnosticsProperty('clinicOrHospitalNameBn', clinicOrHospitalNameBn))..add(DiagnosticsProperty('addressEn', addressEn))..add(DiagnosticsProperty('addressBn', addressBn))..add(DiagnosticsProperty('mobile', mobile))..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('isActive', isActive))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('regionIds', regionIds))..add(DiagnosticsProperty('areaIds', areaIds))..add(DiagnosticsProperty('baseIds', baseIds))..add(DiagnosticsProperty('upazilaIds', upazilaIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VetDoctor&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.qualification, qualification) || other.qualification == qualification)&&(identical(other.specialization, specialization) || other.specialization == specialization)&&(identical(other.bvcRegistrationNo, bvcRegistrationNo) || other.bvcRegistrationNo == bvcRegistrationNo)&&(identical(other.clinicOrHospitalNameEn, clinicOrHospitalNameEn) || other.clinicOrHospitalNameEn == clinicOrHospitalNameEn)&&(identical(other.clinicOrHospitalNameBn, clinicOrHospitalNameBn) || other.clinicOrHospitalNameBn == clinicOrHospitalNameBn)&&(identical(other.addressEn, addressEn) || other.addressEn == addressEn)&&(identical(other.addressBn, addressBn) || other.addressBn == addressBn)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.email, email) || other.email == email)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._regionIds, _regionIds)&&const DeepCollectionEquality().equals(other._areaIds, _areaIds)&&const DeepCollectionEquality().equals(other._baseIds, _baseIds)&&const DeepCollectionEquality().equals(other._upazilaIds, _upazilaIds));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,nameEn,nameBn,photoUrl,qualification,specialization,bvcRegistrationNo,clinicOrHospitalNameEn,clinicOrHospitalNameBn,addressEn,addressBn,mobile,email,isActive,createdAt,updatedAt,const DeepCollectionEquality().hash(_regionIds),const DeepCollectionEquality().hash(_areaIds),const DeepCollectionEquality().hash(_baseIds),const DeepCollectionEquality().hash(_upazilaIds)]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VetDoctor(id: $id, nameEn: $nameEn, nameBn: $nameBn, photoUrl: $photoUrl, qualification: $qualification, specialization: $specialization, bvcRegistrationNo: $bvcRegistrationNo, clinicOrHospitalNameEn: $clinicOrHospitalNameEn, clinicOrHospitalNameBn: $clinicOrHospitalNameBn, addressEn: $addressEn, addressBn: $addressBn, mobile: $mobile, email: $email, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, regionIds: $regionIds, areaIds: $areaIds, baseIds: $baseIds, upazilaIds: $upazilaIds)';
}


}

/// @nodoc
abstract mixin class _$VetDoctorCopyWith<$Res> implements $VetDoctorCopyWith<$Res> {
  factory _$VetDoctorCopyWith(_VetDoctor value, $Res Function(_VetDoctor) _then) = __$VetDoctorCopyWithImpl;
@override @useResult
$Res call({
 int id, String nameEn, String? nameBn, String? photoUrl, String? qualification, String? specialization, String? bvcRegistrationNo, String? clinicOrHospitalNameEn, String? clinicOrHospitalNameBn, String? addressEn, String? addressBn, String? mobile, String? email, bool isActive, DateTime createdAt, DateTime updatedAt, List<int> regionIds, List<int> areaIds, List<int> baseIds, List<int> upazilaIds
});




}
/// @nodoc
class __$VetDoctorCopyWithImpl<$Res>
    implements _$VetDoctorCopyWith<$Res> {
  __$VetDoctorCopyWithImpl(this._self, this._then);

  final _VetDoctor _self;
  final $Res Function(_VetDoctor) _then;

/// Create a copy of VetDoctor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,Object? photoUrl = freezed,Object? qualification = freezed,Object? specialization = freezed,Object? bvcRegistrationNo = freezed,Object? clinicOrHospitalNameEn = freezed,Object? clinicOrHospitalNameBn = freezed,Object? addressEn = freezed,Object? addressBn = freezed,Object? mobile = freezed,Object? email = freezed,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? regionIds = null,Object? areaIds = null,Object? baseIds = null,Object? upazilaIds = null,}) {
  return _then(_VetDoctor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,qualification: freezed == qualification ? _self.qualification : qualification // ignore: cast_nullable_to_non_nullable
as String?,specialization: freezed == specialization ? _self.specialization : specialization // ignore: cast_nullable_to_non_nullable
as String?,bvcRegistrationNo: freezed == bvcRegistrationNo ? _self.bvcRegistrationNo : bvcRegistrationNo // ignore: cast_nullable_to_non_nullable
as String?,clinicOrHospitalNameEn: freezed == clinicOrHospitalNameEn ? _self.clinicOrHospitalNameEn : clinicOrHospitalNameEn // ignore: cast_nullable_to_non_nullable
as String?,clinicOrHospitalNameBn: freezed == clinicOrHospitalNameBn ? _self.clinicOrHospitalNameBn : clinicOrHospitalNameBn // ignore: cast_nullable_to_non_nullable
as String?,addressEn: freezed == addressEn ? _self.addressEn : addressEn // ignore: cast_nullable_to_non_nullable
as String?,addressBn: freezed == addressBn ? _self.addressBn : addressBn // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,regionIds: null == regionIds ? _self._regionIds : regionIds // ignore: cast_nullable_to_non_nullable
as List<int>,areaIds: null == areaIds ? _self._areaIds : areaIds // ignore: cast_nullable_to_non_nullable
as List<int>,baseIds: null == baseIds ? _self._baseIds : baseIds // ignore: cast_nullable_to_non_nullable
as List<int>,upazilaIds: null == upazilaIds ? _self._upazilaIds : upazilaIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
mixin _$DistributorWithLocation implements DiagnosticableTreeMixin {

 Distributor get distributor; Area get area; Region get region;
/// Create a copy of DistributorWithLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DistributorWithLocationCopyWith<DistributorWithLocation> get copyWith => _$DistributorWithLocationCopyWithImpl<DistributorWithLocation>(this as DistributorWithLocation, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DistributorWithLocation'))
    ..add(DiagnosticsProperty('distributor', distributor))..add(DiagnosticsProperty('area', area))..add(DiagnosticsProperty('region', region));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DistributorWithLocation&&(identical(other.distributor, distributor) || other.distributor == distributor)&&(identical(other.area, area) || other.area == area)&&(identical(other.region, region) || other.region == region));
}


@override
int get hashCode => Object.hash(runtimeType,distributor,area,region);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DistributorWithLocation(distributor: $distributor, area: $area, region: $region)';
}


}

/// @nodoc
abstract mixin class $DistributorWithLocationCopyWith<$Res>  {
  factory $DistributorWithLocationCopyWith(DistributorWithLocation value, $Res Function(DistributorWithLocation) _then) = _$DistributorWithLocationCopyWithImpl;
@useResult
$Res call({
 Distributor distributor, Area area, Region region
});


$DistributorCopyWith<$Res> get distributor;$AreaCopyWith<$Res> get area;$RegionCopyWith<$Res> get region;

}
/// @nodoc
class _$DistributorWithLocationCopyWithImpl<$Res>
    implements $DistributorWithLocationCopyWith<$Res> {
  _$DistributorWithLocationCopyWithImpl(this._self, this._then);

  final DistributorWithLocation _self;
  final $Res Function(DistributorWithLocation) _then;

/// Create a copy of DistributorWithLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? distributor = null,Object? area = null,Object? region = null,}) {
  return _then(_self.copyWith(
distributor: null == distributor ? _self.distributor : distributor // ignore: cast_nullable_to_non_nullable
as Distributor,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as Area,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,
  ));
}
/// Create a copy of DistributorWithLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DistributorCopyWith<$Res> get distributor {
  
  return $DistributorCopyWith<$Res>(_self.distributor, (value) {
    return _then(_self.copyWith(distributor: value));
  });
}/// Create a copy of DistributorWithLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AreaCopyWith<$Res> get area {
  
  return $AreaCopyWith<$Res>(_self.area, (value) {
    return _then(_self.copyWith(area: value));
  });
}/// Create a copy of DistributorWithLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegionCopyWith<$Res> get region {
  
  return $RegionCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}
}


/// Adds pattern-matching-related methods to [DistributorWithLocation].
extension DistributorWithLocationPatterns on DistributorWithLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DistributorWithLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DistributorWithLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DistributorWithLocation value)  $default,){
final _that = this;
switch (_that) {
case _DistributorWithLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DistributorWithLocation value)?  $default,){
final _that = this;
switch (_that) {
case _DistributorWithLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Distributor distributor,  Area area,  Region region)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DistributorWithLocation() when $default != null:
return $default(_that.distributor,_that.area,_that.region);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Distributor distributor,  Area area,  Region region)  $default,) {final _that = this;
switch (_that) {
case _DistributorWithLocation():
return $default(_that.distributor,_that.area,_that.region);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Distributor distributor,  Area area,  Region region)?  $default,) {final _that = this;
switch (_that) {
case _DistributorWithLocation() when $default != null:
return $default(_that.distributor,_that.area,_that.region);case _:
  return null;

}
}

}

/// @nodoc


class _DistributorWithLocation extends DistributorWithLocation with DiagnosticableTreeMixin {
  const _DistributorWithLocation({required this.distributor, required this.area, required this.region}): super._();
  

@override final  Distributor distributor;
@override final  Area area;
@override final  Region region;

/// Create a copy of DistributorWithLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DistributorWithLocationCopyWith<_DistributorWithLocation> get copyWith => __$DistributorWithLocationCopyWithImpl<_DistributorWithLocation>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DistributorWithLocation'))
    ..add(DiagnosticsProperty('distributor', distributor))..add(DiagnosticsProperty('area', area))..add(DiagnosticsProperty('region', region));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DistributorWithLocation&&(identical(other.distributor, distributor) || other.distributor == distributor)&&(identical(other.area, area) || other.area == area)&&(identical(other.region, region) || other.region == region));
}


@override
int get hashCode => Object.hash(runtimeType,distributor,area,region);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DistributorWithLocation(distributor: $distributor, area: $area, region: $region)';
}


}

/// @nodoc
abstract mixin class _$DistributorWithLocationCopyWith<$Res> implements $DistributorWithLocationCopyWith<$Res> {
  factory _$DistributorWithLocationCopyWith(_DistributorWithLocation value, $Res Function(_DistributorWithLocation) _then) = __$DistributorWithLocationCopyWithImpl;
@override @useResult
$Res call({
 Distributor distributor, Area area, Region region
});


@override $DistributorCopyWith<$Res> get distributor;@override $AreaCopyWith<$Res> get area;@override $RegionCopyWith<$Res> get region;

}
/// @nodoc
class __$DistributorWithLocationCopyWithImpl<$Res>
    implements _$DistributorWithLocationCopyWith<$Res> {
  __$DistributorWithLocationCopyWithImpl(this._self, this._then);

  final _DistributorWithLocation _self;
  final $Res Function(_DistributorWithLocation) _then;

/// Create a copy of DistributorWithLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? distributor = null,Object? area = null,Object? region = null,}) {
  return _then(_DistributorWithLocation(
distributor: null == distributor ? _self.distributor : distributor // ignore: cast_nullable_to_non_nullable
as Distributor,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as Area,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,
  ));
}

/// Create a copy of DistributorWithLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DistributorCopyWith<$Res> get distributor {
  
  return $DistributorCopyWith<$Res>(_self.distributor, (value) {
    return _then(_self.copyWith(distributor: value));
  });
}/// Create a copy of DistributorWithLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AreaCopyWith<$Res> get area {
  
  return $AreaCopyWith<$Res>(_self.area, (value) {
    return _then(_self.copyWith(area: value));
  });
}/// Create a copy of DistributorWithLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegionCopyWith<$Res> get region {
  
  return $RegionCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}
}

/// @nodoc
mixin _$SalesPersonnelWithAreas implements DiagnosticableTreeMixin {

 SalesPersonnel get personnel; List<Area> get areas; List<Region> get regions; List<Base> get bases; List<Upazila> get upazilas;
/// Create a copy of SalesPersonnelWithAreas
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesPersonnelWithAreasCopyWith<SalesPersonnelWithAreas> get copyWith => _$SalesPersonnelWithAreasCopyWithImpl<SalesPersonnelWithAreas>(this as SalesPersonnelWithAreas, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SalesPersonnelWithAreas'))
    ..add(DiagnosticsProperty('personnel', personnel))..add(DiagnosticsProperty('areas', areas))..add(DiagnosticsProperty('regions', regions))..add(DiagnosticsProperty('bases', bases))..add(DiagnosticsProperty('upazilas', upazilas));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesPersonnelWithAreas&&(identical(other.personnel, personnel) || other.personnel == personnel)&&const DeepCollectionEquality().equals(other.areas, areas)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.bases, bases)&&const DeepCollectionEquality().equals(other.upazilas, upazilas));
}


@override
int get hashCode => Object.hash(runtimeType,personnel,const DeepCollectionEquality().hash(areas),const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(bases),const DeepCollectionEquality().hash(upazilas));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SalesPersonnelWithAreas(personnel: $personnel, areas: $areas, regions: $regions, bases: $bases, upazilas: $upazilas)';
}


}

/// @nodoc
abstract mixin class $SalesPersonnelWithAreasCopyWith<$Res>  {
  factory $SalesPersonnelWithAreasCopyWith(SalesPersonnelWithAreas value, $Res Function(SalesPersonnelWithAreas) _then) = _$SalesPersonnelWithAreasCopyWithImpl;
@useResult
$Res call({
 SalesPersonnel personnel, List<Area> areas, List<Region> regions, List<Base> bases, List<Upazila> upazilas
});


$SalesPersonnelCopyWith<$Res> get personnel;

}
/// @nodoc
class _$SalesPersonnelWithAreasCopyWithImpl<$Res>
    implements $SalesPersonnelWithAreasCopyWith<$Res> {
  _$SalesPersonnelWithAreasCopyWithImpl(this._self, this._then);

  final SalesPersonnelWithAreas _self;
  final $Res Function(SalesPersonnelWithAreas) _then;

/// Create a copy of SalesPersonnelWithAreas
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? personnel = null,Object? areas = null,Object? regions = null,Object? bases = null,Object? upazilas = null,}) {
  return _then(_self.copyWith(
personnel: null == personnel ? _self.personnel : personnel // ignore: cast_nullable_to_non_nullable
as SalesPersonnel,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as List<Area>,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>,bases: null == bases ? _self.bases : bases // ignore: cast_nullable_to_non_nullable
as List<Base>,upazilas: null == upazilas ? _self.upazilas : upazilas // ignore: cast_nullable_to_non_nullable
as List<Upazila>,
  ));
}
/// Create a copy of SalesPersonnelWithAreas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalesPersonnelCopyWith<$Res> get personnel {
  
  return $SalesPersonnelCopyWith<$Res>(_self.personnel, (value) {
    return _then(_self.copyWith(personnel: value));
  });
}
}


/// Adds pattern-matching-related methods to [SalesPersonnelWithAreas].
extension SalesPersonnelWithAreasPatterns on SalesPersonnelWithAreas {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesPersonnelWithAreas value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesPersonnelWithAreas() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesPersonnelWithAreas value)  $default,){
final _that = this;
switch (_that) {
case _SalesPersonnelWithAreas():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesPersonnelWithAreas value)?  $default,){
final _that = this;
switch (_that) {
case _SalesPersonnelWithAreas() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SalesPersonnel personnel,  List<Area> areas,  List<Region> regions,  List<Base> bases,  List<Upazila> upazilas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesPersonnelWithAreas() when $default != null:
return $default(_that.personnel,_that.areas,_that.regions,_that.bases,_that.upazilas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SalesPersonnel personnel,  List<Area> areas,  List<Region> regions,  List<Base> bases,  List<Upazila> upazilas)  $default,) {final _that = this;
switch (_that) {
case _SalesPersonnelWithAreas():
return $default(_that.personnel,_that.areas,_that.regions,_that.bases,_that.upazilas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SalesPersonnel personnel,  List<Area> areas,  List<Region> regions,  List<Base> bases,  List<Upazila> upazilas)?  $default,) {final _that = this;
switch (_that) {
case _SalesPersonnelWithAreas() when $default != null:
return $default(_that.personnel,_that.areas,_that.regions,_that.bases,_that.upazilas);case _:
  return null;

}
}

}

/// @nodoc


class _SalesPersonnelWithAreas with DiagnosticableTreeMixin implements SalesPersonnelWithAreas {
  const _SalesPersonnelWithAreas({required this.personnel, required final  List<Area> areas, final  List<Region> regions = const [], final  List<Base> bases = const [], final  List<Upazila> upazilas = const []}): _areas = areas,_regions = regions,_bases = bases,_upazilas = upazilas;
  

@override final  SalesPersonnel personnel;
 final  List<Area> _areas;
@override List<Area> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}

 final  List<Region> _regions;
@override@JsonKey() List<Region> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  List<Base> _bases;
@override@JsonKey() List<Base> get bases {
  if (_bases is EqualUnmodifiableListView) return _bases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bases);
}

 final  List<Upazila> _upazilas;
@override@JsonKey() List<Upazila> get upazilas {
  if (_upazilas is EqualUnmodifiableListView) return _upazilas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upazilas);
}


/// Create a copy of SalesPersonnelWithAreas
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesPersonnelWithAreasCopyWith<_SalesPersonnelWithAreas> get copyWith => __$SalesPersonnelWithAreasCopyWithImpl<_SalesPersonnelWithAreas>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SalesPersonnelWithAreas'))
    ..add(DiagnosticsProperty('personnel', personnel))..add(DiagnosticsProperty('areas', areas))..add(DiagnosticsProperty('regions', regions))..add(DiagnosticsProperty('bases', bases))..add(DiagnosticsProperty('upazilas', upazilas));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesPersonnelWithAreas&&(identical(other.personnel, personnel) || other.personnel == personnel)&&const DeepCollectionEquality().equals(other._areas, _areas)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._bases, _bases)&&const DeepCollectionEquality().equals(other._upazilas, _upazilas));
}


@override
int get hashCode => Object.hash(runtimeType,personnel,const DeepCollectionEquality().hash(_areas),const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_bases),const DeepCollectionEquality().hash(_upazilas));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SalesPersonnelWithAreas(personnel: $personnel, areas: $areas, regions: $regions, bases: $bases, upazilas: $upazilas)';
}


}

/// @nodoc
abstract mixin class _$SalesPersonnelWithAreasCopyWith<$Res> implements $SalesPersonnelWithAreasCopyWith<$Res> {
  factory _$SalesPersonnelWithAreasCopyWith(_SalesPersonnelWithAreas value, $Res Function(_SalesPersonnelWithAreas) _then) = __$SalesPersonnelWithAreasCopyWithImpl;
@override @useResult
$Res call({
 SalesPersonnel personnel, List<Area> areas, List<Region> regions, List<Base> bases, List<Upazila> upazilas
});


@override $SalesPersonnelCopyWith<$Res> get personnel;

}
/// @nodoc
class __$SalesPersonnelWithAreasCopyWithImpl<$Res>
    implements _$SalesPersonnelWithAreasCopyWith<$Res> {
  __$SalesPersonnelWithAreasCopyWithImpl(this._self, this._then);

  final _SalesPersonnelWithAreas _self;
  final $Res Function(_SalesPersonnelWithAreas) _then;

/// Create a copy of SalesPersonnelWithAreas
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? personnel = null,Object? areas = null,Object? regions = null,Object? bases = null,Object? upazilas = null,}) {
  return _then(_SalesPersonnelWithAreas(
personnel: null == personnel ? _self.personnel : personnel // ignore: cast_nullable_to_non_nullable
as SalesPersonnel,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<Area>,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>,bases: null == bases ? _self._bases : bases // ignore: cast_nullable_to_non_nullable
as List<Base>,upazilas: null == upazilas ? _self._upazilas : upazilas // ignore: cast_nullable_to_non_nullable
as List<Upazila>,
  ));
}

/// Create a copy of SalesPersonnelWithAreas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalesPersonnelCopyWith<$Res> get personnel {
  
  return $SalesPersonnelCopyWith<$Res>(_self.personnel, (value) {
    return _then(_self.copyWith(personnel: value));
  });
}
}

/// @nodoc
mixin _$VetDoctorWithAreas implements DiagnosticableTreeMixin {

 VetDoctor get doctor; List<Area> get areas; List<Region> get regions; List<Base> get bases; List<Upazila> get upazilas;
/// Create a copy of VetDoctorWithAreas
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VetDoctorWithAreasCopyWith<VetDoctorWithAreas> get copyWith => _$VetDoctorWithAreasCopyWithImpl<VetDoctorWithAreas>(this as VetDoctorWithAreas, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VetDoctorWithAreas'))
    ..add(DiagnosticsProperty('doctor', doctor))..add(DiagnosticsProperty('areas', areas))..add(DiagnosticsProperty('regions', regions))..add(DiagnosticsProperty('bases', bases))..add(DiagnosticsProperty('upazilas', upazilas));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VetDoctorWithAreas&&(identical(other.doctor, doctor) || other.doctor == doctor)&&const DeepCollectionEquality().equals(other.areas, areas)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.bases, bases)&&const DeepCollectionEquality().equals(other.upazilas, upazilas));
}


@override
int get hashCode => Object.hash(runtimeType,doctor,const DeepCollectionEquality().hash(areas),const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(bases),const DeepCollectionEquality().hash(upazilas));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VetDoctorWithAreas(doctor: $doctor, areas: $areas, regions: $regions, bases: $bases, upazilas: $upazilas)';
}


}

/// @nodoc
abstract mixin class $VetDoctorWithAreasCopyWith<$Res>  {
  factory $VetDoctorWithAreasCopyWith(VetDoctorWithAreas value, $Res Function(VetDoctorWithAreas) _then) = _$VetDoctorWithAreasCopyWithImpl;
@useResult
$Res call({
 VetDoctor doctor, List<Area> areas, List<Region> regions, List<Base> bases, List<Upazila> upazilas
});


$VetDoctorCopyWith<$Res> get doctor;

}
/// @nodoc
class _$VetDoctorWithAreasCopyWithImpl<$Res>
    implements $VetDoctorWithAreasCopyWith<$Res> {
  _$VetDoctorWithAreasCopyWithImpl(this._self, this._then);

  final VetDoctorWithAreas _self;
  final $Res Function(VetDoctorWithAreas) _then;

/// Create a copy of VetDoctorWithAreas
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? doctor = null,Object? areas = null,Object? regions = null,Object? bases = null,Object? upazilas = null,}) {
  return _then(_self.copyWith(
doctor: null == doctor ? _self.doctor : doctor // ignore: cast_nullable_to_non_nullable
as VetDoctor,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as List<Area>,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>,bases: null == bases ? _self.bases : bases // ignore: cast_nullable_to_non_nullable
as List<Base>,upazilas: null == upazilas ? _self.upazilas : upazilas // ignore: cast_nullable_to_non_nullable
as List<Upazila>,
  ));
}
/// Create a copy of VetDoctorWithAreas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VetDoctorCopyWith<$Res> get doctor {
  
  return $VetDoctorCopyWith<$Res>(_self.doctor, (value) {
    return _then(_self.copyWith(doctor: value));
  });
}
}


/// Adds pattern-matching-related methods to [VetDoctorWithAreas].
extension VetDoctorWithAreasPatterns on VetDoctorWithAreas {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VetDoctorWithAreas value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VetDoctorWithAreas() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VetDoctorWithAreas value)  $default,){
final _that = this;
switch (_that) {
case _VetDoctorWithAreas():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VetDoctorWithAreas value)?  $default,){
final _that = this;
switch (_that) {
case _VetDoctorWithAreas() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VetDoctor doctor,  List<Area> areas,  List<Region> regions,  List<Base> bases,  List<Upazila> upazilas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VetDoctorWithAreas() when $default != null:
return $default(_that.doctor,_that.areas,_that.regions,_that.bases,_that.upazilas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VetDoctor doctor,  List<Area> areas,  List<Region> regions,  List<Base> bases,  List<Upazila> upazilas)  $default,) {final _that = this;
switch (_that) {
case _VetDoctorWithAreas():
return $default(_that.doctor,_that.areas,_that.regions,_that.bases,_that.upazilas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VetDoctor doctor,  List<Area> areas,  List<Region> regions,  List<Base> bases,  List<Upazila> upazilas)?  $default,) {final _that = this;
switch (_that) {
case _VetDoctorWithAreas() when $default != null:
return $default(_that.doctor,_that.areas,_that.regions,_that.bases,_that.upazilas);case _:
  return null;

}
}

}

/// @nodoc


class _VetDoctorWithAreas with DiagnosticableTreeMixin implements VetDoctorWithAreas {
  const _VetDoctorWithAreas({required this.doctor, required final  List<Area> areas, final  List<Region> regions = const [], final  List<Base> bases = const [], final  List<Upazila> upazilas = const []}): _areas = areas,_regions = regions,_bases = bases,_upazilas = upazilas;
  

@override final  VetDoctor doctor;
 final  List<Area> _areas;
@override List<Area> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}

 final  List<Region> _regions;
@override@JsonKey() List<Region> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  List<Base> _bases;
@override@JsonKey() List<Base> get bases {
  if (_bases is EqualUnmodifiableListView) return _bases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bases);
}

 final  List<Upazila> _upazilas;
@override@JsonKey() List<Upazila> get upazilas {
  if (_upazilas is EqualUnmodifiableListView) return _upazilas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upazilas);
}


/// Create a copy of VetDoctorWithAreas
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VetDoctorWithAreasCopyWith<_VetDoctorWithAreas> get copyWith => __$VetDoctorWithAreasCopyWithImpl<_VetDoctorWithAreas>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VetDoctorWithAreas'))
    ..add(DiagnosticsProperty('doctor', doctor))..add(DiagnosticsProperty('areas', areas))..add(DiagnosticsProperty('regions', regions))..add(DiagnosticsProperty('bases', bases))..add(DiagnosticsProperty('upazilas', upazilas));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VetDoctorWithAreas&&(identical(other.doctor, doctor) || other.doctor == doctor)&&const DeepCollectionEquality().equals(other._areas, _areas)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._bases, _bases)&&const DeepCollectionEquality().equals(other._upazilas, _upazilas));
}


@override
int get hashCode => Object.hash(runtimeType,doctor,const DeepCollectionEquality().hash(_areas),const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_bases),const DeepCollectionEquality().hash(_upazilas));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VetDoctorWithAreas(doctor: $doctor, areas: $areas, regions: $regions, bases: $bases, upazilas: $upazilas)';
}


}

/// @nodoc
abstract mixin class _$VetDoctorWithAreasCopyWith<$Res> implements $VetDoctorWithAreasCopyWith<$Res> {
  factory _$VetDoctorWithAreasCopyWith(_VetDoctorWithAreas value, $Res Function(_VetDoctorWithAreas) _then) = __$VetDoctorWithAreasCopyWithImpl;
@override @useResult
$Res call({
 VetDoctor doctor, List<Area> areas, List<Region> regions, List<Base> bases, List<Upazila> upazilas
});


@override $VetDoctorCopyWith<$Res> get doctor;

}
/// @nodoc
class __$VetDoctorWithAreasCopyWithImpl<$Res>
    implements _$VetDoctorWithAreasCopyWith<$Res> {
  __$VetDoctorWithAreasCopyWithImpl(this._self, this._then);

  final _VetDoctorWithAreas _self;
  final $Res Function(_VetDoctorWithAreas) _then;

/// Create a copy of VetDoctorWithAreas
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? doctor = null,Object? areas = null,Object? regions = null,Object? bases = null,Object? upazilas = null,}) {
  return _then(_VetDoctorWithAreas(
doctor: null == doctor ? _self.doctor : doctor // ignore: cast_nullable_to_non_nullable
as VetDoctor,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<Area>,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>,bases: null == bases ? _self._bases : bases // ignore: cast_nullable_to_non_nullable
as List<Base>,upazilas: null == upazilas ? _self._upazilas : upazilas // ignore: cast_nullable_to_non_nullable
as List<Upazila>,
  ));
}

/// Create a copy of VetDoctorWithAreas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VetDoctorCopyWith<$Res> get doctor {
  
  return $VetDoctorCopyWith<$Res>(_self.doctor, (value) {
    return _then(_self.copyWith(doctor: value));
  });
}
}

/// @nodoc
mixin _$BaseWithUpazilas implements DiagnosticableTreeMixin {

 Base get base; Area get area; Region get region; List<Upazila> get upazilas;
/// Create a copy of BaseWithUpazilas
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseWithUpazilasCopyWith<BaseWithUpazilas> get copyWith => _$BaseWithUpazilasCopyWithImpl<BaseWithUpazilas>(this as BaseWithUpazilas, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BaseWithUpazilas'))
    ..add(DiagnosticsProperty('base', base))..add(DiagnosticsProperty('area', area))..add(DiagnosticsProperty('region', region))..add(DiagnosticsProperty('upazilas', upazilas));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseWithUpazilas&&(identical(other.base, base) || other.base == base)&&(identical(other.area, area) || other.area == area)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other.upazilas, upazilas));
}


@override
int get hashCode => Object.hash(runtimeType,base,area,region,const DeepCollectionEquality().hash(upazilas));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BaseWithUpazilas(base: $base, area: $area, region: $region, upazilas: $upazilas)';
}


}

/// @nodoc
abstract mixin class $BaseWithUpazilasCopyWith<$Res>  {
  factory $BaseWithUpazilasCopyWith(BaseWithUpazilas value, $Res Function(BaseWithUpazilas) _then) = _$BaseWithUpazilasCopyWithImpl;
@useResult
$Res call({
 Base base, Area area, Region region, List<Upazila> upazilas
});


$BaseCopyWith<$Res> get base;$AreaCopyWith<$Res> get area;$RegionCopyWith<$Res> get region;

}
/// @nodoc
class _$BaseWithUpazilasCopyWithImpl<$Res>
    implements $BaseWithUpazilasCopyWith<$Res> {
  _$BaseWithUpazilasCopyWithImpl(this._self, this._then);

  final BaseWithUpazilas _self;
  final $Res Function(BaseWithUpazilas) _then;

/// Create a copy of BaseWithUpazilas
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? base = null,Object? area = null,Object? region = null,Object? upazilas = null,}) {
  return _then(_self.copyWith(
base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as Base,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as Area,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,upazilas: null == upazilas ? _self.upazilas : upazilas // ignore: cast_nullable_to_non_nullable
as List<Upazila>,
  ));
}
/// Create a copy of BaseWithUpazilas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BaseCopyWith<$Res> get base {
  
  return $BaseCopyWith<$Res>(_self.base, (value) {
    return _then(_self.copyWith(base: value));
  });
}/// Create a copy of BaseWithUpazilas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AreaCopyWith<$Res> get area {
  
  return $AreaCopyWith<$Res>(_self.area, (value) {
    return _then(_self.copyWith(area: value));
  });
}/// Create a copy of BaseWithUpazilas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegionCopyWith<$Res> get region {
  
  return $RegionCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}
}


/// Adds pattern-matching-related methods to [BaseWithUpazilas].
extension BaseWithUpazilasPatterns on BaseWithUpazilas {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BaseWithUpazilas value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BaseWithUpazilas() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BaseWithUpazilas value)  $default,){
final _that = this;
switch (_that) {
case _BaseWithUpazilas():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BaseWithUpazilas value)?  $default,){
final _that = this;
switch (_that) {
case _BaseWithUpazilas() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Base base,  Area area,  Region region,  List<Upazila> upazilas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BaseWithUpazilas() when $default != null:
return $default(_that.base,_that.area,_that.region,_that.upazilas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Base base,  Area area,  Region region,  List<Upazila> upazilas)  $default,) {final _that = this;
switch (_that) {
case _BaseWithUpazilas():
return $default(_that.base,_that.area,_that.region,_that.upazilas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Base base,  Area area,  Region region,  List<Upazila> upazilas)?  $default,) {final _that = this;
switch (_that) {
case _BaseWithUpazilas() when $default != null:
return $default(_that.base,_that.area,_that.region,_that.upazilas);case _:
  return null;

}
}

}

/// @nodoc


class _BaseWithUpazilas with DiagnosticableTreeMixin implements BaseWithUpazilas {
  const _BaseWithUpazilas({required this.base, required this.area, required this.region, required final  List<Upazila> upazilas}): _upazilas = upazilas;
  

@override final  Base base;
@override final  Area area;
@override final  Region region;
 final  List<Upazila> _upazilas;
@override List<Upazila> get upazilas {
  if (_upazilas is EqualUnmodifiableListView) return _upazilas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upazilas);
}


/// Create a copy of BaseWithUpazilas
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BaseWithUpazilasCopyWith<_BaseWithUpazilas> get copyWith => __$BaseWithUpazilasCopyWithImpl<_BaseWithUpazilas>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BaseWithUpazilas'))
    ..add(DiagnosticsProperty('base', base))..add(DiagnosticsProperty('area', area))..add(DiagnosticsProperty('region', region))..add(DiagnosticsProperty('upazilas', upazilas));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BaseWithUpazilas&&(identical(other.base, base) || other.base == base)&&(identical(other.area, area) || other.area == area)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other._upazilas, _upazilas));
}


@override
int get hashCode => Object.hash(runtimeType,base,area,region,const DeepCollectionEquality().hash(_upazilas));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BaseWithUpazilas(base: $base, area: $area, region: $region, upazilas: $upazilas)';
}


}

/// @nodoc
abstract mixin class _$BaseWithUpazilasCopyWith<$Res> implements $BaseWithUpazilasCopyWith<$Res> {
  factory _$BaseWithUpazilasCopyWith(_BaseWithUpazilas value, $Res Function(_BaseWithUpazilas) _then) = __$BaseWithUpazilasCopyWithImpl;
@override @useResult
$Res call({
 Base base, Area area, Region region, List<Upazila> upazilas
});


@override $BaseCopyWith<$Res> get base;@override $AreaCopyWith<$Res> get area;@override $RegionCopyWith<$Res> get region;

}
/// @nodoc
class __$BaseWithUpazilasCopyWithImpl<$Res>
    implements _$BaseWithUpazilasCopyWith<$Res> {
  __$BaseWithUpazilasCopyWithImpl(this._self, this._then);

  final _BaseWithUpazilas _self;
  final $Res Function(_BaseWithUpazilas) _then;

/// Create a copy of BaseWithUpazilas
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? base = null,Object? area = null,Object? region = null,Object? upazilas = null,}) {
  return _then(_BaseWithUpazilas(
base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as Base,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as Area,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,upazilas: null == upazilas ? _self._upazilas : upazilas // ignore: cast_nullable_to_non_nullable
as List<Upazila>,
  ));
}

/// Create a copy of BaseWithUpazilas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BaseCopyWith<$Res> get base {
  
  return $BaseCopyWith<$Res>(_self.base, (value) {
    return _then(_self.copyWith(base: value));
  });
}/// Create a copy of BaseWithUpazilas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AreaCopyWith<$Res> get area {
  
  return $AreaCopyWith<$Res>(_self.area, (value) {
    return _then(_self.copyWith(area: value));
  });
}/// Create a copy of BaseWithUpazilas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegionCopyWith<$Res> get region {
  
  return $RegionCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}
}

// dart format on
