class button {
  
  PVector pos, size;
  int targ;
  SoundFile hover, click;
  boolean hovering = false;
  
  button(PVector position, PVector dimensions, int target_screen) {
    
    pos = position;
    size = dimensions;
    targ = target_screen;
    
    hover = new SoundFile(DJ_Proj.this, "sounds/button_hover.wav");
    click = new SoundFile(DJ_Proj.this, "sounds/button_click.wav");
  }
  
  void display() {
    
    if(this.mouseHover() && !hovering){
      hover.play();
      hovering = true;
      hover.amp(0.2);
    } else if(!this.mouseHover()){
      hovering = false;
    }
  }
  
  boolean mouseHover() {
    
    return (mouseX >= pos.x - size.x/2 && mouseX <= pos.x + size.x/2 && mouseY >= pos.y - size.y/2 && mouseY <= pos.y + size.y/2);
  }
}
