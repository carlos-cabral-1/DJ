///////////////////////////////////////////////////////////////
/////////////////////// DESIGN DE JOGOS ///////////////////////
///////////////////////////////////////////////////////////////

import processing.sound.*;

//VARIÁVEIS//
planet earth;
ship eagle;
asteroid a1;
moon m;
wormhole w1, w2;
barrier b1, b2;
space_station iss;

int points;
int lives;
int screen = -1; // -1: main menu // 0: gameplay // 1: before game screen // 2: game over screen // 3: tutorial

start_menu menu;
game_over game_over_screen;
tutorial_panel tut;
tutorial tutorial_screen;

SoundFile gameplay_music, ship, space_station, moon_landing, portal, asteroid, barrier, orbital_warning, orbital_kick;
boolean gameplay_music_playing = false, ship_playing = false, space_station_playing = false, moon_landing_playing = false, portal_playing = false, asteroid_playing = false, barrier_playing = false, orbital_warning_playing = false;

PImage bg;

PFont HUD, names;

//SETUP//
void setup() {

  fullScreen(P3D);

  //TEXTO
  HUD = createFont("Fonts/PublicPixel.ttf", 20);
  textFont(HUD);

  menu = new start_menu();
  game_over_screen = new game_over();
  tut = new tutorial_panel();
  tutorial_screen = new tutorial();

  gameplay_music = new SoundFile(this, "sounds/gameplay_music.wav");
  ship = new SoundFile(this, "sounds/ship.wav");
  space_station = new SoundFile(this, "sounds/space_station.wav");
  moon_landing = new SoundFile(this, "sounds/moon_landing.wav");
  portal = new SoundFile(this, "sounds/portal.wav");
  asteroid = new SoundFile(this, "sounds/asteroid.wav");
  barrier = new SoundFile(this, "sounds/barrier_hit.wav");
  orbital_warning = new SoundFile(this, "sounds/orbital_warning.wav");
  orbital_kick = new SoundFile(this, "sounds/orbital_kick.wav");
  
  bg = loadImage("sprites/bg.png");
}



//LOOP//
void draw() {

  background(bg);

  if (screen == -1) {
    
    stop_gameplay_sounds();
    menu.display();
    
  } else if (screen == 0) {
    
    start_gameplay_sounds();

    earth.display(eagle);
    eagle.display();
    a1.display();
    m.display();
    w1.display();
    w2.display();
    b1.display(b2);
    b2.display(b1);
    iss.display();

    earth.update();
    eagle.update(earth);
    a1.update();
    w1.update();
    w2.update();
    b1.update();
    b2.update();
    iss.display();

    handle_asteroid_collisions(eagle, a1, w1, w2, iss, m);
    handle_moon_collisions(eagle, m);
    handle_wormhole_collisions(eagle, w1, w2);
    handle_space_station_collisions(eagle, iss);
    handle_barrier_collisions(eagle, b1, b2);

    if (lives == 0) {
      
      stop_gameplay_sounds();
      screen = 2;
    }

    fill(255);
    textAlign(LEFT, TOP);
    text("SCORE: " + points + "\nLIVES: " + lives, 20, 20);
  } else if (screen == 1) {
    tut.display();
  } else if (screen == 2) {
    game_over_screen.display();
  } else if (screen == 3) {
    tutorial_screen.display();
  }
}

void stop_gameplay_sounds() {
  gameplay_music.stop();
  ship.stop();
  gameplay_music_playing = false;
  ship_playing = false;
  orbital_warning.stop();
  orbital_warning_playing = false;
}

void start_gameplay_sounds() {

  if (!gameplay_music_playing) {
    gameplay_music_playing = true;
    gameplay_music.loop();
    gameplay_music.amp(0.1);
  }
  
  if (!ship_playing) {
    ship_playing = true;
    ship.loop();
    ship.amp(0.2);
  }
}
