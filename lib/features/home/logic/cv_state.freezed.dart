// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cv_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CvState {

 List<CvResponseModel> get cvs;
/// Create a copy of CvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CvStateCopyWith<CvState> get copyWith => _$CvStateCopyWithImpl<CvState>(this as CvState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CvState&&const DeepCollectionEquality().equals(other.cvs, cvs));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cvs));

@override
String toString() {
  return 'CvState(cvs: $cvs)';
}


}

/// @nodoc
abstract mixin class $CvStateCopyWith<$Res>  {
  factory $CvStateCopyWith(CvState value, $Res Function(CvState) _then) = _$CvStateCopyWithImpl;
@useResult
$Res call({
 List<CvResponseModel> cvs
});




}
/// @nodoc
class _$CvStateCopyWithImpl<$Res>
    implements $CvStateCopyWith<$Res> {
  _$CvStateCopyWithImpl(this._self, this._then);

  final CvState _self;
  final $Res Function(CvState) _then;

/// Create a copy of CvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cvs = null,}) {
  return _then(_self.copyWith(
cvs: null == cvs ? _self.cvs : cvs // ignore: cast_nullable_to_non_nullable
as List<CvResponseModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CvState].
extension CvStatePatterns on CvState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CvInitial value)?  initial,TResult Function( CvLoading value)?  loading,TResult Function( CvLoaded value)?  loaded,TResult Function( CvError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CvInitial() when initial != null:
return initial(_that);case CvLoading() when loading != null:
return loading(_that);case CvLoaded() when loaded != null:
return loaded(_that);case CvError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CvInitial value)  initial,required TResult Function( CvLoading value)  loading,required TResult Function( CvLoaded value)  loaded,required TResult Function( CvError value)  error,}){
final _that = this;
switch (_that) {
case CvInitial():
return initial(_that);case CvLoading():
return loading(_that);case CvLoaded():
return loaded(_that);case CvError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CvInitial value)?  initial,TResult? Function( CvLoading value)?  loading,TResult? Function( CvLoaded value)?  loaded,TResult? Function( CvError value)?  error,}){
final _that = this;
switch (_that) {
case CvInitial() when initial != null:
return initial(_that);case CvLoading() when loading != null:
return loading(_that);case CvLoaded() when loaded != null:
return loaded(_that);case CvError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<CvResponseModel> cvs)?  initial,TResult Function( List<CvResponseModel> cvs,  CvActionType actionType)?  loading,TResult Function( List<CvResponseModel> cvs,  CvActionType actionType,  CvResponseModel? cv)?  loaded,TResult Function( String message,  List<CvResponseModel> cvs,  CvActionType actionType,  String? fileName,  int? sizeInBytes)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CvInitial() when initial != null:
return initial(_that.cvs);case CvLoading() when loading != null:
return loading(_that.cvs,_that.actionType);case CvLoaded() when loaded != null:
return loaded(_that.cvs,_that.actionType,_that.cv);case CvError() when error != null:
return error(_that.message,_that.cvs,_that.actionType,_that.fileName,_that.sizeInBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<CvResponseModel> cvs)  initial,required TResult Function( List<CvResponseModel> cvs,  CvActionType actionType)  loading,required TResult Function( List<CvResponseModel> cvs,  CvActionType actionType,  CvResponseModel? cv)  loaded,required TResult Function( String message,  List<CvResponseModel> cvs,  CvActionType actionType,  String? fileName,  int? sizeInBytes)  error,}) {final _that = this;
switch (_that) {
case CvInitial():
return initial(_that.cvs);case CvLoading():
return loading(_that.cvs,_that.actionType);case CvLoaded():
return loaded(_that.cvs,_that.actionType,_that.cv);case CvError():
return error(_that.message,_that.cvs,_that.actionType,_that.fileName,_that.sizeInBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<CvResponseModel> cvs)?  initial,TResult? Function( List<CvResponseModel> cvs,  CvActionType actionType)?  loading,TResult? Function( List<CvResponseModel> cvs,  CvActionType actionType,  CvResponseModel? cv)?  loaded,TResult? Function( String message,  List<CvResponseModel> cvs,  CvActionType actionType,  String? fileName,  int? sizeInBytes)?  error,}) {final _that = this;
switch (_that) {
case CvInitial() when initial != null:
return initial(_that.cvs);case CvLoading() when loading != null:
return loading(_that.cvs,_that.actionType);case CvLoaded() when loaded != null:
return loaded(_that.cvs,_that.actionType,_that.cv);case CvError() when error != null:
return error(_that.message,_that.cvs,_that.actionType,_that.fileName,_that.sizeInBytes);case _:
  return null;

}
}

}

