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
