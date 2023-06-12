class barrier {
  
  PVector position, velocity, acceleration;
  float radius, max_velocity;
  int lives;
  
  PImage sprite1, sprite2;
  
  boolean type;
  
  barrier(float R) {
    position = new PVector(random(width), random(height));
    velocity = new PVector(random(-2, 2), random(-2, 2));
    acceleration = new PVector(random(-2, 2), random(-2, 2));
    
    radius = R;
    max_velocity = 2;
    lives = 2;
    
    sprite1 = loadImage("sprites/barrier_1.png");
    sprite2 = loadImage("sprites/barrier_2.png");
  }
  
  void display(barrier b) {
    
    stroke(lives == 2 ? #22aa00 : #aa2200, 50);
    strokeWeight(lives == 2 ? 10 : 5);
    line(b.position.x, b.position.y, position.x, position.y);
    
    image(lives == 2 ? sprite1 : sprite2, position.x, position.y, radius * 2, radius * 2);
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
  
  boolean isDead() {
    
    return lives == 0;
  }
}
