class start_menu {

  button play, tutorial;
  SoundFile menu_music;
  boolean music_playing = false;
  
  PImage main_menu;

  start_menu() {

    play = new button(new PVector(width/2, height/2 + 160), new PVector(220, 60), 0);
    tutorial = new button(new PVector(width/2, height/2 + 295), new PVector(400, 60), 0);
    
    menu_music = new SoundFile(DJ_Proj.this, "sounds/menu_music.wav");
    main_menu = loadImage("sprites/main_menu.png");
  }

  void display() {
    
    if(!music_playing) {
      music_playing = true;
      menu_music.loop();
      menu_music.amp(0.2);
    }
    background(main_menu);

    play.display();
    tutorial.display();

    if (mousePressed && play.mouseHover()) {
      play.click.play();
      play.click.amp(0.2);
      screen = 1;

      points = 0;
      lives = 3;

      earth = new planet(.5, 200);
      eagle = new ship(new PVector(width/2, height/2), new PVector(random(-2, 2), random(-2, 2)), new PVector(random(-2, 2), random(-2, 2)), 20);
      a1 = new asteroid(40);
      m = new moon(30);
      w1 = new wormhole(50, true);
      w2 = new wormhole(50, false);
      b1 = new barrier(20);
      b2 = new barrier(20);
      iss = new space_station(30);
    }
    
    if (mousePressed && tutorial.mouseHover()) {
      tutorial.click.play();
      tutorial.click.amp(0.2);
      screen = 3;
    }
  }
}
