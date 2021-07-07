
abstract class Action
{
  public abstract void executeAction();
  
  public abstract String getActionName();
}

class PauseAction extends Action
{
  public void executeAction()
  {
    System.out.println("Executing action: " + this.getActionName());
    choice = Choice.PAUSE;
  }
  
  String getActionName()
  {
     return "Pause";
  }
  
}

class StepAction extends Action
{
  public void executeAction()
  {
     System.out.println("Executing action: " + this.getActionName());
     maze.stepOnce = true;
     choice = Choice.STEP;
  }
  
  String getActionName()
  {
     return "Step";
  }
  
  
}

class RunAction extends Action
{
  public void executeAction()
  {
     System.out.println("Executing action: " + this.getActionName());
     choice = Choice.RUN;
  }
  
  String getActionName()
  {
     return "Run";
  }
  
  
}

class ResetAction extends Action
{
  public void executeAction()
  {
     System.out.println("Executing action: " + this.getActionName());
     choice = Choice.PAUSE;
     maze.initializeMaze();
  }
  
  String getActionName()
  {
     return "Reset";
  }
}


class SaveAction extends Action
{
  public void executeAction()
  {
     System.out.println("Executing action: " + this.getActionName());
     MazeSaver mSave = new MazeSaver();
     mSave.saveMaze();
  }
  
  String getActionName()
  {
     return "Save";
  }
  
  
}
