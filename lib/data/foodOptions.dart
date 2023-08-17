


class FoodOption {
     String image;
     String title;
     String value;

    FoodOption({ required this.image,required this.title,required this.value});
     toJson(){
       return { "image": image,
         "title":title,
         "value":value
       };
     }

}