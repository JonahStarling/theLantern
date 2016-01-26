//The Tree Class
//Creates a object that the player can destroy
//Functions include Constructors, Accessors, Mutators, and Colliders
class Tree {
    //Variables for the Tree Object/Class
    private float x;
    private float y;
    private int health;
    
    //The Basic Tree Constructor - Creates a tree with 2 health
    //@param x is the x location of the Tree Object
    //@param y is the y location of the Tree Object
    Tree(float x, float y) {
        this.x = x;
        this.y = y;
        this.health = 2;  
        redrawTree(); 
    }
    
    //The Custom Tree Constructor - Creates a tree with a certain health
    //@param x is the x location of the Tree Object
    //@param y is the y location of the Tree Object
    //@param health is the amount of health the Tree Object has
    Tree(float x, float y, int health) {
        this.x = x;
        this.y = y;
        this.health = health;  
        redrawTree(); 
    }
    
    //The redrawTree Function - Redraws the tree where it is
    void redrawTree() {
        image(fuelImage,this.x,this.y,20,20); //***** ADD A TREE IMAGE AND UPDATE THIS LINE TO REFLECT THE CHANGE ***** 
    }

    //The hitTree Function - Sees if the player has hit the tree with the axe yet
    //@param playerX is the x coordinate of the top left corner of the player
    //@param playerY is the y coordinate of the top left corner of the player
    //@param playerWidthX is the length of the player on the x coordinate
    //@param playerWidthY is the length of the player on the y coordinate
    //@return boolean that is true when the tree has no more health
    boolean hitTree(float playerX, float playerY, int playerWidthX, int playerWidthY) {
        //Checks the X coordinate first then the Y coordinate for speed and readability
        if (playerX > (this.x-playerWidthX) && playerX < (this.x + 20)) {
            if (playerY > (this.y-playerWidthY) && playerY < (this.y + 20)) {
                this.health--;
            }
        }
        if (this.health <= 0) {
            return true;
        } else {
            return false;
        }
    }
    
    //The checkCollision Function - Checks if the player has made a collision with the tree
    //@param playerX is the x coordinate of the top left corner of the player
    //@param playerY is the y coordinate of the top left corner of the player
    //@param playerWidthX is the length of the player on the x coordinate
    //@param playerWidthY is the length of the player on the y coordinate
    //@return boolean that is true when not colliding with a tree
    boolean checkCollision(float playerX, float playerY, int playerWidthX, int playerWidthY) {
        //Uses a nested if for readability
        //Could be combined to a single if
        //This if statement checks the X
        if (playerX >= (this.x-playerWidthX) && playerX <= (this.x + 20)) {
            //This if statement checks the Y
            if (playerY >= (this.y-playerWidthY) && playerY <= (this.y + 20)) {
                return false;
            }
        } 
        return true;
    }
    
    //The getX Function - Gives the X coordinate of the Tree
    //@returns the X location of the Tree
    float getX() {
        return this.x;   
    }
    
    //The getY Function - Gives the Y coordinate of the Tree
    //@returns the Y location of the Tree
    float getY() {
        return this.y;   
    }
    
    //The getHealth Function - Gives the amount of health the tree has
    //@returns the amount of health the tree has
    int getHealth() {
        return this.health;   
    }
}
//--- END OF Tree CLASS ---//