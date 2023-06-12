class game_over {

  button back_to_main, options;
  SoundFile game_over;
  boolean game_over_playing = false;
  
  PImage game_over_screen;

  game_over() {

    back_to_main = new button(new PVector(width/2, height/2 + 260), new PVector(900, 110), 0);
    
    game_over = new SoundFile(DJ_Proj.this, "sounds/game_over.wav");
    game_over_screen = loadImage("sprites/game_over.png");
  }

  void display() {
    
    if(!game_over_playing){
      game_over_playing = true;
      game_over.play();
      game_over.amp(0.7);
    }
    background(game_over_screen);

    fill(255);
    textAlign(CENTER, CENTER);
    
    textFont(createFont("Fonts/PublicPixel.ttf", 50));
    text(points, width/2, height/2 + 35);
    textFont(HUD);

    back_to_main.display();

    if (mousePressed && back_to_main.mouseHover()) {
      game_over.stop();
      game_over_playing = false;
      back_to_main.click.play();
      back_to_main.click.amp(0.2);
      screen = -1;
    }
  }
}
