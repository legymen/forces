

void arduinoSetup(){

    leftSpeed = 0;
    rightSpeed = 0;

}

void arduinoLoop(){
    leftSpeed = constrain(leftSpeed, 0, 100);
    rightSpeed = constrain(rightSpeed, 0, 100);

    
    robyn.drive(leftSpeed, rightSpeed);
}