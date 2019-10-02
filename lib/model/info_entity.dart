class InfoEntity {
	String date;
	List<InfoTopStory> topStories;
	List<InfoStory> stories;

	InfoEntity({this.date, this.topStories, this.stories});

	InfoEntity.fromJson(Map<String, dynamic> json) {
		date = json['date'];
		if (json['top_stories'] != null) {
			topStories = new List<InfoTopStory>();(json['top_stories'] as List).forEach((v) { topStories.add(new InfoTopStory.fromJson(v)); });
		}
		if (json['stories'] != null) {
			stories = new List<InfoStory>();(json['stories'] as List).forEach((v) { stories.add(new InfoStory.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['date'] = this.date;
		if (this.topStories != null) {
      data['top_stories'] =  this.topStories.map((v) => v.toJson()).toList();
    }
		if (this.stories != null) {
      data['stories'] =  this.stories.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class InfoTopStory {
	String image;
	String hint;
	String gaPrefix;
	String imageHue;
	int id;
	String title;
	int type;
	String url;

	InfoTopStory({this.image, this.hint, this.gaPrefix, this.imageHue, this.id, this.title, this.type, this.url});

	InfoTopStory.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		hint = json['hint'];
		gaPrefix = json['ga_prefix'];
		imageHue = json['image_hue'];
		id = json['id'];
		title = json['title'];
		type = json['type'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['hint'] = this.hint;
		data['ga_prefix'] = this.gaPrefix;
		data['image_hue'] = this.imageHue;
		data['id'] = this.id;
		data['title'] = this.title;
		data['type'] = this.type;
		data['url'] = this.url;
		return data;
	}
}

class InfoStory {
	List<String> images;
	String hint;
	String gaPrefix;
	String imageHue;
	int id;
	String title;
	int type;
	String url;

	InfoStory({this.images, this.hint, this.gaPrefix, this.imageHue, this.id, this.title, this.type, this.url});

	InfoStory.fromJson(Map<String, dynamic> json) {
		images = json['images']?.cast<String>();
		hint = json['hint'];
		gaPrefix = json['ga_prefix'];
		imageHue = json['image_hue'];
		id = json['id'];
		title = json['title'];
		type = json['type'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['images'] = this.images;
		data['hint'] = this.hint;
		data['ga_prefix'] = this.gaPrefix;
		data['image_hue'] = this.imageHue;
		data['id'] = this.id;
		data['title'] = this.title;
		data['type'] = this.type;
		data['url'] = this.url;
		return data;
	}
}
