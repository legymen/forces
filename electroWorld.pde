class ElectroWorld {

  float k_e; // electrostatic constant (Not the real one :-) )

  ArrayList<ElectroObject> things; // Arraylist for all the things

  boolean fieldOn, toggleFieldOn;

  ElectroWorld(float _k_e) {
    k_e = _k_e;

    things = new ArrayList<ElectroObject>();

    fieldOn = false;
    toggleFieldOn = false;

    background(0);
  }

  void run() {

    // Add a thing if mouse released, with speed as mouse dragged
    if (mReleased) {

      things.add(new ElectroObject(
        new PVector(mouseX, mouseY), 
        new PVector(0, 0), 
        new PVector(0, 0), 
        100, 
        10, 
        color(random(128, 255), random(128, 255), random(128, 255))));

      mReleased = false;
    }

    // Control electrostatic constant
    if (keysPressed.hasValue("w")) {
      gravity = k_e + 0.001;
    } else if (keysPressed.hasValue("s")) {
      k_e = gravity - 0.001;
    }

    // Toggle field on
    if (keysPressed.hasValue("t") && !toggleTracing){
      fieldOn = !fieldOn;
      toggleFieldOn = true;
    } else {
      toggleFieldOn = false;
    }

    // Render and update the world
    render();
    update();
  }

  void update() {

    // Apply gravity to all things
    for (ElectroObject currentThing : things) {
      for (ElectroObject thing : things) {
        if (currentThing != thing) {
          currentThing.applyForce(calculateElectrostaticForce(currentThing, thing));
        }
      }
    }

    // Run all things
    for (MassObject currentThing : things) {
      currentThing.run();
    }
  }

  void render() {

    // Render the dashboard with the k_e-value
    fill(50);
    rect(0, 0, 300, 70);
    fill(255);
    textSize(30);
    textAlign(LEFT, TOP);
    text("electrostatic constant = " + nf(k_e, 0, 3), 20, 20);
  }

  PVector calculateElectrostaticForce(ElectroObject currentThing, ElectroObject thing) {

    // CHANGE THIS!!! This is for gravity
    PVector distanceVector = PVector.sub(thing.position, currentThing.position);
    float distanceMagnitude = distanceVector.mag();
    float forceMagnitude = e_k*currentThing.mass*thing.mass/sq(distanceMagnitude);
    return distanceVector.setMag(forceMagnitude);
  }
}