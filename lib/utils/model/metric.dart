import 'dart:convert';

class Metric {
  int metricId;
  String metricName;
  int target;
  String metricType;
  int term;

  int get getMetricId => this.metricId;

  set setMetricId(int metricId) => this.metricId = metricId;

  get getMetricName => this.metricName;

  set setMetricName(metricName) => this.metricName = metricName;

  get getTarget => this.target;

  set setTarget(target) => this.target = target;

  get getMetricType => this.metricType;

  set setMetricType(metricType) => this.metricType = metricType;

  get getTerm => this.term;

  set setTerm(term) => this.term = term;

  Metric(
      {this.metricId,
      this.metricName,
      this.target,
      this.metricType,
      this.term});

  Map<String, dynamic> toMap() {
    return {
      'metricId': metricId,
      'metricName': metricName,
      'target': target,
      'metricType': metricType,
      'term': term,
    };
  }

  factory Metric.fromMap(Map<String, dynamic> map) {
    return Metric(
      metricId: map['metricId'],
      metricName: map['metricName'],
      target: map['target'],
      metricType: map['metricType'],
      term: map['term'],
    );
  }

  Metric.fromObject(dynamic o) {
    this.metricId = o["metricId"];
    this.metricName = o["metricName"];
    this.target = o["target"];
    this.metricType = o["metricType"];
    this..term = o["term"];
  }

  String toJson() => json.encode(toMap());

  factory Metric.fromJson(String source) => Metric.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Metric(metricId: $metricId, metricName: $metricName, target: $target, metricType: $metricType, term: $term)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Metric &&
        other.metricId == metricId &&
        other.metricName == metricName &&
        other.target == target &&
        other.metricType == metricType &&
        other.term == term;
  }

  @override
  int get hashCode {
    return metricId.hashCode ^
        metricName.hashCode ^
        target.hashCode ^
        metricType.hashCode ^
        term.hashCode;
  }

  Metric setTargett(int target) {
    this.target = target;
  }
}
