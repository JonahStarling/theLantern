import java.util.Random;

int x, y, coins, i;
WallRect wall001,wall002,wall003,wall004,wall005,wall006,wall007,wall008,wall009,wall010;
Coin coin001;
Enemy enemy001;
ArrayList<WallRect> walls;

void setup() {
   x = 0;
   y = 0;
   coins = 0;
   size(200,200);
   frameRate(8);
   //noCursor();
   fill(#888888);
   rect(0,0,200,200);
   fill(#000000);
   for (int i = 10; i != 200; i+=10) {
     line(i,0,i,200);
   }
   for (int i = 10; i != 200; i+=10) {
     line(0,i,200,i);
   }
   //ArrayList of WallRect objects
   walls = new ArrayList<WallRect>();
   //Build the horizontal walls
   for (int i = 0; i != 5; i++) {
       walls.add(new WallRect(randInt(0,190,10),randInt(0,190,10),randInt(10,190,10),10));
   }
   //Build the vertical walls
   for (int i = 0; i != 5; i++) {
       walls.add(new WallRect(randInt(0,190,10),randInt(0,190,10),10,randInt(10,190,10)));
   }
   coin001 = new Coin(randInt(0,190,10),randInt(0,190,10));
   fill(#0000FF);
   rect(x,y,10,10);
   enemy001 = new Enemy(100,100);
   i = 0;
}



void draw() {
  if (keyPressed) {
    if (key == 'w') {
      if (checkAllCollisions(x,y,1,0) != 1) {
        fill(#0000FF);
        y-=10;
        //refreshBoard();
        //rect(x,y,10,10);
      }
    } else if (key == 'a') {
      if (checkAllCollisions(x,y,2,0) != 2) {
        fill(#0000FF);
        x-=10;
        //refreshBoard();
        //rect(x,y,10,10);
      }
    } else if (key == 's') {
      if (checkAllCollisions(x,y,3,0) != 3) {
        fill(#0000FF);
        y+=10;
        //refreshBoard();
        //rect(x,y,10,10);
      }
    } else if (key == 'd') {
      if (checkAllCollisions(x,y,4,0) != 4) {
        fill(#0000FF);
        x+=10;
        //refreshBoard();
        //rect(x,y,10,10);
      }
    } else if (key == 'i') {
      if (checkAllCollisions(x,y,5,0) != 5) {
        fill(#0000FF);
        y-=20;
        //refreshBoard();
        //rect(x,y,10,10);
      }
    } else if (key == 'j') {
      if (checkAllCollisions(x,y,6,0) != 6) {
        fill(#0000FF);
        x-=20;
        //refreshBoard();
        //rect(x,y,10,10);
      }
    } else if (key == 'k') {
      if (checkAllCollisions(x,y,7,0) != 7) {
        fill(#0000FF);
        y+=20;
        //refreshBoard();
        //rect(x,y,10,10);
      }
    } else if (key == 'l') {
      if (checkAllCollisions(x,y,8,0) != 8) {
        fill(#0000FF);
        x+=20;
        //refreshBoard();
        
      }
    }
    if (!coin001.found && coin001.pickedUp(x,y,10,10)) {
       coins++;
       println(coins); 
    } 
  } 
  
  fill(#0000FF);
  refreshBoard();
  rect(x,y,10,10);
  if (i == 4) {
    enemy001.moveTowardsPlayer(x,y);
    i = 0;
  } else {
    enemy001.redrawEnemy();
  }
  i++;
}







//The WallRect Class
//This class creates wall objects
//Functions include two constructors, colliders, and more to be made in the future
class WallRect {
   //Variables for the WallRect Object/Class
   public int x;
   public int y;
   public int sizeX;
   public int sizeY;
   
   //The Normal Wall Constructr - Uses the rect function to draw the wall
   //@param x is the x coordinate of the top left corner
   //@param y is the y coordinate of the top left corner
   //@param sizeX is the length of the wall on the X axis
   //@param sizeY is the length of the wall on the Y axis
   public WallRect(int x, int y, int sizeX, int sizeY) {
     this.x = x;
     this.y = y;
     this.sizeX = sizeX;
     this.sizeY = sizeY;
     fill(#000000);
     rect(x,y,sizeX,sizeY);
   } 
   
   //The Image Wall Constructor - Uses the imgage function to draw the wall
   //@param x is the x coordinate of the top left corner
   //@param y is the y coordinate of the top left corner
   //@param sizeX is the length of the wall on the X axis
   //@param sizeY is the length of the wall on the Y axis
   //@param imgName is the name of the image to be used for the wall
   public WallRect(int x, int y, int sizeX, int sizeY, String imgName) {
     this.x = x;
     this.y = y;
     this.sizeX = sizeX;
     this.sizeY = sizeY;
     //Since we are using an image, it is best that sizeX and sizeY do one of the following:
     // - Match the original dimensions of the image
     // - Proportional to the original dimensions
     //This prevents distortion of the image
     image(loadImage(imgName), x, y, sizeX, sizeY);
   }
   
   //The checkCollision Function - Checks if the player has made a collision with the wall
   //@param playerX is the x coordinate of the top left corner of the player
   //@param playerY is the y coordinate of the top left corner of the player
   //@param playerWidthX is the length of the player on the x coordinate
   //@param playerWidthY is the length of the player on the y coordinate
   //@param playerDirection is the direction that the player is facing
   //@param noCollision is the value to return if the player does not collide with the wall
   //@return playerDirection is returned so the program knows which way the player can not go
   boolean checkCollision(int playerX, int playerY, int playerWidthX, int playerWidthY) {
      //Uses a nested if for readability
      //Could be combined to a single if
      //This if statement checks the X
      if (playerX > (this.x-playerWidthX) && playerX < (this.x + this.sizeX)) {
         //This if statement checks the Y
         if (playerY > (this.y-playerWidthY) && playerY < (this.y + this.sizeY)) {
            //Returns the direction that the player is facing
            return false;
         }
      } 
      return true;
   }
   
   void redrawWall() {
      rect(this.x,this.y,this.sizeX,this.sizeY);
   }
}
//--- END OF WallRect CLASS ---//







//The Coin Class
//Creates a coin object that can be picked up by the player of the game
class Coin {
   private int x;
   private int y;
   public boolean found;
   Coin(int x, int y) {
      this.x = x;
      this.y = y;
      this.found = false;
      fill(#FFFF00);
      rect(x,y,10,10);
   } 
   
   void redrawCoin() {
      if (!this.found) {
        fill(#FFFF00);
        rect(this.x,this.y,10,10);
      }
   }
   
   boolean pickedUp(int playerX, int playerY, int playerWidthX, int playerWidthY) {
      if (playerX > (this.x-playerWidthX) && playerX < (this.x + 10)) {
         if (playerY > (this.y-playerWidthY) && playerY < (this.y + 10)) {
            this.found = true;
            return true;
         }
      } 
      return false;
   }
}
//--- END OF Coin CLASS ---//

  





//The Enemy Class
class Enemy {
  private int x;
  private int y;
  private int speed;
  Enemy(int x, int y) {
    this.x = x;
    this.y = y;
    this.speed = 10;
    fill(#FF0000);
    rect(this.x, this.y, 10, 10);
  }
  
  Enemy(int x, int y, int speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    fill(#FF0000);
    rect(this.x, this.y, 10, 10);
  }
  
  //The redrawEnemy Function - Redraws the enemy
  void redrawEnemy() {
    fill(#FF0000);
    rect(this.x, this.y, 10, 10);
  }
  
  //The moveTowardsPlayer Function - Decides where the enemy AI should move next
  //@param playerX is the x location of the player
  //@param playerY is the y location of the player
  void moveTowardsPlayer(int playerX, int playerY) {
     //Finds the difference between the player's location and its own
     int diffX = playerX - this.x;
     int diffY = playerY - this.y;
     //Finds out which difference is bigger
     if (abs(diffX) > abs(diffY)) {
         //If the diffX is positive then the player is to the right
         if (diffX > 0) {
           //Before we move we check the collisions
           if (checkAllCollisions(this.x, this.y, 4, 0) != 4) {
              this.x += 10; 
           }
         //If the diffX is negative then the player is to the left
         } else {
           //Before we move we check the collisions
           if (checkAllCollisions(this.x, this.y, 2, 0) != 2) {
              this.x -= 10;
           }
         }
     } else {
         //If the diffY is positive then the player is below
         if (diffY > 0) {
           //Before we move we check the collisions
           if (checkAllCollisions(this.x, this.y, 3, 0) != 3) {
              this.y += 10; 
           }
         //If the diffY is negative then the player is above
         } else {
           //Before we move we check the collsions
           if (checkAllCollisions(this.x, this.y, 1, 0) != 1) {
              this.y -= 10;
           }
         }
     }
     //Then we redraw the Enemy AI
     redrawEnemy();
  }
}
//--- END OF Enemy CLASS ---//







//The randInt Function - Gets a random int between max and min
//@param min is the smallest number that can be picked
//@param max is the largest number that can be picked
//@return randomNum is an integer between min and max
int randInt(int min, int max) {
    Random rand = new Random();
    int randomNum = rand.nextInt((max - min) + 1) + min;
    return randomNum;
}



//The randInt Function - Gets a random int between max and min on an interval
//Example: The parameters 11,49,10 could give you 10,20,30,40
//The bottom and top number are rounded down and inclusive of both ends
//It rounds down to the nearest number divisible by the interval
//@param min is the bottom number (may be rounded down)
//@param max is the top number (may be rounded down)
//@param interval is the number to skip by
//@return randomNum generated by the algorithm
int randInt(int min, int max, int interval) {
    Random rand = new Random();
    int randomNum = (rand.nextInt((max/interval - min/interval) + 1) + min/interval) * interval;
    return randomNum;
}



//The refreshBoard Function - Redraws the map
void refreshBoard() {
   //Redrawing the background
   fill(#888888);
   rect(0,0,200,200);
   fill(#000000);
   //Redrawing the horizontal lines
   for (int i = 10; i != 200; i+=10) {
     line(i,0,i,200);
   }
   //Redrawing the vertical lines
   for (int i = 10; i != 200; i+=10) {
     line(0,i,200,i);
   }
   //Redrawing the walls
   for(int i = 0; i < walls.size(); i++) {
     walls.get(i).redrawWall();
   }
   //Redrawing the coins
   coin001.redrawCoin();
   fill(#0000FF);
}



//The checkAllCollisions Function - Checks collision with all walls and bounds
//@param x is the current x location of the player
//@param y is the current y location of the player
//@param direction is the way the player is trying to walk
//@param noCollision is the value to return if no collisions are detected
//@return collision is the direction of the collision or the noCollision default
int checkAllCollisions(int x, int y, int direction, int noCollision) {
   int collision = noCollision;
   //Updates the movement values to see whether the step you want to take is ok
   switch(direction) {
      //Normal stepping
      case 1: y -= 9; 
              break;
      case 2: x -= 9;
              break;
      case 3: y += 9;
              break;
      case 4: x += 9;
              break;
      //Jumping
      case 5: y -= 20;
              break;
      case 6: x -= 20;
              break;
      case 7: y += 20;
              break;
      case 8: x += 20;
              break;
   }
   //Loops through the wallsto get the collision
   for(int i = 0; i < walls.size(); i++) {
     if (!walls.get(i).checkCollision(x, y, 10, 10)) {
       collision = direction;
     }
   }
   //Checks collision with the boundaries
   if (x < 0) {
     collision = direction;  
   } else if (y < 0) {
     collision = direction;  
   } else if (x > 190) {
     collision = direction;  
   } else if (y > 190) {
     collision = direction;  
   }
   return collision;
}
