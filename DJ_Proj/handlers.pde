void handle_asteroid_collisions(ship s, asteroid a, wormhole entry, wormhole exit, space_station st, moon m) {

  //ASTEROID + SHIP
  if (dist(s.position.x, s.position.y, a.position.x, a.position.y) <= a.radius + s.radius) {

    if (!asteroid_playing) {
      asteroid.play();
      asteroid.amp(0.3);
      asteroid_playing = true;
    }

    lives--;
    s.position = new PVector(random(width), random(height));
    a.position = new PVector(random(width), random(height));
    a.radius = 40;

    asteroid_playing = false;
  }
  
  //ASTEROID + WORMHOLES
  if (dist(a.position.x, a.position.y, entry.position.x, entry.position.y) <= entry.radius + a.radius) {

    if (!portal_playing) {
      portal.play();
      portal_playing = true;
    }

    a.position = new PVector(exit.position.x, exit.position.y);
    while (dist(a.position.x, a.position.y, exit.position.x, exit.position.y) <= exit.radius + a.radius) {
      a.position.add(a.velocity);
    }

    portal_playing = false;
    
  } else if (dist(a.position.x, a.position.y, exit.position.x, exit.position.y) <= exit.radius + a.radius) {

    if (!portal_playing) {
      portal.play();
      portal_playing = true;
    }

    a.position = new PVector(entry.position.x, entry.position.y);
    while (dist(a.position.x, a.position.y, entry.position.x, entry.position.y) <= entry.radius + a.radius) {
      a.position.add(s.velocity);
    }

    portal_playing = false;
  }
  
  //ASTEROID + SPACE STATION
  if (dist(st.position.x, st.position.y, a.position.x, a.position.y) <= a.radius + st.radius) {

    if (!asteroid_playing) {
      asteroid.play();
      asteroid.amp(0.3);
      asteroid_playing = true;
    }

    st.position = new PVector(random(width), random(height));

    a.radius += 20;
    asteroid_playing = false;
  }
  
  //ASTEROID + MOON
  if (dist(a.position.x, a.position.y, m.position.x, m.position.y) <= m.radius + a.radius) {

    if (!asteroid_playing) {
      asteroid.play();
      asteroid.amp(0.3);
      asteroid_playing = true;
    }

    points++;
    m.position = new PVector(random(width), random(height));
    asteroid_playing = false;
  }
}

void handle_moon_collisions(ship s, moon m) {

  if (dist(s.position.x, s.position.y, m.position.x, m.position.y) <= m.radius + s.radius) {

    if (!moon_landing_playing) {
      moon_landing.play();
      moon_landing_playing = true;
    }

    points++;
    m.position = new PVector(random(width), random(height));
    moon_landing_playing = false;
  }
}

void handle_wormhole_collisions(ship s, wormhole entry, wormhole exit) {

  if (dist(s.position.x, s.position.y, entry.position.x, entry.position.y) <= entry.radius + s.radius) {

    if (!portal_playing) {
      portal.play();
      portal_playing = true;
    }

    s.position = new PVector(exit.position.x, exit.position.y);
    while (dist(s.position.x, s.position.y, exit.position.x, exit.position.y) <= exit.radius + s.radius) {
      s.position.add(s.velocity);
    }

    if (s.position.x < 0 || s.position.x > width || s.position.y < 0 || s.position.y > height) {
      while (s.position.x < 0 || s.position.x > width || s.position.y < 0 || s.position.y > height) {
        s.position.add(s.velocity);
      }
    }
    portal_playing = false;
    
  } else if (dist(s.position.x, s.position.y, exit.position.x, exit.position.y) <= exit.radius + s.radius) {

    if (!portal_playing) {
      portal.play();
      portal_playing = true;
    }

    s.position = new PVector(entry.position.x, entry.position.y);
    while (dist(s.position.x, s.position.y, entry.position.x, entry.position.y) <= entry.radius + s.radius) {
      s.position.add(s.velocity);
    }

    portal_playing = false;
  }
}

void handle_space_station_collisions(ship s, space_station ss) {

  if (lives < 3 && dist(s.position.x, s.position.y, ss.position.x, ss.position.y) <= ss.radius + s.radius) {

    if (!space_station_playing) {
      space_station.play();
      space_station_playing = true;
    }

    lives++;
    ss.position = new PVector(random(width), random(height));
    space_station_playing = false;
  }
}

void handle_barrier_collisions(ship s, barrier node1, barrier node2) {

  float l = dist(node1.position.x, node1.position.y, node2.position.x, node2.position.y)/2;
  float r = s.radius;
  float h = sqrt(pow(l, 2) + pow(r, 2));

  if ((dist(s.position.x, s.position.y, node1.position.x, node1.position.y) + dist(s.position.x, s.position.y, node2.position.x, node2.position.y)) <= h * 2) {
    lives--;
    node1.lives--;
    node2.lives--;

    if (!barrier_playing) {
      barrier.play();
      barrier_playing = true;
    }

    s.velocity.mult(-1);
    s.acceleration.mult(-1);

    barrier_playing = false;

    if (node1.isDead() || node2.isDead()) {
      node1.position = new PVector(random(width), random(height));
      node1.lives = 2;
      node2.position = new PVector(random(width), random(height));
      node2.lives = 2;
    }
  }
}