/// @nodoc


class CvInitial implements CvState {
  const CvInitial({final  List<CvResponseModel> cvs = const []}): _cvs = cvs;
  

 final  List<CvResponseModel> _cvs;
@override@JsonKey() List<CvResponseModel> get cvs {
  if (_cvs is EqualUnmodifiableListView) return _cvs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cvs);
}


/// Create a copy of CvState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CvInitialCopyWith<CvInitial> get copyWith => _$CvInitialCopyWithImpl<CvInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CvInitial&&const DeepCollectionEquality().equals(other._cvs, _cvs));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cvs));

@override
String toString() {
  return 'CvState.initial(cvs: $cvs)';
}


}

/// @nodoc
abstract mixin class $CvInitialCopyWith<$Res> implements $CvStateCopyWith<$Res> {
  factory $CvInitialCopyWith(CvInitial value, $Res Function(CvInitial) _then) = _$CvInitialCopyWithImpl;
@override @useResult
$Res call({
 List<CvResponseModel> cvs
});




}
/// @nodoc
class _$CvInitialCopyWithImpl<$Res>
    implements $CvInitialCopyWith<$Res> {
  _$CvInitialCopyWithImpl(this._self, this._then);

  final CvInitial _self;
  final $Res Function(CvInitial) _then;

/// Create a copy of CvState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cvs = null,}) {
  return _then(CvInitial(
cvs: null == cvs ? _self._cvs : cvs // ignore: cast_nullable_to_non_nullable
as List<CvResponseModel>,
  ));
}


}

/// @nodoc


class CvLoading implements CvState {
  const CvLoading({final  List<CvResponseModel> cvs = const [], required this.actionType}): _cvs = cvs;
  

 final  List<CvResponseModel> _cvs;
@override@JsonKey() List<CvResponseModel> get cvs {
  if (_cvs is EqualUnmodifiableListView) return _cvs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cvs);
}

 final  CvActionType actionType;

/// Create a copy of CvState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CvLoadingCopyWith<CvLoading> get copyWith => _$CvLoadingCopyWithImpl<CvLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CvLoading&&const DeepCollectionEquality().equals(other._cvs, _cvs)&&(identical(other.actionType, actionType) || other.actionType == actionType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cvs),actionType);

@override
String toString() {
  return 'CvState.loading(cvs: $cvs, actionType: $actionType)';
}


}

/// @nodoc
abstract mixin class $CvLoadingCopyWith<$Res> implements $CvStateCopyWith<$Res> {
  factory $CvLoadingCopyWith(CvLoading value, $Res Function(CvLoading) _then) = _$CvLoadingCopyWithImpl;
@override @useResult
$Res call({
 List<CvResponseModel> cvs, CvActionType actionType
});




}
/// @nodoc
class _$CvLoadingCopyWithImpl<$Res>
    implements $CvLoadingCopyWith<$Res> {
  _$CvLoadingCopyWithImpl(this._self, this._then);

  final CvLoading _self;
  final $Res Function(CvLoading) _then;

/// Create a copy of CvState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cvs = null,Object? actionType = null,}) {
  return _then(CvLoading(
cvs: null == cvs ? _self._cvs : cvs // ignore: cast_nullable_to_non_nullable
as List<CvResponseModel>,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as CvActionType,
  ));
}


}

/// @nodoc


