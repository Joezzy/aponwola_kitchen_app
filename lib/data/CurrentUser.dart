class CurrentUser {
  CurrentUser({
     this.image,
     this.address,
     this.name,
     this.phone,
     this.createdAt,
     this.id,
     this.lastActive,
     this.email,
     this.pushToken,
  });

   String? image;
   String? address;
   String? name;
   String? createdAt;
   String? id;
   String? lastActive;
   String? email;
   String? phone;
   String? pushToken;

  CurrentUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    address = json['about'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    lastActive = json['last_active'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    pushToken = json['push_token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = address;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }
}
