//The Player Class
//Creates a Player object that the user controls
//Functions include 4 Constructors, Accessors, Mutators, and more
class Player {
    //Variables for the Player Object/Class
    private float x;
    private float y;
    private int sizeX;
    private int sizeY;
    private int numOfCoins;
    private int direction;

    //The Default Player Constructor - Creates a Player with default values
    Player() {
        this.x = 0;
        this.y = 0;
        this.sizeX = 20;
        this.sizeY = 20;
        this.numOfCoins = 0;
        this.direction = 3;
        redrawPlayer();
    }

    //The Basic Player Constructor - Creates a Player with custom X and Y coordinates
    //@param x is the x coordinate of the top left corner of the player
    //@param y is the y coordinate of the top left corner of the player
    Player(float x, float y) {
        this.x = x;
        this.y = y;
        this.sizeX = 20;
        this.sizeY = 20;
        this.numOfCoins = 0;
        this.direction = 3;
        redrawPlayer();
    }

    //The Size Defined Player Constructor - Creates a Basic Player with a custom size
    //@param x is the x coordinate of the top left corner of the player
    //@param y is the y coordinate of the top left corner of the player
    //@param sizeX is the length of the player on the x coordinate plane
    //@param sizeY is the length of the player on the y coordinate plane
    Player(float x, float y, int sizeX, int sizeY) {
        this.x = x;
        this.y = y;
        this.sizeX = sizeX;
        this.sizeY = sizeY;
        this.numOfCoins = 0;
        this.direction = 3;
        redrawPlayer();
    }

    //The Handicapped Player Constructor - Creates a Size Player with a set number of coins
    //@param x is the x coordinate of the top left corner of the player
    //@param y is the y coordinate of the top left corner of the player
    //@param sizeX is the length of the player on the x coordinate plane
    //@param sizeY is the length of the player on the y coordinate plane
    //@param numOfCoins is the number of coins the player has
    Player(float x, float y, int sizeX, int sizeY, int numOfCoins) {
        this.x = x;
        this.y = y;
        this.sizeX = sizeX;
        this.sizeY = sizeY;
        this.numOfCoins = numOfCoins;
        this.direction = 3;
        redrawPlayer();
    }
    
    void updatePlayerAnimation(int i, PImage[] playerImages) {
        if (i > 24) {
            if (this.direction == 2) {
                image(playerImages[3], this.x, this.y, this.sizeX, this.sizeY);
            } else if (this.direction == 4) {
                image(playerImages[7], this.x, this.y, this.sizeX, this.sizeY);
            } else if (this.direction == 1) {
                image(playerImages[11], this.x, this.y, this.sizeX, this.sizeY);
            } else {
                image(playerImages[9], this.x, this.y, this.sizeX, this.sizeY);
            }
        } else if (i > 16) {
            if (this.direction == 2) {
                image(playerImages[2], this.x, this.y, this.sizeX, this.sizeY);
            } else if (this.direction == 4) {
                image(playerImages[6], this.x, this.y, this.sizeX, this.sizeY);
            } else if (this.direction == 1) {
                image(playerImages[11], this.x, this.y, this.sizeX, this.sizeY);
            } else {
                image(playerImages[9], this.x, this.y, this.sizeX, this.sizeY);
            }
        } else if (i > 8) {
            if (this.direction == 2) {
                image(playerImages[1], this.x, this.y, this.sizeX, this.sizeY);
            } else if (this.direction == 4) {
                image(playerImages[5], this.x, this.y, this.sizeX, this.sizeY);
            } else if (this.direction == 1) {
                image(playerImages[10], this.x, this.y, this.sizeX, this.sizeY);
            } else {
                image(playerImages[8], this.x, this.y, this.sizeX, this.sizeY);
            }
        } else {
            if (this.direction == 2) {
                image(playerImages[0], this.x, this.y, this.sizeX, this.sizeY);
            } else if (this.direction == 4) {
                image(playerImages[4], this.x, this.y, this.sizeX, this.sizeY);
            } else if (this.direction == 1) {
                image(playerImages[10], this.x, this.y, this.sizeX, this.sizeY);
            } else {
                image(playerImages[8], this.x, this.y, this.sizeX, this.sizeY);
            }
        }
    }
    
    //The checkHit Function - Checks if the player was hit by a bullet
    //@param bulletX is the x coordinate of the top left corner of the bullet
    //@param bulletY is the y coordinate of the top left corner of the bullet
    //@param bulletWidthX is the length of the bullet on the x coordinate
    //@param bulletWidthY is the length of the bullet on the y coordinate
    //@return boolean that is true when not hit by a bullet
    boolean checkHit(float bulletX, float bulletY, int bulletWidthX, int bulletWidthY) {
        //Uses a nested if for readability
        //Could be combined to a single if
        //This if statement checks the X
        if (bulletX >= (this.x-bulletWidthX) && bulletX <= (this.x + 20)) {
            //This if statement checks the Y
            if (bulletY >= (this.y-bulletWidthY) && bulletY <= (this.y + 20)) {
                //Player was hit by bullet
                return false;
            }
        } 
        return true;
    }

    //The getX Function - Gives the X coordinate of the Player
    //@returns the X location of the Player
    float getX() {
        return this.x;
    }
    
    //The setX Function - Sets the X coordinate of the Player
    //@param x is the new x location
    void setX(float x) {
        this.x = x;
    }
    
    //The moveX Function - Moves the X coordinate of the Player
    //@param distToMove is how far the player will move
    void moveX(float distToMove) {
        this.x += distToMove;    
    }

    //The getY Function - Gives the Y coordinate of the Player
    //@returns the Y location of the Player
    float getY() {
        return this.y;
    }
    
    //The setY Function - Sets the Y coordinate of the Player
    //@param y is the new y location
    void setY(float y) {
        this.y = y;
    }
    
    //The moveY Function - Moves the Y coordinate of the Player
    //@param distToMove is how far the player will move
    void moveY(float distToMove) {
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
    
    //The redrawPlayer Function - Redraws the Player object at its location
    void redrawPlayer() {
        fill(#0000FF);
        rect(this.x, this.y, this.sizeX, this.sizeY);   
    }
    
    //The changeDirection Function - Rotates the player to a specific direction
    //@param direction is the direction to be turned to
    void changeDirection(int direction) {
        this.direction = direction;   
    }
    
    //The getDirection Function - Returns to the user the current direction
    //@returns the current direction of the Player object
    int getDirection() {
        return this.direction;   
    }
    
    //The rotatePlayerLeft Function - Rotates the player once to the left
    void rotatePlayerLeft() {
        if (this.direction == 4) {
            this.direction = 1;   
        } else {
            this.direction++;   
        }
    }
    
    //The rotatePlayerRight Function - Rotates the player once to the right
    void rotatePlayerRight() {
        if (this.direction == 1) {
            this.direction = 4;   
        } else {
            this.direction--;   
        }   
    }
}
//--- END OF Player CLASS ---//