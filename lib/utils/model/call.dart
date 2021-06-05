import 'dart:async';
import 'dart:convert';

class Call {
  String vruLine;
  int callId;
  String customerId;
  int priority;
  String type;
  int date;
  String vruEntry;
  String vruExit;
  int vruTime;
  String qStart;
  String qExit;
  int qTime;
  String outcome;
  String serStart;
  String serExit;
  int serTime;
  String server;

  Call({
    this.vruLine,
    this.callId,
    this.customerId,
    this.priority,
    this.type,
    this.date,
    this.vruEntry,
    this.vruExit,
    this.vruTime,
    this.qStart,
    this.qExit,
    this.qTime,
    this.outcome,
    this.serStart,
    this.serExit,
    this.serTime,
    this.server,
  });

  Map<String, dynamic> toMap() {
    return {
      'vruline': vruLine,
      'call_id': callId,
      'customer_id': customerId,
      'priority': priority,
      'type': type,
      'date': date,
      'vru_entry': vruEntry,
      'vru_exit': vruExit,
      'vru_time': vruTime,
      'q_start': qStart,
      'q_exit': qExit,
      'q_time': qTime,
      'outcome': outcome,
      'ser_start': serStart,
      'ser_exit': serExit,
      'ser_time': serTime,
      'server': server,
    };
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    return Call(
      vruLine: map['vruline'],
      callId: int.parse(map['call_id']),
      customerId: map['customer_id'],
      priority: int.parse(map['priority']),
      type: map['type'],
      date: int.parse(map['date']),
      vruEntry: map['vru_entry'],
      vruExit: map['vru_exit'],
      vruTime: int.parse(map['vru_time']),
      qStart: map['q_start'],
      qExit: map['q_exit'],
      qTime: int.parse(map['q_time']),
      outcome: map['outcome'],
      serStart: map['ser_start'],
      serExit: map['ser_exit'],
      serTime: int.parse(map['ser_time']),
      server: map['server'],
    );
  }

  factory Call.fromMapToDb(Map<String, dynamic> map) {
    return Call(
      vruLine: map['vruline'],
      callId: map['call_id'],
      customerId: map['customer_id'].toString(),
      priority: map['priority'],
      type: map['type'],
      date: map['date'],
      vruEntry: map['vru_entry'],
      vruExit: map['vru_exit'],
      vruTime: map['vru_time'],
      qStart: map['q_start'],
      qExit: map['q_exit'],
      qTime: map['q_time'],
      outcome: map['outcome'],
      serStart: map['ser_start'],
      serExit: map['ser_exit'],
      serTime: map['ser_time'],
      server: map['server'],
    );
  }

  Call.fromObject(dynamic o) {
    this.vruLine = o["vruline"];
    this.callId = o["call_id"];
    this.customerId = o["customer_id"];
    this.priority = o["priority"];
    this..type = o["type"];
    this.date = o["date"];
    this.vruEntry = o["vru_entry"];
    this.vruExit = o["vru_exit"];
    this.vruTime = o["vru_time"];
    this.qStart = o["q_start"];
    this.qExit = o["q_exit"];
    this.qTime = o["q_time"];
    this.outcome = o["outcome"];
    this.serStart = o["ser_start"];
    this.serExit = o["ser_exit"];
    this.serTime = o["ser_time"];
    this.server = o["server"];
  }

  String toJson() => json.encode(toMap());

  factory Call.fromJson(String source) => Call.fromMap(json.decode(source));
}
