// To parse this JSON data, do
//
//     final moodEntry = moodEntryFromJson(jsonString);

import 'dart:convert';

MoodEntry moodEntryFromJson(String str) => MoodEntry.fromJson(json.decode(str));

String moodEntryToJson(MoodEntry data) => json.encode(data.toJson());

class MoodEntry {
    String model;
    String pk;
    Fields fields;

    MoodEntry({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory MoodEntry.fromJson(Map<String, dynamic> json) => MoodEntry(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String mood;
    DateTime time;
    String feelings;
    int moodIntensity;
    int user;

    Fields({
        required this.mood,
        required this.time,
        required this.feelings,
        required this.moodIntensity,
        required this.user,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        mood: json["mood"],
        time: DateTime.parse(json["time"]),
        feelings: json["feelings"],
        moodIntensity: json["mood_intensity"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "mood": mood,
        "time": "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}",
        "feelings": feelings,
        "mood_intensity": moodIntensity,
        "user": user,
    };
}
