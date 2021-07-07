
enum Type{
   WALL, 
   PATH
}

class Cell{
  
    boolean visited;
    Type type;
    //Integer [] pos;      //sure might end up with redundancy
    Cell()
    {
      
    }
    
    Cell(int x, int y, Type t)
    {
      //pos = new Integer[2];
      //pos[0] = x;
      //pos[1] = y;
      type = t;
      visited  = false;
    }
    
}
