class tutorial {

  button back;
  PImage tutorial;
  
  tutorial() {
    
    back = new button(new PVector(width/2, height/2 + 450), new PVector(300, 60), 0);
    tutorial = loadImage("sprites/tutorial.png");
  }

  void display() {
    background(tutorial);

    back.display();

    if (mousePressed && back.mouseHover()) {
      back.click.play();
      back.click.amp(0.2);
      screen = -1;
    }
  }
}
