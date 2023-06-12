class ship {

  PVector position, velocity, acceleration;
  float radius, max_velocity;

  boolean orbiting = false;
  int timer = int(3 * frameRate);

  PImage sprite;

  ship(PVector pos, PVector vel, PVector acc, float R) {

    position = pos;
    velocity = vel;
    acceleration = acc;
    radius = R;

    max_velocity = 10;

    sprite = loadImage("sprites/ship.png");
  }

  void display() {

    push();
    translate(position.x, position.y);
    rotate(velocity.heading() + PI/2);
    image(sprite, 0, 0, radius * 2, radius * 2);
    pop();
  }

  void update(planet p) {

    if (in_orbit(p)) {

      if (!orbital_warning_playing) {
        orbital_warning.play();
        orbital_warning_playing = true;
      }

      if (!orbiting) {
        orbiting = true;
      }

      timer--;

      //original:
      acceleration.x = constrain(p.position.x - position.x, -p.gravity, p.gravity);
      acceleration.y = constrain(p.position.y - position.y, -p.gravity, p.gravity);

      //after playtesting session:
      //acceleration.x += constrain((p.position.x - position.x) * 0.05, -p.gravity, p.gravity);
      //acceleration.y += constrain((p.position.y - position.y) * 0.05, -p.gravity, p.gravity);

      if (timer == 0) {

        orbital_warning.stop();
        orbital_warning_playing = false;
        orbital_kick.play();
        velocity.mult(-1);
        acceleration.mult(-1);
        while (in_orbit(p)) {
          position.add(velocity);
        }
      }
    } else {
      orbital_warning.stop();
      orbital_warning_playing = false;
      orbiting = false;
      timer = int(3 * frameRate);
    }

    velocity.add(acceleration);
    velocity.limit(max_velocity);
    position.add(velocity);

    handle_edge_collisions();
  }

  void handle_edge_collisions() {

    if (position.x + velocity.x >= width || position.x + velocity.x <= 0) {
      velocity.x *= -1;
      acceleration.x *= -1;
    }

    if (position.y + velocity.y >= height || position.y + velocity.y <= 0) {
      velocity.y *= -1;
      acceleration.y *= -1;
    }
  }

  boolean in_orbit(planet p) {

    return dist(position.x, position.y, p.position.x, p.position.y) <= p.radius;
  }
}
