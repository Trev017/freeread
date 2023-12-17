import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class OnlineService {
  String booksUrl = 'https://librivox.org/api/feed/audiobooks/?format=json&extended=1';
  String authorsUrl = 'https://librivox.org/api/feed/authors/?format=json';
  String chaptersUrl = 'https://librivox.org/api/feed/audiotracks/?format=json';
}