class CvLoaded implements CvState {
  const CvLoaded({final  List<CvResponseModel> cvs = const [], required this.actionType, this.cv}): _cvs = cvs;
  

 final  List<CvResponseModel> _cvs;
@override@JsonKey() List<CvResponseModel> get cvs {
  if (_cvs is EqualUnmodifiableListView) return _cvs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cvs);
}

 final  CvActionType actionType;
 final  CvResponseModel? cv;

/// Create a copy of CvState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CvLoadedCopyWith<CvLoaded> get copyWith => _$CvLoadedCopyWithImpl<CvLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CvLoaded&&const DeepCollectionEquality().equals(other._cvs, _cvs)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.cv, cv) || other.cv == cv));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cvs),actionType,cv);

@override
String toString() {
  return 'CvState.loaded(cvs: $cvs, actionType: $actionType, cv: $cv)';
}


}

/// @nodoc
abstract mixin class $CvLoadedCopyWith<$Res> implements $CvStateCopyWith<$Res> {
  factory $CvLoadedCopyWith(CvLoaded value, $Res Function(CvLoaded) _then) = _$CvLoadedCopyWithImpl;
@override @useResult
$Res call({
 List<CvResponseModel> cvs, CvActionType actionType, CvResponseModel? cv
});




}
/// @nodoc
class _$CvLoadedCopyWithImpl<$Res>
    implements $CvLoadedCopyWith<$Res> {
  _$CvLoadedCopyWithImpl(this._self, this._then);

  final CvLoaded _self;
  final $Res Function(CvLoaded) _then;

/// Create a copy of CvState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cvs = null,Object? actionType = null,Object? cv = freezed,}) {
  return _then(CvLoaded(
cvs: null == cvs ? _self._cvs : cvs // ignore: cast_nullable_to_non_nullable
as List<CvResponseModel>,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as CvActionType,cv: freezed == cv ? _self.cv : cv // ignore: cast_nullable_to_non_nullable
as CvResponseModel?,
  ));
}


}

/// @nodoc


class CvError implements CvState {
  const CvError({required this.message, final  List<CvResponseModel> cvs = const [], required this.actionType, this.fileName, this.sizeInBytes}): _cvs = cvs;
  

 final  String message;
 final  List<CvResponseModel> _cvs;
@override@JsonKey() List<CvResponseModel> get cvs {
  if (_cvs is EqualUnmodifiableListView) return _cvs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cvs);
}

 final  CvActionType actionType;
 final  String? fileName;
 final  int? sizeInBytes;

/// Create a copy of CvState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CvErrorCopyWith<CvError> get copyWith => _$CvErrorCopyWithImpl<CvError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CvError&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._cvs, _cvs)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.sizeInBytes, sizeInBytes) || other.sizeInBytes == sizeInBytes));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_cvs),actionType,fileName,sizeInBytes);

@override
String toString() {
  return 'CvState.error(message: $message, cvs: $cvs, actionType: $actionType, fileName: $fileName, sizeInBytes: $sizeInBytes)';
}


}

/// @nodoc
abstract mixin class $CvErrorCopyWith<$Res> implements $CvStateCopyWith<$Res> {
  factory $CvErrorCopyWith(CvError value, $Res Function(CvError) _then) = _$CvErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, List<CvResponseModel> cvs, CvActionType actionType, String? fileName, int? sizeInBytes
});




}
/// @nodoc
class _$CvErrorCopyWithImpl<$Res>
    implements $CvErrorCopyWith<$Res> {
  _$CvErrorCopyWithImpl(this._self, this._then);

  final CvError _self;
  final $Res Function(CvError) _then;

/// Create a copy of CvState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cvs = null,Object? actionType = null,Object? fileName = freezed,Object? sizeInBytes = freezed,}) {
  return _then(CvError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cvs: null == cvs ? _self._cvs : cvs // ignore: cast_nullable_to_non_nullable
as List<CvResponseModel>,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as CvActionType,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,sizeInBytes: freezed == sizeInBytes ? _self.sizeInBytes : sizeInBytes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
