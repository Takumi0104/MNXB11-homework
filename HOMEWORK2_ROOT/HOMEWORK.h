//
//  homework.h
//  ROOT_homework
//
//  Created by Negoro Takumi on 2024/11/05.
//
//include guards: check the problem "double inclusion"
//#ifndef test returns false, the preprocessor skips down to the #endif
#ifndef __HOMEWORK_H__
#define __HOMEWORK_H__


#include <TObject.h>
#include <TVector3.h>

class HOMEWORK : public TObject {
    
    // the difference between struct and class
    // struct: all members are "public" by default
    // class: all members are "private" by default
 public :
    //constructer: a member of function of a class that has the same name as the class name
    //It helps to intialize the object of a class
    //It can either accept the argument or not
    HOMEWORK();
    //constructer (parametize)
    HOMEWORK(Int_t ev, Double_t px, Double_t py, Double_t pz );
    
    virtual ~HOMEWORK();
    Double_t Phi();
    Double_t Pt();
    
    Double_t Px() const { return px; }
    Double_t Py() const { return py; }
    Double_t Pz() const { return pz; }
 private :
    Int_t ev;
    Double_t px;
    Double_t py;
    Double_t pz;
    
    TVector3 *L;
    void InitializeVector();
    
    ClassDef(HOMEWORK, 1);//
};

#endif // __HOMEWORK_H__


//syntax: constructer
//class Name()
//{
//Constructer's body
//}
