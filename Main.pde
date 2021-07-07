

int mazeRows = 20, mazeCols = 20;
int xOffset = 50, yOffset = 65;
int buttonSpacing = 20, buttYBegin = 20;  //maze cant go lower than buttYBegin
Maze maze;
ButtonList buttonList;
Choice choice;

enum Choice {
    PAUSE,
    STEP,
    RUN,
    FINISHED,
    RESET,
    SAVE
}

void setup(){
  size(1000, 1000);
  frameRate(60);
  maze = new Maze(mazeRows, mazeCols, xOffset, yOffset);
  buttonList = new ButtonList(buttonSpacing, buttYBegin);
  choice = Choice.PAUSE;
}

void draw(){
  background(0);
  buttonList.printButtons();  //always need this
  
  switch(choice)
  {
      case PAUSE:
       break;
      case RUN:  maze.generate();
                 break;
      case STEP: maze.generate();  
      case FINISHED:  System.out.println("FINISHED");
           choice = Choice.PAUSE;
        break;
      default:  
        break;
      
  }
   maze.print();
}

void mousePressed()
{
  buttonList.checkForButtonClick();
}
