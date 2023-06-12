class moon {
  
  PVector position;
  float radius, max_velocity;
  
  PImage sprite;
  
  moon(float R) {
    position = new PVector(random(width), random(height));
    
    radius = R;
    max_velocity = 1;
    
    sprite = loadImage("sprites/moon.png");
  }
  
  void display() {
    
    image(sprite, position.x, position.y, radius * 2, radius * 2);
  }
  
}
