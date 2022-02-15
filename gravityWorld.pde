class GravityWorld {

  float gravity;

  ArrayList<MassObject> things;

  GravityWorld(float _gravity) {
    gravity = _gravity;

    things = new ArrayList<MassObject>();

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

    if (w) {
      gravity = gravity + 0.01;
      w = false;
    } else if (s) {
      gravity = gravity - 0.01;
      s = false;
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
    if (!trace) {
      background(0);
    }
    fill(255);
    textSize(30);
    textAlign(LEFT, TOP);
    text("gravity = " + gravity, 20, 20);
  }

  PVector calculateGravity(MassObject currentThing, MassObject thing) {
    PVector distanceVector = PVector.sub(thing.position, currentThing.position);
    float distanceMagnitude = distanceVector.mag();
    float forceMagnitude = gravity*currentThing.mass*thing.mass/sq(distanceMagnitude);
    return distanceVector.setMag(forceMagnitude);
  }
}
