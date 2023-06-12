class planet {
  
  PVector position;
  float gravity, radius;
  
  PImage sprite;
  
  planet(float G, float R) {
    
    position = new PVector(mouseX, mouseY);
    gravity = G;
    radius = R;
    
    sprite = loadImage("sprites/earth.png");
  }
  
  void display(ship s) {
    
    image(sprite, position.x, position.y, radius/3, radius/3);
    
    noFill();
    stroke(lerpColor(#00ff00, #ff0000, map(s.timer, 3 * frameRate, 0, 0, 1)));
    strokeWeight(2);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
  
  void update() {
    
    position = new PVector(mouseX, mouseY);
  }
}
