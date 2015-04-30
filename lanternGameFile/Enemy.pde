//The Enemy Class
//Creates and Enemy AI object to interact with
//Functions include two constructors, movement, and redraw
class Enemy {
    //Variables for the Enemy Object/Class
    private float x;
    private float y;
    private int speed;
    private int health;

    //The Basic Enemy Constructor - Creates an Enemy object with default speed
    //@param x is the x location of the Enemy Object
    //@param y is the y location of the Enemy Object
    Enemy(float x, float y) {
        this.x = x;
        this.y = y;
        //Loops through all of the walls
        for (int i = 0; i < walls.size (); i++) {
            //Checks to see if the enemy is stuck in a wall
            if (!walls.get(i).checkCollision(this.x, this.y, 5, 5)) {
                //If so then when change its location and try again
                this.x = randInt(0, 190, 10);
                this.y = randInt(0, 190, 10);
                i = 0;
            }
        }
        this.speed = 10;
        this.health = 1;
        fill(#FF0000);
        rect(this.x, this.y, 5, 5);
    }

    //The Speed Enemy Constructor - Creates an Enemy object with custom speed
    //@param x is the x location of the Enemy Object
    //@param y is the y location of the Enemy Object
    //@param speed is how fast the Enemy Object moves
    Enemy(float x, float y, int speed) {
        this.x = x;
        this.y = y;
        //Loops through all of the walls
        for (int i = 0; i < walls.size (); i++) {
            //Checks to see if the enemy is stuck in a wall
            if (!walls.get(i).checkCollision(this.x, this.y, 5, 5)) {
                //If so then when change its location and try again
                this.x = randInt(0, 190, 10);
                this.y = randInt(0, 190, 10);
                i = 0;
            }
        }
        this.speed = speed;
        this.health = 1;
        fill(#FF0000);
        rect(this.x, this.y, 5, 5);
    }
    
    //The Health Enemy Constructor - Creates an Enemy object with a set health
    //@param x is the x location of the Enemy Object
    //@param y is the y location of the Enemy Object
    //@param speed is how fast the Enemy Object moves
    //@param health is how many bullets it takes to kill the Enemy
    Enemy(float x, float y, int speed, int health) {
        this.x = x;
        this.y = y;
        //Loops through all of the walls
        for (int i = 0; i < walls.size (); i++) {
            //Checks to see if the enemy is stuck in a wall
            if (!walls.get(i).checkCollision(this.x, this.y, 5, 5)) {
                //If so then when change its location and try again
                this.x = randInt(0, 190, 10);
                this.y = randInt(0, 190, 10);
                i = 0;
            }
        }
        this.speed = speed;
        this.health = health;
        fill(#FF0000);
        rect(this.x, this.y, 5, 5);
    }

    //The redrawEnemy Function - Redraws the Enemy
    void redrawEnemy() {
        fill(#FF0000);
        rect(this.x, this.y, 5, 5);
    }

    //The moveTowardsPlayer Function - Decides where the enemy AI should move next
    //@param playerX is the x location of the player
    //@param playerY is the y location of the player
    void moveTowardsPlayer(float playerX, float playerY) {
        //Finds the difference between the player's location and its own
        float diffX = playerX - this.x;
        float diffY = playerY - this.y;
        //Finds out which difference is bigger
        if (abs(diffX) > abs(diffY)) {
            //If the diffX is positive then the player is to the right
            if (diffX > 0) {
                //Before we move we check the collisions
                if (checkAllCollisions(this.x, this.y, 4, 0) != 4) {
                    this.x += .5;
                }
                //If the diffX is negative then the player is to the left
            } else {
                //Before we move we check the collisions
                if (checkAllCollisions(this.x, this.y, 2, 0) != 2) {
                    this.x -= .5;
                }
            }
        } else {
            //If the diffY is positive then the player is below
            if (diffY > 0) {
                //Before we move we check the collisions
                if (checkAllCollisions(this.x, this.y, 3, 0) != 3) {
                    this.y += .5;
                }
                //If the diffY is negative then the player is above
            } else {
                //Before we move we check the collsions
                if (checkAllCollisions(this.x, this.y, 1, 0) != 1) {
                    this.y -= .5;
                }
            }
        }
        //Then we redraw the Enemy AI
        redrawEnemy();
    }
    
    //The getX Function - Gives the X coordinate of the Enemy
    //@returns the X location of the Enemy
    float getX() {
        return this.x;
    }
    
    //The moveX Function - Moves the X coordinate of the Enemy
    //@param distToMove is how far the enemy will move
    void moveX(float distToMove) {
        this.x += distToMove;    
    }

    //The getY Function - Gives the Y coordinate of the Enemy
    //@returns the Y location of the Enemy
    float getY() {
        return this.y;
    }
    
    //The moveY Function - Moves the Y coordinate of the Enemy
    //@param distToMove is how far the enemy will move
    void moveY(float distToMove) {
        this.y += distToMove;    
    }
    
    //The getHealth Function - Returns to the user the Enemy health
    //@returns the current health of the Enemy Object
    int getHealth() {
        return this.health;   
    }
    
    //The setHealth Function - Sets the health of an Enemy Object
    //@param health is the new health of the Enemy Object
    void setHealth(int health) {
         this.health = health;   
    }
}
//--- END OF Enemy CLASS ---//
