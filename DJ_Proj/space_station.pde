class space_station {
  
  PVector position, velocity, acceleration;
  float radius, max_velocity;
  
  PImage sprite;
  
  space_station(float R) {
    position = new PVector(random(width), random(height));
    velocity = new PVector(random(-2, 2), random(-2, 2));
    acceleration = new PVector(random(-2, 2), random(-2, 2));
    
    radius = R;
    max_velocity = 2;
    
    sprite = loadImage("sprites/ISS.png");
  }
  
  void display() {
    
    image(sprite, position.x, position.y, radius * 2, radius * 2);
  }
  
  void update() {
    
    velocity.add(acceleration);
    velocity.limit(max_velocity);
    position.add(velocity);
    
    handle_edge_collisions();
  }
  
  void handle_edge_collisions() {
    
    if(position.x + velocity.x >= width || position.x + velocity.x <= 0) {
      velocity.x *= -1;
      acceleration.x *= -1;
    }
    
    if(position.y + velocity.y >= height || position.y + velocity.y <= 0) {
      velocity.y *= -1;
      acceleration.y *= -1;
    }
  }
}
