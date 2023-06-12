class tutorial_panel {

  button start;
  PImage tut_panel;
  
  tutorial_panel() {
    
    start = new button(new PVector(width/2, height/2 + 260), new PVector(700, 110), 0);
    tut_panel = loadImage("sprites/tutorial_panel.png");
  }

  void display() {
    background(tut_panel);

    start.display();

    if (mousePressed && start.mouseHover()) {
      menu.menu_music.stop();
      menu.music_playing = false;
      start.click.play();
      start.click.amp(0.2);
      screen = 0;
    }
  }
}
