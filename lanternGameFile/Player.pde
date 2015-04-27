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
    
    //The setX Function - Sets the X coordinate of the Player
    //@param x is the new x location
    void setX(int x) {
        this.x = x;
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
    
    //The setY Function - Sets the Y coordinate of the Player
    //@param y is the new y location
    void setY(int y) {
        this.y = y;
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
