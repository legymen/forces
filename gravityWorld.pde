class GravityWorld {

  float gravity;

  ArrayList<MassObject> things;

  boolean tracing, toggleTracing;

  GravityWorld(float _gravity) {
    gravity = _gravity;

    things = new ArrayList<MassObject>();

    tracing = false;

    // Add a star
    things.add(new MassObject(
      new PVector(width/2, height/2), 
      new PVector(0, 0), 
      new PVector(0, 0), 
      100000, 
      100, 
      color(255, 255, 0)));

    background(0);
  }

  void run() {

    if (mReleased) {
      // Add a thing
      things.add(new MassObject(
        new PVector(mouseX, mouseY), 
        new PVector(mVelocity.x, mVelocity.y), 
        new PVector(0, 0), 
        100, 
        10, 
        color(random(128, 255), random(128, 255), random(128, 255))));

      mReleased = false;
    }

    if (keysPressed.hasValue("w")) {
      gravity = gravity + 0.001;
    } else if (keysPressed.hasValue("s")) {
      gravity = gravity - 0.001;
    }

    if (keysPressed.hasValue("t") && !toggleTracing){
      tracing = !tracing;
      toggleTracing = true;
    } else {
      toggleTracing = false;
    }

    render();
    update();
  }

  void update() {

    for (MassObject currentThing : things) {
      for (MassObject thing : things) {
        if (currentThing != thing) {
          currentThing.applyForce(calculateGravity(currentThing, thing));
        }
      }
    }

    for (MassObject currentThing : things) {
      currentThing.run();
    }
  }

  void render() {
    if (!tracing) {
      background(0);
    }

    fill(50);
    rect(0, 0, 300, 70);
    fill(255);
    textSize(30);
    textAlign(LEFT, TOP);
    text("gravity = " + nf(gravity, 0, 3), 20, 20);
  }

  PVector calculateGravity(MassObject currentThing, MassObject thing) {
    PVector distanceVector = PVector.sub(thing.position, currentThing.position);
    float distanceMagnitude = distanceVector.mag();
    float forceMagnitude = gravity*currentThing.mass*thing.mass/sq(distanceMagnitude);
    return distanceVector.setMag(forceMagnitude);
  }
}
