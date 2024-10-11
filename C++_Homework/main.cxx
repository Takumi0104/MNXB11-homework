#include <iostream>
#include <string>
#include <cstdlib>
//cstdlib: defined in header to acsses to std::atoi

int computeChecksum(const std::string& input) {
    //initialize the checksum
    int checksum = 0;
    std::cout << "intialize the checksum \n"; 
//Use a range-based for-loop to calculate the checksum
    for (char ch : input){
        checksum += ch; //Add the ASCII value of each character to checksum

    } 
    return checksum;

    std::cout << "a range-based for-loop to calculate the checksum";
}

int main(int argumentCout, char *argumentValues[]){
//setting var0, var1
//booleans
//booleans variable is_a command check whether given value is true or not.
//example bool [variable] = true

    if(argumentCout >= 3){
        //Inform the users what the programming is doing
        std::cout << "The programming will compute a checksum based on the input arguments and compare it to the expect value.\n ";
        //Renaming variables with meaningful names
        std::string commandname{argumentValues[0]};
        //the name of the program(first argument)
        char  commandcharacter =*(argumentValues[1]);
        //first character of the second argument       
        int commandlength =commandname.size();
        //length of the program name 
        int expectedvalue = std::atoi(argumentValues[2]);
        //convert the third argument to an integer
        
        //Calculate the checksum using the new function
        std::string input{argumentValues[1]};
        //Second argument as string
        int checksum = computeChecksum(input);
        //Compute the checksum

    //Print what has been calculated
        std::cout << "Program name: " << commandname << std::endl;
        std::cout << "First character of the second argument: " << commandcharacter << std::endl;
        std::cout << "Length of the program name: " << commandlength << std::endl;
        std::cout << "Checksum of the second argument: " << checksum << std::endl;
        std::cout << "Expected value: " << expectedvalue << std::endl;
        

// var(variable): it indicates argument to main (e.g.var0,var1)
        if((checksum ^ (commandcharacter* 3)) << (commandlength & 0x1f) == expectedvalue){
            std::cout << "Correct!" << std::endl;
        } else {
            std::cout << "Wrong!" << std::endl;
        }
    
} else{
    std::cout << "Insufficient argument provided" << std::endl; //Error message if not enough arguments
}
return 0;//Indicate successful completion
}
//std::string
//dynamic array of char(similar to vector<char>)
//concatenation with + or +=
//single character access with [index]
//modifiable ("mutable") unlike in e.g., Python or Java
//regular,deeply copyable,deeply comparable
//(a group of things linked together or occuring together
//in a way that produces a particular result or effect)
//char,int: grouping data (aggrigate)
    //no control over interplay of constitute types
    //often be used as the variable in "string"
    //*:pointer 
//auto
//allows the compiler to automaticallydeduce the type of a variable from its initializer. 
//instead of explicity specifying the type, I can use auto.
//in Step3 we gonna change the auto to the actual type being used if we find that to be more readable



