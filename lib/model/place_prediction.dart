

class PlacePrediction {
   String? secodary_text;
   String? main_text;
   String? place_id;

  PlacePrediction({
    this.secodary_text,
    this.main_text,
    this.place_id,
});

   PlacePrediction.fromJson(Map<String, dynamic> json) {
        place_id = json['place_id'];
        main_text = json['main_text'];
        secodary_text = json['secondary_text'];
  }

}