boolean mReleased;
PVector mVelocity;

boolean trace;
boolean w;
boolean s;

GravityWorld myGravityWorld;

void setup(){
    size(1200, 1000);

    mReleased = false;
    mVelocity = new PVector(0, 0);
    trace = false;

    myGravityWorld = new GravityWorld(0.03);
}

void draw(){
    myGravityWorld.run();
}

void mouseReleased(){
    mReleased = true;
}

void mouseDragged(){
    mVelocity.x = mouseX - pmouseX;
    mVelocity.y = mouseY - pmouseY;
}

void keyPressed(){
    switch (key){
        case 't':
        trace = !trace;
        break;

        case 'w':
        w = true;
        break;

        case 's':
        s = true;
        break;
    }
}
