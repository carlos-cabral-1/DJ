class wormhole {
  
  PVector position, velocity, acceleration;
  float radius, max_velocity;
  PImage sprite;
  
  float rot = 0;
  
  boolean type;
  
  wormhole(float R, boolean t) {
    position = new PVector(random(width), random(height));
    velocity = new PVector(random(-2, 2), random(-2, 2));
    acceleration = new PVector(random(-2, 2), random(-2, 2));
    
    radius = R;
    type = t;
    max_velocity = 2;
    
    sprite = loadImage(t ? "sprites/wormhole_1.png" : "sprites/wormhole_2.png");
  }
  
  void display() {
    
    imageMode(CENTER);
    
    push();
    translate(position.x, position.y);
    rotate(rot);
    image(sprite, 0, 0, radius*2, radius*2);
    pop();
    
    rot -= PI/100;
    
    textAlign(CENTER, CENTER);
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
