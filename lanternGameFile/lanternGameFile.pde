import java.util.Random;

//Creating variables and objects to be used in game
int i, x, y;
Coin coin001;
Enemy enemy001;
Player player001;
ArrayList<WallRect> walls;

void setup() {
    //Setting up the settings
    size(200, 200);
    frameRate(8);
    noCursor();
    //Drawing the background
    fill(#888888);
    rect(0, 0, 200, 200);
    //Creates grid lines for debugging and testing
    fill(#000000);
    for (int i = 10; i != 200; i+=10) {
        line(i, 0, i, 200);
    }
    for (int i = 10; i != 200; i+=10) {
        line(0, i, 200, i);
    }
    //ArrayList of WallRect objects
    walls = new ArrayList<WallRect>();
    //Build the horizontal walls
    for (int i = 0; i != 5; i++) {
        walls.add(new WallRect(randInt(0, 190, 10), randInt(0, 190, 10), randInt(10, 190, 10), 10));
    }
    //Build the vertical walls
    for (int i = 0; i != 5; i++) {
        walls.add(new WallRect(randInt(0, 190, 10), randInt(0, 190, 10), 10, randInt(10, 190, 10)));
    }
    //Creating a new Coin Object
    coin001 = new Coin(randInt(0, 190, 10), randInt(0, 190, 10));
    //Drawing the Player
    player001 = new Player(0,0,10,10,0);
    //Creating a new Enemy Object
    enemy001 = new Enemy(100, 100);
    i = 0;
    x = player001.getX();
    y = player001.getY();
}


//The draw Function - This loop is like the main
//Built in with processing
//It is run however many times frames per second is set to
void draw() {
    //Gets location of player
    x = player001.getX();
    y = player001.getY();
    //Looks to see if a key is pressed then sees what key
    if (keyPressed) {
        //Normal key presses
        if (key == 'w') {
            if (checkAllCollisions(x, y, 1, 0) != 1) {
                player001.moveY(-10);
            }
        } else if (key == 'a') {
            if (checkAllCollisions(x, y, 2, 0) != 2) {
                player001.moveX(-10);
            }
        } else if (key == 's') {
            if (checkAllCollisions(x, y, 3, 0) != 3) {
                player001.moveY(10);
            }
        } else if (key == 'd') {
            if (checkAllCollisions(x, y, 4, 0) != 4) {
                player001.moveX(10);
            }
            //Jump key presses
        } else if (key == 'i') {
            if (checkAllCollisions(x, y, 5, 0) != 5) {
                player001.moveY(-20);
            }
        } else if (key == 'j') {
            if (checkAllCollisions(x, y, 6, 0) != 6) {
                player001.moveX(-20);
            }
        } else if (key == 'k') {
            if (checkAllCollisions(x, y, 7, 0) != 7) {
                player001.moveY(20);
            }
        } else if (key == 'l') {
            if (checkAllCollisions(x, y, 8, 0) != 8) {
                player001.moveX(20);
            }
        }
        //Checking on the coin
        if (!coin001.found && coin001.pickedUp(x, y, 10, 10)) {
            player001.addCoins(1);
            println(player001.getNumOfCoins());
        }
    } 
    //Refreshing the board
    fill(#0000FF);
    refreshBoard();
    //Redrawing the player
    player001.redrawPlayer();
    //This allows the Enemy to move only once every 4 frames (twice a second)
    if (i == 4) {
        enemy001.moveTowardsPlayer(x, y);
        i = 0;
    } else {
        enemy001.redrawEnemy();
    }
    i++;
}







//The WallRect Class
//This class creates wall objects
//Functions include two constructors, colliders, and redraw
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
        rect(x, y, sizeX, sizeY);
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
    //@return boolean that is true when not colliding with a wall
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

    //The redrawWall Function - Redraws the Wall
    void redrawWall() {
        rect(this.x, this.y, this.sizeX, this.sizeY);
    }
}
//--- END OF WallRect CLASS ---//







//The Coin Class
//Creates a coin object that can be picked up by the player of the game
//Functions include a constructor, redraw, and a Coin pickup detection
class Coin {
    //Variables for the Coin Object/Class
    private int x;
    private int y;
    public boolean found;

    //The Coin Constructor - Creates a normal Coin Object
    //@param x is the x location of the top left corner of the Coin
    //@param y is the y location of the top left corner of the Coin
    Coin(int x, int y) {
        this.x = x;
        this.y = y;
        //Loops through all of the walls
        for (int i = 0; i < walls.size (); i++) {
            //Checks to see if the coin is stuck in a wall
            if (!walls.get(i).checkCollision(this.x, this.y, 10, 10)) {
                //If so then when change its location and try again
                this.x = randInt(0, 190, 10);
                this.y = randInt(0, 190, 10);
                i = 0;
            }
        }
        this.found = false;
        //Draws the Coin
        fill(#FFFF00);
        rect(x, y, 10, 10);
    } 

    //The redrawCoin Function - Redraws the Coin
    void redrawCoin() {
        //Only redraws the coin if it hasn't been found
        if (!this.found) {
            fill(#FFFF00);
            rect(this.x, this.y, 10, 10);
        }
    }

    //The pickedUp Function - Sees if the player has picked up the coin yet
    //@param playerX is the x coordinate of the top left corner of the player
    //@param playerY is the y coordinate of the top left corner of the player
    //@param playerWidthX is the length of the player on the x coordinate
    //@param playerWidthY is the length of the player on the y coordinate
    //@return boolean that is true when the player picks up the coin
    boolean pickedUp(int playerX, int playerY, int playerWidthX, int playerWidthY) {
        //Checks the X coordinate first then the Y coordinate for speed and readability
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







//The Player Class
//Creates a Player object that the user controls
//Functions include 4 Constructors, Accessors, Mutators, and more
class Player {
    //Variables for the Player Object/Class
    private int x;
    private int y;
    private int sizeX;
    private int sizeY;
    private int numOfCoins;

    //The Default Player Constructor - Creates a Player with default values
    Player() {
        this.x = 0;
        this.y = 0;
        this.sizeX = 10;
        this.sizeY = 10;
        this.numOfCoins = 0;
        redrawPlayer();
    }

    //The Basic Player Constructor - Creates a Player with custom X and Y coordinates
    //@param x is the x coordinate of the top left corner of the player
    //@param y is the y coordinate of the top left corner of the player
    Player(int x, int y) {
        this.x = x;
        this.y = y;
        this.sizeX = 10;
        this.sizeY = 10;
        this.numOfCoins = 0;
        redrawPlayer();
    }

    //The Size Defined Player Constructor - Creates a Basic Player with a custom size
    //@param x is the x coordinate of the top left corner of the player
    //@param y is the y coordinate of the top left corner of the player
    //@param sizeX is the length of the player on the x coordinate plane
    //@param sizeY is the length of the player on the y coordinate plane
    Player(int x, int y, int sizeX, int sizeY) {
        this.x = x;
        this.y = y;
        this.sizeX = sizeX;
        this.sizeY = sizeY;
        this.numOfCoins = 0;
        redrawPlayer();
    }

    //The Handicapped Player Constructor - Creates a Size Player with a set number of coins
    //@param x is the x coordinate of the top left corner of the player
    //@param y is the y coordinate of the top left corner of the player
    //@param sizeX is the length of the player on the x coordinate plane
    //@param sizeY is the length of the player on the y coordinate plane
    //@param numOfCoins is the number of coins the player has
    Player(int x, int y, int sizeX, int sizeY, int numOfCoins) {
        this.x = x;
        this.y = y;
        this.sizeX = sizeX;
        this.sizeY = sizeY;
        this.numOfCoins = numOfCoins;
        redrawPlayer();
    }

    //The getX Function - Gives the X coordinate of the Player
    //@returns the X location of the Player
    int getX() {
        return this.x;
    }
    
    //The moveX Function - Moves the X coordinate of the Player
    //@param distToMove is how far the player will move
    void moveX(int distToMove) {
        this.x += distToMove;    
    }

    //The getY Function - Gives the Y coordinate of the Player
    //@returns the Y location of the Player
    int getY() {
        return this.y;
    }
    
    //The moveY Function - Moves the Y coordinate of the Player
    //@param distToMove is how far the player will move
    void moveY(int distToMove) {
        this.y += distToMove;    
    }

    //The getSizeX Function - Gives the X length of the Player
    //@returns the size of the player on the X coordinate plane
    int getSizeX() {
        return this.sizeX;
    }

    //The getSizeY Function - Gives the Y length of the Player
    //@returns the size of the player on the Y coordinate plane
    int getSizeY() {
        return this.sizeY;
    }

    //The getNumOfCoins Function - Gives the number of coins the Player has
    //@returns the number of coins the player currently has
    int getNumOfCoins() {
        return this.numOfCoins;
    }

    //The addCoins Function - Adds a number of coins to the total
    //@param coinsToAdd is the number of coins to add to the total
    void addCoins(int coinsToAdd) {
        this.numOfCoins += coinsToAdd;
    }

    //The subtractCoins Function - Subtracts a number of coins from the total
    //@param coinsToSubtract is the number of coins to subtract from the total
    void subtractCoins(int coinsToSubtract) {
        this.numOfCoins -= coinsToSubtract;
    }
    
    void redrawPlayer() {
        fill(#0000FF);
        rect(this.x, this.y, this.sizeX, this.sizeY);   
    }
}
//--- END OF Player CLASS ---//







//The Enemy Class
//Creates and Enemy AI object to interact with
//Functions include two constructors, movement, and redraw
class Enemy {
    //Variables for the Enemy Object/Class
    private int x;
    private int y;
    private int speed;

    //The Basic Enemy Constructor - Creates an Enemy object with default speed
    //@param x is the x location of the Enemy Object
    //@param y is the y location of the Enemy Object
    Enemy(int x, int y) {
        this.x = x;
        this.y = y;
        //Loops through all of the walls
        for (int i = 0; i < walls.size (); i++) {
            //Checks to see if the enemy is stuck in a wall
            if (!walls.get(i).checkCollision(this.x, this.y, 10, 10)) {
                //If so then when change its location and try again
                this.x = randInt(0, 190, 10);
                this.y = randInt(0, 190, 10);
                i = 0;
            }
        }
        this.speed = 10;
        fill(#FF0000);
        rect(this.x, this.y, 10, 10);
    }

    //The Speed Enemy Constructor - Creates an Enemy object with custom speed
    //@param x is the x location of the Enemy Object
    //@param y is the y location of the Enemy Object
    //@param speed is how fast the Enemy Object moves
    Enemy(int x, int y, int speed) {
        this.x = x;
        this.y = y;
        //Loops through all of the walls
        for (int i = 0; i < walls.size (); i++) {
            //Checks to see if the enemy is stuck in a wall
            if (!walls.get(i).checkCollision(this.x, this.y, 10, 10)) {
                //If so then when change its location and try again
                this.x = randInt(0, 190, 10);
                this.y = randInt(0, 190, 10);
                i = 0;
            }
        }
        this.speed = speed;
        fill(#FF0000);
        rect(this.x, this.y, 10, 10);
    }

    //The redrawEnemy Function - Redraws the Enemy
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
    rect(0, 0, 200, 200);
    fill(#000000);
    //Redrawing the horizontal lines
    for (int i = 10; i != 200; i+=10) {
        line(i, 0, i, 200);
    }
    //Redrawing the vertical lines
    for (int i = 10; i != 200; i+=10) {
        line(0, i, 200, i);
    }
    //Redrawing the walls
    for (int i = 0; i < walls.size (); i++) {
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
    case 1: 
        y -= 9; 
        break;
    case 2: 
        x -= 9;
        break;
    case 3: 
        y += 9;
        break;
    case 4: 
        x += 9;
        break;
        //Jumping
    case 5: 
        y -= 20;
        break;
    case 6: 
        x -= 20;
        break;
    case 7: 
        y += 20;
        break;
    case 8: 
        x += 20;
        break;
    }
    //Loops through the walls to get the collision
    for (int i = 0; i < walls.size (); i++) {
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

