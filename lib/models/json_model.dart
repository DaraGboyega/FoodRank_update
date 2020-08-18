// To parse this JSON data, do
//
//     final analysis = analysisFromMap(jsonString);

import 'dart:convert';

Analysis analysisFromMap(String str) => Analysis.fromMap(json.decode(str));

String analysisToMap(Analysis data) => json.encode(data.toMap());

class Analysis {
    Analysis({
        this.uri,
        this.calories,
        this.totalWeight,
        this.dietLabels,
        this.healthLabels,
        this.cautions,
        this.totalNutrients,
        this.totalDaily,
        this.ingredients,
    });

    String uri;
    int calories;
    double totalWeight;
    List<String> dietLabels;
    List<String> healthLabels;
    List<dynamic> cautions;
    Map<String, TotalDaily> totalNutrients;
    Map<String, TotalDaily> totalDaily;
    List<Ingredient> ingredients;

    factory Analysis.fromMap(Map<String, dynamic> json) => Analysis(
        uri: json["uri"],
        calories: json["calories"],
        totalWeight: json["totalWeight"],
        dietLabels: List<String>.from(json["dietLabels"].map((x) => x)),
        healthLabels: List<String>.from(json["healthLabels"].map((x) => x)),
        cautions: List<dynamic>.from(json["cautions"].map((x) => x)),
        totalNutrients: Map.from(json["totalNutrients"]).map((k, v) => MapEntry<String, TotalDaily>(k, TotalDaily.fromMap(v))),
        totalDaily: Map.from(json["totalDaily"]).map((k, v) => MapEntry<String, TotalDaily>(k, TotalDaily.fromMap(v))),
        ingredients: List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "uri": uri,
        "calories": calories,
        "totalWeight": totalWeight,
        "dietLabels": List<dynamic>.from(dietLabels.map((x) => x)),
        "healthLabels": List<dynamic>.from(healthLabels.map((x) => x)),
        "cautions": List<dynamic>.from(cautions.map((x) => x)),
        "totalNutrients": Map.from(totalNutrients).map((k, v) => MapEntry<String, dynamic>(k, v.toMap())),
        "totalDaily": Map.from(totalDaily).map((k, v) => MapEntry<String, dynamic>(k, v.toMap())),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toMap())),
    };
}

class Ingredient {
    Ingredient({
        this.text,
        this.parsed,
    });

    String text;
    List<Parsed> parsed;

    factory Ingredient.fromMap(Map<String, dynamic> json) => Ingredient(
        text: json["text"],
        parsed: List<Parsed>.from(json["parsed"].map((x) => Parsed.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "text": text,
        "parsed": List<dynamic>.from(parsed.map((x) => x.toMap())),
    };
}

class Parsed {
    Parsed({
        this.quantity,
        this.measure,
        this.foodMatch,
        this.food,
        this.foodId,
        this.weight,
        this.retainedWeight,
        this.nutrients,
        this.measureUri,
        this.status,
    });

    double quantity;
    String measure;
    String foodMatch;
    String food;
    String foodId;
    double weight;
    double retainedWeight;
    Map<String, TotalDaily> nutrients;
    String measureUri;
    String status;

    factory Parsed.fromMap(Map<String, dynamic> json) => Parsed(
        quantity: json["quantity"],
        measure: json["measure"],
        foodMatch: json["foodMatch"],
        food: json["food"],
        foodId: json["foodId"],
        weight: json["weight"],
        retainedWeight: json["retainedWeight"],
        nutrients: Map.from(json["nutrients"]).map((k, v) => MapEntry<String, TotalDaily>(k, TotalDaily.fromMap(v))),
        measureUri: json["measureURI"],
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "quantity": quantity,
        "measure": measure,
        "foodMatch": foodMatch,
        "food": food,
        "foodId": foodId,
        "weight": weight,
        "retainedWeight": retainedWeight,
        "nutrients": Map.from(nutrients).map((k, v) => MapEntry<String, dynamic>(k, v.toMap())),
        "measureURI": measureUri,
        "status": status,
    };
}

class TotalDaily {
    TotalDaily({
        this.label,
        this.quantity,
        this.unit,
    });

    String label;
    double quantity;
    Unit unit;

    factory TotalDaily.fromMap(Map<String, dynamic> json) => TotalDaily(
        label: json["label"],
        quantity: json["quantity"].toDouble(),
        unit: unitValues.map[json["unit"]],
    );

    Map<String, dynamic> toMap() => {
        "label": label,
        "quantity": quantity,
        "unit": unitValues.reverse[unit],
    };
}

enum Unit { MG, G, KCAL, UNIT_G, EMPTY }

final unitValues = EnumValues({
    "%": Unit.EMPTY,
    "g": Unit.G,
    "kcal": Unit.KCAL,
    "mg": Unit.MG,
    "µg": Unit.UNIT_G
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
