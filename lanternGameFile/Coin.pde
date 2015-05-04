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
            if (!walls.get(i).checkCollision(this.x, this.y, 20, 20)) {
                //If so then when change its location and try again
                this.x = randInt(0, 780, 20);
                this.y = randInt(0, 780, 20);
                i = 0;
            }
        }
        this.found = false;
        //Draws the Coin
        fill(#FFFF00);
        rect(x, y, 20, 20);
    } 

    //The redrawCoin Function - Redraws the Coin
    void redrawCoin() {
        //Only redraws the coin if it hasn't been found
        if (!this.found) {
            fill(#FFFF00);
            rect(this.x, this.y, 20, 20);
        }
    }

    //The pickedUp Function - Sees if the player has picked up the coin yet
    //@param playerX is the x coordinate of the top left corner of the player
    //@param playerY is the y coordinate of the top left corner of the player
    //@param playerWidthX is the length of the player on the x coordinate
    //@param playerWidthY is the length of the player on the y coordinate
    //@return boolean that is true when the player picks up the coin
    boolean pickedUp(float playerX, float playerY, int playerWidthX, int playerWidthY) {
        //Checks the X coordinate first then the Y coordinate for speed and readability
        if (playerX > (this.x-playerWidthX) && playerX < (this.x + 20)) {
            if (playerY > (this.y-playerWidthY) && playerY < (this.y + 20)) {
                this.found = true;
                return true;
            }
        } 
        return false;
    }
    
    //The getX Function - Gives the X coordinate of the Coin
    //@returns the X location of the Coin
    int getX() {
        return this.x;
    }
    
    //The moveX Function - Moves the X coordinate of the Coin
    //@param distToMove is how far the coin will move
    void moveX(int distToMove) {
        this.x += distToMove;    
    }

    //The getY Function - Gives the Y coordinate of the Coin
    //@returns the Y location of the Coin
    int getY() {
        return this.y;
    }
    
    //The moveY Function - Moves the Y coordinate of the Coin
    //@param distToMove is how far the coin will move
    void moveY(int distToMove) {
        this.y += distToMove;    
    }
    
    //The getFound Function - Gives whether or not the Coin is found
    //@returns if the coin has been found yet
    boolean getFound() {
        return this.found;
    }
}
//--- END OF Coin CLASS ---//
