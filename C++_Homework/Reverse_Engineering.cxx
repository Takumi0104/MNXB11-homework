#include <iostream>
#include<string>

int main(int var0, char *var1[]){
    //char,int: grouping data (aggrigate)
    //no control over interplay of constitute types
    //often be used as the variable in "string"
    //*:pointer 
    if(var0 == 3){
        //
        std::string var2{var1[0]};
        auto var3{*(var1[1])};      
        auto var4{var2.size()};
        auto var5{std::atoi(var1[2])};
        auto var6{0};
        auto var7{0};
        std::string var8{var1[1]};
        while (true) {
            var6 += var8[var7++];
            if (var7 >= static_cast<int>(var8.size())){
                break;
            }
        }
        if((var6 ^ var3 * 3) <<(var4 & 0x1f) == var5){
            std::cout << "Correct!" << std::endl;
        } else{
            std::cout << "Wrong!" << std::endl;
        }
    }
}
//std::string
//dynamic array of char(similar to vector<char>)
//concatenation with + or +=
//single character access with [index]
//modifiable ("mutable") unlike in e.g., Python or Java
//regular,deeply copyable,deeply comparable
//(a group of things linked together or occuring together
//in a way that produces a particular result or effect)


