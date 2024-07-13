class CatalogueEffect {
  final List<CatalogueHealth> list=[
    CatalogueHealth(
      rangeAlchool: [0,0.1],
      description: 'No effect for your health' 
    ),

    CatalogueHealth(
      rangeAlchool: [0.1,0.3],
      description: 'Initial feeling of inebriation. Initial reduction of inhibitions and control' 
    ),
    
    CatalogueHealth(
      rangeAlchool: [0.3,0.5],
      description: 'Feeling of inebriation. Reduction of inhibitions, control and perception of risk' 
    ),

    CatalogueHealth(
      rangeAlchool: [0.5,0.8],
      description: 'Mood changes. Nausea, drowsiness. State of emotional arousal' 
    ),

    CatalogueHealth(
      rangeAlchool: [0.8,1.5],
      description: 'Mood changes, anger, sadness, mental confusion, disorientation' 
    ),

    CatalogueHealth(
      rangeAlchool: [1.5,3.0],
      description: 'Stunnedness, aggression, depressive state, apathy, lethargy' 
    ),

     CatalogueHealth(
      rangeAlchool: [3.0,4.0],
      description: 'State of unconsciousness' 
    ),

    CatalogueHealth(
      rangeAlchool: [4.0,10000],
      description: 'Difficulty breathing, feeling of suffocation, feeling of dying' 
    ),
    

  ];
}

class CatalogueHealth{
  List<double> rangeAlchool;
  String description;
  
  CatalogueHealth({required this.rangeAlchool, required this.description});
}