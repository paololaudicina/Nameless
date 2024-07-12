

class CatalogueList {
  final List<Catalogue> list=[
    Catalogue(
      title: 'Painting and Drawing', 
      description: "Benefits: Helps express emotions non-verbally, reduces stress and anxiety, improves concentration and patience",
      imageUrl: 'images/paint.png'   
    ),
    
    Catalogue(
      title: 'Creative Writing (poetry, stories, journaling)', 
      description: "Benefits: Allows processing of emotions and thoughts, improves self-awareness, reduces stress, and helps set personal goals",
      imageUrl: 'images/writing.png' 
    ),

    Catalogue(
      title: 'Music (playing an instrument, singing, composing)', 
      description: "Benefits: Promotes emotional expression, improves mood, reduces anxiety and stress, increases discipline and concentration",
      imageUrl: 'images/guitar.png' 
    ),

    Catalogue(
      title: 'Dancing', 
      description: "Benefits: Reduces stress, improves mood through the release of endorphins, enhances coordination and physical fitness, promotes socialization",
      imageUrl: 'images/dance.png' 
    ),

    Catalogue(
      title: 'Photography', 
      description: "Benefits: Promotes mindfulness and attention to detail, encourages exploration and adventure, improves creativity and personal expression",
      imageUrl: 'images/photo.png' 
    ),

    Catalogue(
      title: 'Creative Cooking', 
      description: "Benefits: Stimulates creativity and innovation, promotes a healthy diet, encourages mindfulness and relaxation",
      imageUrl: 'images/cooking.png' 
    ),

    Catalogue(
      title: 'Gardening', 
      description: "Benefits: Reduces stress and anxiety, improves mood, provides a sense of accomplishment, promotes physical activity and contact with nature",
      imageUrl: 'images/garden.png' 
    ),

    Catalogue(
      title: 'Theater and Acting', 
      description: "Benefits: Promotes emotional expression, improves self-confidence, encourages collaboration and socialization, helps develop new skills",
      imageUrl: 'images/theater.png' 
    ),

    Catalogue(
      title: 'Yoga and Meditation', 
      description: "Benefits: Reduces stress and anxiety, improves awareness and mindfulness, promotes physical and mental well-being, fosters calm and concentration",
      imageUrl: 'images/yoga.png' 
    ),

  ];
}

class Catalogue{
  String title;
  String description;
  String imageUrl;
  Catalogue({required this.title, required this.description, required this.imageUrl});
}