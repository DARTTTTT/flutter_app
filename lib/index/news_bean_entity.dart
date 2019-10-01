class NewsBeanEntity {
	String date;
	List<NewsBeanTopStory> topStories;
	List<NewsBeanStory> stories;

	NewsBeanEntity({this.date, this.topStories, this.stories});

	NewsBeanEntity.fromJson(Map<String, dynamic> json) {
		date = json['date'];
		if (json['top_stories'] != null) {
			topStories = new List<NewsBeanTopStory>();(json['top_stories'] as List).forEach((v) { topStories.add(new NewsBeanTopStory.fromJson(v)); });
		}
		if (json['stories'] != null) {
			stories = new List<NewsBeanStory>();(json['stories'] as List).forEach((v) { stories.add(new NewsBeanStory.fromJson(v)); });
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

class NewsBeanTopStory {
	String image;
	String hint;
	String gaPrefix;
	String imageHue;
	int id;
	String title;
	int type;
	String url;

	NewsBeanTopStory({this.image, this.hint, this.gaPrefix, this.imageHue, this.id, this.title, this.type, this.url});

	NewsBeanTopStory.fromJson(Map<String, dynamic> json) {
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

class NewsBeanStory {
	List<String> images;
	String hint;
	String gaPrefix;
	String imageHue;
	int id;
	String title;
	int type;
	String url;

	NewsBeanStory({this.images, this.hint, this.gaPrefix, this.imageHue, this.id, this.title, this.type, this.url});

	NewsBeanStory.fromJson(Map<String, dynamic> json) {
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
