// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_entry_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimeEntryCollection on Isar {
  IsarCollection<TimeEntry> get timeEntrys => this.collection();
}

const TimeEntrySchema = CollectionSchema(
  name: r'TimeEntry',
  id: -8996794355716442839,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'didFinish': PropertySchema(
      id: 1,
      name: r'didFinish',
      type: IsarType.bool,
    ),
    r'duration': PropertySchema(
      id: 2,
      name: r'duration',
      type: IsarType.long,
    )
  },
  estimateSize: _timeEntryEstimateSize,
  serialize: _timeEntrySerialize,
  deserialize: _timeEntryDeserialize,
  deserializeProp: _timeEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _timeEntryGetId,
  getLinks: _timeEntryGetLinks,
  attach: _timeEntryAttach,
  version: '3.1.0+1',
);

int _timeEntryEstimateSize(
  TimeEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _timeEntrySerialize(
  TimeEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeBool(offsets[1], object.didFinish);
  writer.writeLong(offsets[2], object.duration);
}

TimeEntry _timeEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimeEntry();
  object.date = reader.readDateTimeOrNull(offsets[0]);
  object.didFinish = reader.readBoolOrNull(offsets[1]);
  object.duration = reader.readLongOrNull(offsets[2]);
  object.id = id;
  return object;
}

P _timeEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _timeEntryGetId(TimeEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _timeEntryGetLinks(TimeEntry object) {
  return [];
}

void _timeEntryAttach(IsarCollection<dynamic> col, Id id, TimeEntry object) {
  object.id = id;
}

extension TimeEntryQueryWhereSort
    on QueryBuilder<TimeEntry, TimeEntry, QWhere> {
  QueryBuilder<TimeEntry, TimeEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TimeEntryQueryWhere
    on QueryBuilder<TimeEntry, TimeEntry, QWhereClause> {
  QueryBuilder<TimeEntry, TimeEntry, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimeEntryQueryFilter
    on QueryBuilder<TimeEntry, TimeEntry, QFilterCondition> {
  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> dateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> dateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> dateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> dateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> didFinishIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'didFinish',
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition>
      didFinishIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'didFinish',
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> didFinishEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'didFinish',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> durationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'duration',
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition>
      durationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'duration',
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> durationEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> durationGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> durationLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> durationBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimeEntryQueryObject
    on QueryBuilder<TimeEntry, TimeEntry, QFilterCondition> {}

extension TimeEntryQueryLinks
    on QueryBuilder<TimeEntry, TimeEntry, QFilterCondition> {}

extension TimeEntryQuerySortBy on QueryBuilder<TimeEntry, TimeEntry, QSortBy> {
  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> sortByDidFinish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'didFinish', Sort.asc);
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> sortByDidFinishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'didFinish', Sort.desc);
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }
}

extension TimeEntryQuerySortThenBy
    on QueryBuilder<TimeEntry, TimeEntry, QSortThenBy> {
  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> thenByDidFinish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'didFinish', Sort.asc);
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> thenByDidFinishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'didFinish', Sort.desc);
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension TimeEntryQueryWhereDistinct
    on QueryBuilder<TimeEntry, TimeEntry, QDistinct> {
  QueryBuilder<TimeEntry, TimeEntry, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QDistinct> distinctByDidFinish() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'didFinish');
    });
  }

  QueryBuilder<TimeEntry, TimeEntry, QDistinct> distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duration');
    });
  }
}

extension TimeEntryQueryProperty
    on QueryBuilder<TimeEntry, TimeEntry, QQueryProperty> {
  QueryBuilder<TimeEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TimeEntry, DateTime?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<TimeEntry, bool?, QQueryOperations> didFinishProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'didFinish');
    });
  }

  QueryBuilder<TimeEntry, int?, QQueryOperations> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duration');
    });
  }
}
