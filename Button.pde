
class Button{
  
  color buttonColor;
  Integer [] pos;          //of top left vertex
  int buttonWidth, buttonHeight;
  Action action;
  String actionString;
  
  Button(int x, int y, int w, int h, color c, Action a)
  {
    buttonColor = c;
    pos = new Integer[2];
    pos[0] = x;
    pos[1] = y;
    buttonWidth = w;
    buttonHeight = h;
    action = a;
  }
  
  void onClick()
  {
    this.action.executeAction(); 
  }
  
  boolean isClicked()
  {
    return mouseOver();
  }
  
  void print()    //add names
  {
      stroke(0);
      if(mouseOver())  //change color if mouseOver
        fill(color(255- red(buttonColor), 255 - green(buttonColor), 255 - blue(buttonColor)));
       else fill(buttonColor);       rect(pos[0], pos[1], buttonWidth, buttonHeight);
      
       fill(255);
       textSize(20);
       text(action.getActionName(), pos[0] + 25, pos[1] + 20);
      
  }
  
  boolean mouseOver()
  {
      return (mouseX>= pos[0] && mouseX <=pos[0] + buttonWidth && mouseY >= pos[1] && mouseY <= pos[1] + buttonHeight);
  }
}
