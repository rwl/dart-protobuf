// Basic smoke tests for the GeneratedMessage JSON API.
//
// There are more JSON tests in the dart-protoc-plugin package.
library canonical_json_test;

import 'dart:convert';
import 'package:test/test.dart';
import 'package:protobuf/protobuf.dart' show ExtensionRegistry, JsonEncoding;

import 'mock_util.dart' show MockMessage;

class T extends MockMessage {
  get className => "T";
  T create() => new T();
}

main() {
  T example = new T()
    ..val = 123
    ..str = "hello";

  test('testWriteToJson', () {
    String json = example.writeToJson(encoding: JsonEncoding.CANONICAL);
    checkJsonMap(JSON.decode(json));
  });

  test('writeToJsonMap', () {
    Map m = example.writeToJsonMap(encoding: JsonEncoding.CANONICAL);
    checkJsonMap(m);
  });

  test('testMergeFromJson', () {
    var t = new T();
    t.mergeFromJson('''{"val": 123, "str": "hello"}''', ExtensionRegistry.EMPTY,
        JsonEncoding.CANONICAL);
    checkMessage(t);
  });

  test('testMergeFromJsonMap', () {
    var t = new T();
    t.mergeFromJsonMap({"val": 123, "str": "hello"}, ExtensionRegistry.EMPTY,
        JsonEncoding.CANONICAL);
    checkMessage(t);
  });
}

checkJsonMap(Map m) {
  expect(m.length, 2);
  expect(m["val"], 123);
  expect(m["str"], "hello");
}

checkMessage(T t) {
  expect(t.val, 123);
  expect(t.str, "hello");
}
