# Nicholas McClellan
# CSCI 101 – Section A
# Python Lab 1B

##Originally I had made a car class, but that seemed a bit excessive.
time = 0.0;
acceleration = 0.0;
initialVel = 0.0
finalVel = 60.0;

print("Enter the time required for the car to reach 60 MPH, in seconds: ");
time = input("TIME> ");
acceleration = round((finalVel - initialVel) / (float(time)/3600));
print("The calculated acceleration of the car, in m/h^2: ");
print("OUTPUT", acceleration);
