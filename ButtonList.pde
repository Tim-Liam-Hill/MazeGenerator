

class ButtonList{
  
    ArrayList<Button> list;
    final int xOffset = 100;
    final int buttonLength = 120; 
    final int buttonHeight = 60;
  
   ButtonList(int buttonSpacing, int yBegin)
   {  
     Action [] actions = {new RunAction(), new StepAction(), new PauseAction(), new ResetAction(), new SaveAction()};
     color [] colors = {color(255,0,0), color(0,255,0), color(0,0,255), color(100, 100, 150), color(0,20,80)};
     list = new ArrayList<Button>();
     
     for(int i=0; i<actions.length; ++i)
     {
       list.add(new Button(xOffset + i*buttonLength+ (i-1)*buttonSpacing, yBegin, buttonLength, buttonHeight, colors[i], actions[i]));
     }
   }
   
   void checkForButtonClick()
   {
       for(int i=0; i<list.size(); ++i)
       {
         if(list.get(i).isClicked())
           {
             list.get(i).onClick();
             break;
           }
       }
   }
   
   void printButtons()
   {
       for(int i=0; i<list.size(); ++i)
          list.get(i).print();
   }
  
}
