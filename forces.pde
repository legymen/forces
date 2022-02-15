boolean mReleased;
PVector mVelocity;

StringList keysPressed; 

GravityWorld myGravityWorld;

void setup(){
    size(1200, 1000);

    mReleased = false;
    mVelocity = new PVector(0, 0);
    // trace = false;
    keysPressed = new StringList();

    myGravityWorld = new GravityWorld(0.03);
}

void draw(){
    myGravityWorld.run();
    keysPressed.clear();
}

void mouseReleased(){
    mReleased = true;
}

void mouseDragged(){
    mVelocity.x = mouseX - pmouseX;
    mVelocity.y = mouseY - pmouseY;
}

void keyPressed(){
    keysPressed.append(str(key));
}
